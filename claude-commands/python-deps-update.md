# python-deps-update

Interactively update Python dependencies to newer versions safely.

## Instructions

1. Identify the Python dependency management tool:
   - Check for `pyproject.toml` (Poetry, uv, or modern pip)
   - Check for `requirements.txt` or `requirements/*.txt`
   - Check for `Pipfile` (Pipenv)
   - Check for `setup.py` or `setup.cfg`
2. List current dependencies and check for available updates:
   - For Poetry: `poetry show --outdated`
   - For pip: `pip list --outdated`
   - For uv: `uv pip list --outdated`
   - For Pipenv: `pipenv update --outdated`
3. Present the outdated packages to the user with their current and latest versions.
4. Ask the user which packages they want to update.
5. For each package to update:
   - Update the dependency specification
   - Install the new version
   - Run tests to verify nothing broke
   - If tests fail, revert the update and note the issue
6. Summarize successful and failed updates.
7. Suggest running the full test suite if significant updates were made.
