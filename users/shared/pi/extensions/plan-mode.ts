import type { CustomEntry, ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent"

const PLAN_MODE_TOOLS = ["read", "bash", "grep", "find", "ls"]
const NORMAL_MODE_TOOLS = ["read", "bash", "edit", "write"]
const PLAN_MODE_DISABLED_TOOLS = new Set<string>(["edit", "write"])
const PLAN_MANAGED_TOOLS = new Set<string>([...PLAN_MODE_TOOLS, ...NORMAL_MODE_TOOLS])

const TOGGLE_SHORTCUT = "tab"

interface PlanModeState {
  enabled: boolean
  toolsBeforePlanMode?: string[]
}

export default function planModeExtension(pi: ExtensionAPI): void {
  let planModeEnabled = true
  let toolsBeforePlanMode: string[] | undefined

  function updateStatus(ctx: ExtensionContext): void {
    if (planModeEnabled) {
      ctx.ui.setStatus("plan-mode", ctx.ui.theme.fg("warning", "⏸ plan"))
    } else {
      ctx.ui.setStatus("plan-mode", undefined)
    }
  }

  function uniqueToolNames(toolNames: string[]): string[] {
    return [...new Set(toolNames)]
  }

  function getPlanModeTools(activeToolNames: string[]): string[] {
    return uniqueToolNames([
      ...activeToolNames.filter((name) => !PLAN_MODE_DISABLED_TOOLS.has(name)),
      ...PLAN_MODE_TOOLS,
    ])
  }

  function getNormalModeTools(activeToolNames: string[]): string[] {
    return uniqueToolNames([
      ...NORMAL_MODE_TOOLS,
      ...activeToolNames.filter((name) => !PLAN_MANAGED_TOOLS.has(name)),
    ])
  }

  function enablePlanModeTools(): void {
    if (toolsBeforePlanMode === undefined) {
      toolsBeforePlanMode = pi.getActiveTools()
    }
    pi.setActiveTools(getPlanModeTools(toolsBeforePlanMode))
  }

  function restoreNormalModeTools(): void {
    pi.setActiveTools(toolsBeforePlanMode ?? getNormalModeTools(pi.getActiveTools()))
    toolsBeforePlanMode = undefined
  }

  function persistState(): void {
    pi.appendEntry("plan-mode", {
      enabled: planModeEnabled,
      toolsBeforePlanMode,
    })
  }

  function togglePlanMode(ctx: ExtensionContext): void {
    planModeEnabled = !planModeEnabled

    if (planModeEnabled) {
      enablePlanModeTools()
      ctx.ui.notify("Plan mode enabled. Built-in write tools disabled.")
    } else {
      restoreNormalModeTools()
      ctx.ui.notify("Plan mode disabled. Full access restored.")
    }
    updateStatus(ctx)
    persistState()
  }

  pi.registerCommand("plan", {
    description: "Toggle plan mode (read-only exploration)",
    handler: async (_args, ctx) => togglePlanMode(ctx),
  })

  pi.registerShortcut(TOGGLE_SHORTCUT, {
    description: "Toggle plan mode",
    handler: async (ctx) => togglePlanMode(ctx),
  })

  pi.on("context", async (event) => {
    if (planModeEnabled) return

    return {
      messages: event.messages.filter((m) => {
        if ("customType" in m && m.customType === "plan-mode-context") return false
        if (m.role !== "user") return true

        const content = m.content
        if (typeof content === "string") {
          return !content.includes("[PLAN MODE ACTIVE]")
        }
        if (Array.isArray(content)) {
          return !content.some((c) => c.type === "text" && c.text.includes("[PLAN MODE ACTIVE]"))
        }
        return true
      }),
    }
  })

  pi.on("before_agent_start", async () => {
    if (planModeEnabled) {
      return {
        message: {
          customType: "plan-mode-context",
          content: `[PLAN MODE ACTIVE]
You are in plan mode - a read-only exploration mode.

Restrictions:
- Built-in edit and write tools are disabled
- Bash is for reading only (grep, ls, git log, cat...) - never modify anything

Ask clarifying questions if anything is unsure.

If the request only asks a question about the code, just answer it.

If the request requires changes, investigate as needed and produce a
numbered plan under a "Plan:" header with concrete, actionable steps -
the plan will be executed after approval:

Plan:
1. First step description
2. Second step description
...`,
          display: false,
        },
      }
    }
  })

  pi.on("session_start", async (_event, ctx) => {
    const entries = ctx.sessionManager.getEntries()

    const planModeEntry = entries.findLast(
      (e): e is CustomEntry<PlanModeState> => e.type === "custom" && e.customType === "plan-mode",
    )

    if (planModeEntry?.data) {
      planModeEnabled = planModeEntry.data.enabled ?? planModeEnabled
      toolsBeforePlanMode = planModeEntry.data.toolsBeforePlanMode ?? toolsBeforePlanMode
    }

    if (planModeEnabled) {
      enablePlanModeTools()
    }
    updateStatus(ctx)
  })
}
