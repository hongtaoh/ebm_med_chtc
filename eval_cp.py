from alabebm import run_ebm, get_biomarker_order_path
import os
import sys
import json 

if __name__ == "__main__":

    base_dir = os.getcwd()
    print(f"Current working directory: {base_dir}")
    data_dir = os.path.join(base_dir, "data")

    # Get path to biomarker_order
    biomarker_order_json = get_biomarker_order_path()

    with open(biomarker_order_json, 'r') as file:
        biomarker_order = json.load(file)

    # Read parameters from command line arguments
    j = sys.argv[1]
    r = sys.argv[2]

    print(f"Processing with j={j}, r={r}")

    filename = f"{j}_{r}"
    data_file = f"{data_dir}/{filename}.csv"

    if not os.path.isfile(data_file):
        print(f"Error: Data file {data_file} does not exist.")
        sys.exit(1)

    results = run_ebm(
        data_file=data_file,
        algorithm='conjugate_priors',
        n_iter=20000,
        n_shuffle=2,
        burn_in=10000,
        thinning=20,
    )