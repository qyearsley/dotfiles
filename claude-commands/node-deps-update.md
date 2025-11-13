# node-deps-update

Interactively update Node.js dependencies to newer versions safely.

## Instructions

1. Check for package manager (npm, yarn, pnpm, bun) by looking for lock files.
2. List outdated packages:
   - For npm: `npm outdated`
   - For yarn: `yarn outdated`
   - For pnpm: `pnpm outdated`
   - For bun: `bun outdated`
3. Present outdated packages with current, wanted, and latest versions.
4. Ask the user which packages they want to update.
5. For each package to update:
   - Update the package using appropriate command
   - Run tests to verify nothing broke
   - Run build if applicable
   - If tests/build fail, revert the update and note the issue
6. Consider updating devDependencies separately from dependencies.
7. Warn about major version updates that might have breaking changes.
8. Summarize successful and failed updates.
