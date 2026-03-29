#

For current PowerShell session:

     1 $env:OPENAI_API_KEY = "not-needed"

    For permanent system-wide setting (run PowerShell as Administrator):

     1 [System.Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'not-needed', 'Machine')

    Or for user-level setting:

     1 [System.Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'not-needed', 'User')

#

(base) yassoumou@2a01cb080c5c1000949b9b4c6e8b198e:~/llama.cpp$ ./build/bin/llama-server --model /mnt/nvme_storage/.lmstudio/models/lmstudio-community/unsloth/Qwen3.5-35B-A3B-GGUF/Qwen3.5-35B-A3B-UD-MXFP4_MOE.gguf --mmproj /mnt/nvme_storage/.lmstudio/models/lmstudio-community/unsloth/Qwen3.5-35B-A3B-GGUF/mmproj-F16.gguf --alias "qwen35-moe-35b" --ctx-size 262144 --n-gpu-layers 999 --jinja --seed 3407 --temp 0.6 --top-p 0.95 --top-k 40 --min-p 0.01 --threads 20 --batch-size 4096 --ubatch-size 1536 --host 0.0.0.0 --port 8070 --no-mmap --parallel 1 --no-context-shift --cache-ram -1 --keep -1 --cache-type-k q8_0 --cache-type-v q8_0

#

(base) yassoumou@2a01cb080c5c1000949b9b4c6e8b198e:~/llama.cpp$ ./build/bin/llama-server --model /mnt/nvme_storage/.lmstudio/models/lmstudio-community/unsloth/Qwen3-Coder-Next-GGUF/UD-Q6_K_XL\ \(3\ éléments\)/UD-Q6_K_XL/Qwen3-Coder-Next-UD-Q6_K_XL-00001-of-00003.gguf --alias "qwen3-coder-next" --ctx-size 262144 --n-gpu-layers 999 --jinja --temp 1.0 --top-p 0.95 --top-k 40 --min-p 0.01 --threads 20 --batch-size 4096 --ubatch-size 1536 --host 0.0.0.0 --port 8080 --no-mmap --parallel 1 --no-context-shift --cache-ram -1 --keep -1 --cache-type-k q8_0 --cache-type-v q8_0
