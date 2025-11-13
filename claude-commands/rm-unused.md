# rm-unused

Find and remove dead code and unused imports.

## Instructions

1. Identify the language/framework to determine appropriate tools:
   - JavaScript/TypeScript: Use `ts-prune`, or analyze imports
   - Python: Use AST analysis or grep patterns
   - Other languages: Use language-specific tools
2. Search for:
   - **Unused imports**: Imported modules/functions never referenced
   - **Unused variables**: Declared but never read
   - **Unused functions**: Defined but never called
   - **Unreachable code**: Code after returns or in impossible conditions
   - **Dead exports**: Exported but never imported elsewhere
3. For each finding:
   - Verify it's truly unused (check tests, configs, dynamic imports)
   - Present the finding to the user with file location
   - Ask for confirmation before removing
4. Remove confirmed dead code while:
   - Preserving code structure and readability
   - Being careful with exports (might be used by external consumers)
   - Checking if removal affects tests
5. Run linting and tests after removal to verify nothing broke.
6. Summarize what was removed and any potential issues found.
7. Note any suspicious patterns that might indicate bugs (e.g., variables set but never used).
