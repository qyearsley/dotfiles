# refactor-file

Refactor a specific file to improve code quality and maintainability.

## Instructions

1. Ask the user which file to refactor if not specified.
2. Read and analyze the file for:
   - Long functions (> 50 lines) that should be broken down
   - Repeated code that could be extracted
   - Complex conditional logic that could be simplified
   - Poor naming that doesn't reveal intent
   - Violations of single responsibility principle
   - Hard-coded values that should be constants
   - Missing type annotations (for typed languages)
3. Present the refactoring opportunities found and ask which ones to apply.
4. Apply the approved refactorings while:
   - Preserving all existing behavior
   - Maintaining or improving readability
   - Following language-specific best practices
   - Keeping changes focused and incremental
5. After refactoring, suggest running tests to verify behavior is unchanged.
6. Summarize the improvements made.
