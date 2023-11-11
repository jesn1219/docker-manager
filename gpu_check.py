import subprocess
import time
from jesnk_utils.telebot import Telebot
import sys

alpha = Telebot()

def get_gpu_memory():
    # Query for the amount of GPU memory used via nvidia-smi command
    result = subprocess.run(['nvidia-smi', '--query-gpu=memory.used', '--format=csv,noheader,nounits'], 
                            capture_output=True, text=True)
    # Capture the output and convert to integer
    gpu_memory_used = int(result.stdout.strip())
    return gpu_memory_used


if __name__ == '__main__' :
    message = f'GPU memory check module started'
    alpha.send_message(message)
    gpu_memory_used = get_gpu_memory()
    current_memory_str = str(gpu_memory_used)
    message = f'GPU memory usage is {current_memory_str}MB'
    alpha.send_message(message)

    # Loop to continuously check GPU memory usage
    while True:
        gpu_memory_used = get_gpu_memory()
        # Check if the GPU memory used is less than 500MB
        if gpu_memory_used < 8000 :
            current_memory_str = str(gpu_memory_used)
            message = f'GPU memory usage is {current_memory_str}MB'
            alpha.send_message(message)
            sys.exit(0)
            break
        time.sleep(3)  # Wait for 1 second before the next check

