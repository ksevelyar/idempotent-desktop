import type { ExtensionAPI } from "@earendil-works/pi-coding-agent"
import { Type } from "typebox"

const DEFAULT_MAX_CHARS = 50_000

type HtmlRule = [RegExp, string | ((...args: any[]) => string)]

function applyRule(text: string, [pattern, replacement]: HtmlRule): string {
  return typeof replacement === "string"
    ? text.replace(pattern, replacement)
    : text.replace(pattern, replacement)
}

const HTML_RULES: HtmlRule[] = [
  [/<!--[\s\S]*?-->/g, " "],
  [/<(script|style|noscript|svg|head)[\s\S]*?<\/\1>/gi, " "],
  [/<(br|p|div|li|tr|h[1-6])\b[^>]*>/gi, "\n"],
  [/<[^>]+>/g, " "],
]

const ENTITY_RULES: HtmlRule[] = [
  [/&nbsp;/gi, " "],
  [/&amp;/gi, "&"],
  [/&lt;/gi, "<"],
  [/&gt;/gi, ">"],
  [/&quot;/gi, '"'],
  [/&#39;/gi, "'"],
  [/&#(\d+);/g, (_, code: string) => String.fromCodePoint(Number(code))],
]

async function fetchBody(url: string): Promise<{ contentType: string; body: string }> {
  const response = await fetch(url, {
    signal: AbortSignal.timeout(20_000),
    headers: { "User-Agent": "pi-web-fetch/1.0" },
  })
  if (!response.ok) {
    throw new Error(`HTTP ${response.status} ${response.statusText} for ${url}`)
  }
  return {
    contentType: response.headers.get("content-type") ?? "",
    body: await response.text(),
  }
}

function stripHtml(html: string): string {
  return [...HTML_RULES, ...ENTITY_RULES]
    .reduce(applyRule, html)
    .replace(/[ \t]+/g, " ")
    .replace(/\n\s*\n+/g, "\n")
    .trim()
}

async function fetchAndStrip(url: string, maxChars: number): Promise<string> {
  const { contentType, body } = await fetchBody(url)
  const text = contentType.includes("html") ? stripHtml(body) : body.trim()
  return text.slice(0, maxChars)
}

export default function webFetchExtension(pi: ExtensionAPI): void {
  pi.registerTool({
    name: "web_fetch",
    label: "Web Fetch",
    description:
      "Fetch a URL and return the body as text. HTML is stripped to readable text, other content types are returned as-is.",
    parameters: Type.Object({
      url: Type.String({ description: "Absolute http:// or https:// URL" }),
      maxChars: Type.Optional(
        Type.Number({ description: "Max characters to return (default 50000)" }),
      ),
    }),
    execute: async (_toolCallId, params) => {
      const maxChars =
        params.maxChars && params.maxChars > 0 ? Math.floor(params.maxChars) : DEFAULT_MAX_CHARS
      try {
        return {
          content: [{ type: "text", text: await fetchAndStrip(params.url, maxChars) }],
          details: {},
        }
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error)
        return { content: [{ type: "text", text: `web_fetch failed: ${message}` }], details: {} }
      }
    },
  })
}
