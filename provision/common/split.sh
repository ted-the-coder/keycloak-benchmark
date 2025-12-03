#!/usr/bin/env bash
set -euo pipefail
yq --help > /dev/null
mkdir -p .task
rm -f .task/subtask-*.yaml
# Capture the keys into a shell variable using raw output and newlines
TASK_KEYS=$(yq -r e '.tasks | keys | .[]' Taskfile.yaml)

# Iterate over the variable content
for i in $TASK_KEYS; do
   echo "Processing task: ${i}"
   # Write the subtask file normally
   yq -M e ".tasks.${i}" Taskfile.yaml > .task/subtask-${i}.yaml
done

TASK_KEYS=$(yq -r e '.tasks | keys | .[]' ../common/Taskfile.yaml)
for i in $TASK_KEYS; do
   echo "Processing task: ${i}"
   # Write the subtask file normally
   yq -M e ".tasks.${i}" ../common/Taskfile.yaml > .task/subtask-${i}.yaml
done
