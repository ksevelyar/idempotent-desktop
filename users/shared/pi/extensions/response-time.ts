import type { SessionMessageEntry } from "@earendil-works/pi-coding-agent"
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent"

export default function responseTimeExtension(pi: ExtensionAPI): void {
  let startTime: number | undefined

  function formatDuration(ms: number): string {
    const totalSeconds = Math.floor(ms / 1000)
    if (totalSeconds < 60) return `${totalSeconds}s`
    const minutes = Math.floor(totalSeconds / 60)
    const seconds = totalSeconds % 60
    return `${minutes}m ${seconds.toString().padStart(2, "0")}s`
  }

  function setStatus(ctx: ExtensionContext, text: string | undefined): void {
    ctx.ui.setStatus("response-time", text)
  }

  function showElapsed(ctx: ExtensionContext): void {
    if (startTime !== undefined) {
      setStatus(ctx, ctx.ui.theme.fg("muted", `⏱ ${formatDuration(Date.now() - startTime)}`))
    }
  }

  pi.on("agent_start", async () => {
    startTime = Date.now()
  })

  pi.on("message_update", async (_event, ctx) => {
    showElapsed(ctx)
  })

  pi.on("tool_execution_end", async (_event, ctx) => {
    showElapsed(ctx)
  })

  pi.on("agent_end", async (_event, ctx) => {
    showElapsed(ctx)
    startTime = undefined
  })

  pi.on("session_start", async (_event, ctx) => {
    const messages = ctx.sessionManager
      .getEntries()
      .filter((e): e is SessionMessageEntry => e.type === "message")
      .map((e) => e.message)

    const lastUser = messages.findLast((m) => m.role === "user")
    const lastAssistant = messages.findLast((m) => m.role === "assistant")

    if (lastUser && lastAssistant && lastAssistant.timestamp > lastUser.timestamp) {
      setStatus(
        ctx,
        ctx.ui.theme.fg(
          "muted",
          `⏱ ${formatDuration(lastAssistant.timestamp - lastUser.timestamp)}`,
        ),
      )
    }
  })
}
