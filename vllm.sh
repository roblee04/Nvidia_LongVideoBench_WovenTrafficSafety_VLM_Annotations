#!/bin/bash

cd ~/robin

source ".venv/bin/activate"

# Native 256K context, expandable to 1M. Reduce if there is high memory usage.
export CONTEXT_LENGTH=256000
export VLLM_USE_V1=0


# Can Switch between Instruct and Thinking models
# vllm serve QuantTrio/Qwen3-VL-30B-A3B-Instruct-AWQ --allowed-local-media-path /home/omni/robin --enforce-eager --quantization awq   --served-model-name MY_MODEL   --swap-space 4   --max-num-seqs 8   --max-model-len $CONTEXT_LENGTH   --gpu-memory-utilization 0.9   --tensor-parallel-size 2  --async-scheduling --trust-remote-code   --disable-log-requests --allowed-local-media-path /home/omni/robin   --host 0.0.0.0   --port 8000
vllm serve QuantTrio/Qwen3-VL-30B-A3B-Thinking-AWQ  --allowed-local-media-path /home/omni/robin --enforce-eager --quantization awq --served-model-name MY_MODEL   --swap-space 4   --max-num-seqs 8   --max-model-len $CONTEXT_LENGTH   --gpu-memory-utilization 0.9   --tensor-parallel-size 2  --async-scheduling --trust-remote-code   --disable-log-requests --allowed-local-media-path /home/omni/robin   --host 0.0.0.0   --port 8000