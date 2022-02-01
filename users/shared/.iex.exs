IEx.configure(
  colors: [
    enabled: true,
    eval_result: [:cyan, :bright],
    eval_error: [:light_magenta, :bright]
  ],
  default_prompt:
    [
      IO.ANSI.blue(),
      "%prefix",
      IO.ANSI.green() <> " %counter ",
      IO.ANSI.reset()
    ]
    |> IO.chardata_to_string()
)
