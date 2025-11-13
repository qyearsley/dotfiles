# Claude Code Commands

Custom slash commands for [Claude Code](https://docs.claude.com/en/docs/claude-code/overview). These enhance Claude's capabilities with project-specific workflows.

## Setup

Place these files in your project's `.claude/commands/` directory, or in `~/.config/claude/commands/` for global commands.

## Available Commands

### Development Workflow
- `/create-command` - Create a new Claude Code slash command
- `/refactor-file` - Refactor a file with best practices
- `/test-file` - Generate comprehensive tests for a file
- `/rm-unused` - Remove unused code and dependencies

### Documentation
- `/proofread-docs` - Review documentation for clarity and consistency

### Dependency Management
- `/node-deps-update` - Update Node.js dependencies safely
- `/python-deps-update` - Update Python dependencies safely

### Git Workflows
- `/worktree` - Create and manage git worktrees for parallel work

## Usage

Type `/command-name` in Claude Code to invoke a command. Commands can include parameters and instructions for specific workflows.
