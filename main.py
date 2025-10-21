"""
Description :   This is the head file of the project
Author      :   Ruidi Qiu (ruidi.qiu@tum.de)
Time        :   2023/11/28 11:19:59
LastEdited  :   2024/8/29 21:43:15
"""

import loader_saver as ls
from config import Config
import config
import LLM_call as gpt
import autoline as al
import iverilog_call as iv
import getopt
import sys
import yaml
from config import CFG_CUS_PATH

def main(custom_cfg_path: str = CFG_CUS_PATH):
    
    # my_config = cfg.load_config(custom_cfg_path)
    # my_config = ls.add_save_root_to(my_config)
    my_config = Config(custom_cfg_path)
    ls.add_save_root_to(my_config)
    logger = ls.AutoLogger() # initialize the autologger
    logger.info("all configurations are loaded, starting the main process...")
    match my_config.run.mode:
        case "chatgpt":
            gpt.run_like_a_chatgpt()
        case "iverilog":
            iv.run_iverilog()
        case "autoline":
            al.run_autoline()
        # case "dataset_manager":
        #     pass # TODO
        case _:
            raise ValueError("Invalid run mode: " + my_config.run.mode)
    print("Done!\n\n")

if __name__ == "__main__":
    # if no command, run the main function main()
    # if -h/--help, print the help message
    # if -c/--config + str, first get the custom config path, then run the main function
    # if -m/--model + str, update model configuration and run

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hc:m:p:", ["help", "config=", "model=", "parallelism="])
    except getopt.GetoptError as err:
        print(err)
        sys.exit(2)
    
    config_path = CFG_CUS_PATH
    model_type = None
    parallelism = None
    
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print("""
CorrectBench - Automatic Testbench Generation Framework

Usage: python main.py [OPTIONS]

Options:
  -h, --help              Show this help message
  -c, --config PATH       Use custom config file (default: config/custom.yaml)
  -m, --model MODEL       Set model type: 'gpt' or 'qwen' (default: current config)
  -p, --parallelism N     Set concurrency level for vLLM (default: 1, use 8 for dp=8 vLLM)

Examples:
  python main.py -c demo                    # Run with demo config
  python main.py -m gpt                     # Use GPT-4o model
  python main.py -m qwen                    # Use Qwen3-8B model
  python main.py -c demo -m qwen            # Use demo config with Qwen3-8B
  python main.py -p 8                       # Use 8 parallel workers (for dp=8 vLLM)
  python main.py -m qwen -p 8               # Use Qwen3-8B with 8 parallel workers
            """)
            sys.exit(0)
        elif opt in ("-c", "--config"):
            config_path = config.get_cfg_path_from_alias(arg)
        elif opt in ("-m", "--model"):
            model_type = arg.lower()
        elif opt in ("-p", "--parallelism"):
            try:
                parallelism = int(arg)
                if parallelism < 1:
                    print(f"❌ Invalid parallelism: {parallelism}. Must be >= 1")
                    sys.exit(1)
            except ValueError:
                print(f"❌ Invalid parallelism: {arg}. Must be an integer")
                sys.exit(1)
    
    # Update model configuration if specified
    if model_type:
        # Load and update config
        with open(config_path, 'r') as f:
            cfg = yaml.safe_load(f)
        
        if model_type == "gpt":
            cfg['gpt']['model'] = "gpt-4o-2024-08-06"
            cfg['gpt']['rtlgen_model'] = "gpt-4o-2024-08-06"
            print("✅ Using GPT-4o model")
        elif model_type == "qwen":
            cfg['gpt']['model'] = "/home/nvidia/data/models/Qwen3-8B"
            cfg['gpt']['rtlgen_model'] = "/home/nvidia/data/models/Qwen3-8B"
            print("✅ Using Qwen3-8B model")
        else:
            print(f"❌ Invalid model: {model_type}. Use 'gpt' or 'qwen'")
            sys.exit(1)
        
        with open(config_path, 'w') as f:
            yaml.dump(cfg, f, default_flow_style=False)
    
    # Update parallelism configuration if specified
    if parallelism is not None:
        # Load and update config
        with open(config_path, 'r') as f:
            cfg = yaml.safe_load(f)
        
        # Add or update concurrency in gpt section
        if 'gpt' not in cfg:
            cfg['gpt'] = {}
        cfg['gpt']['concurrency'] = parallelism
        print(f"✅ Using parallelism level: {parallelism}")
        
        with open(config_path, 'w') as f:
            yaml.dump(cfg, f, default_flow_style=False)
    
    # Run main function
    main(config_path)
    sys.exit(0)