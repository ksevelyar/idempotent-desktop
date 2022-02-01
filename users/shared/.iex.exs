IEx.configure(
  colors: [
    enabled: true,
    eval_result: [:cyan, :bright],
    eval_error: [:light_magenta]
  ],
  default_prompt:
    [
      # a pale gold
      "\r\e[38;5;220m",
      # IEx context
      "%prefix",
      # forest green expression count
      "\e[38;5;112m(%counter)",
      # gold ">"
      "\e[38;5;220m>",
      # and reset to default color
      "\e[0m"
    ]
    |> IO.chardata_to_string()
)
