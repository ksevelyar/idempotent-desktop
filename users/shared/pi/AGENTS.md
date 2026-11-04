* Ask questions if anything is unclear, never guess.

## Env
* flake deps have priority over nixpkgs

## Style
* Write self descriptive code, never abbreviate and never add comments: every local binding, function, and namespace gets a full descriptive name like minimum_kick_speed, not min_kick.
* Name every non-obvious value with a local binding at its place of use, so functions stay whole and readable.
* Start function names with a verb.
* Extract a constant to the top of the file only when at least two places use it; never move a single-use value out of its function body.

## Documentation
* When writing markdown, avoid em dashes, bold, italics, semicolons and →, do not insert an empty line after a heading, use #, ##, and ### for heading structure, and use * for list markers.
* be very concise, every word matters
