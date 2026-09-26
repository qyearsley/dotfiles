# Improvements

This file is the maintenance backlog: defects, debt, test gaps and doc drift.

## At a glance

Nothing open.

## Working on these

- Lint and CI: `.github/workflows/` runs the checks; there is no test suite.
- Sync: `scripts/sync.sh status` reports drift, `to` deploys, `from` captures.
  Run `status` first; it exits 1 when anything differs.
- Public repo. Never commit a work hostname, address, tool name or ticket ID.

## Not looked at

`starship.toml`, and the rest of `config-nvim` beyond the telescope pin fixed
2026-09-26. Nothing here was verified by running `scripts/sync.sh` against a
second machine.

---

`S` under an hour · `M` half a day · `L` more, or needs a decision. State is
`open`, `decision owed`, or `blocked on <thing>`. Every claim carries its
evidence and a date; say so when something was not verified.
