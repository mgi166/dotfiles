#!/usr/bin/env bash

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -n "$COMMAND" ]; then
  DETAIL="$COMMAND"
elif [ -n "$FILE_PATH" ]; then
  DETAIL="$FILE_PATH"
else
  DETAIL=""
fi

osascript -e "display notification \"${DETAIL}\" with title \"Claude Code\" subtitle \"${TOOL_NAME} の承認を待っています\" sound name \"Glass\""
