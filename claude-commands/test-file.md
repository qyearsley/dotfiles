# test-file

Generate comprehensive tests for a specific file.

## Instructions

1. Ask the user which file to test if not specified.
2. Read the file and identify:
   - All exported functions/classes/components
   - Edge cases and boundary conditions
   - Error handling paths
   - Integration points with other modules
3. Determine the testing framework:
   - For JavaScript/TypeScript: Jest, Vitest, Mocha, etc.
   - For Python: pytest, unittest
   - For other languages: check existing test files
4. Check existing tests for the file to avoid duplication.
5. Generate tests that:
   - Cover all public functions/methods
   - Test happy paths and error cases
   - Use clear, descriptive test names
   - Follow existing test patterns in the codebase
   - Include setup/teardown as needed
   - Mock external dependencies appropriately
6. Place tests in the appropriate location following project conventions.
7. Run the new tests to verify they pass.
8. Report test coverage if available.
