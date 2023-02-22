# Stacking analysis to search for DM from EGs


## Running stacking analysis 

### Setup
1. Define which targets to consider (Consider viable sources that pass overlap removal in `../overlap/`)
2. Download Fermi data for each target and save in a dir named with the target name in `../data/`
	- Include 15deg search radius
	- 12 years of Fermi data, MET time range (239557417,691545605)
	- Energy range MeV (1000,1000000)
	- Ensure one spacecraft (SC) file is downloaded, but only one is necessary. This is stored in `../data/` outside of a target directory
3. In each directory with source data, define the file `ft1.fits` that lists all data files
4. If no `ltcube` file exists, generate one 
	- Using the SC file in `../data/` and one example target with known RA/dec, run:
		cd run
		python make_ltcube.py <target> <RA> <dec>
	- Save `ltcube` output in `../data/` with the SC file

### Fermipy joint likelihood fitting and SED
1. Move to `run/`
	cd run
2. Ensure Fermipy/fermitools are installed/usable (eg. activate a conda environment)
3. Update bash steering file `run_preprocess_sed.sh`
	- Update arrays of targets and their associated RA / dec
4. Update hardcoded file paths in `preprocess_likelihoodFitting.py`
	- Point `homedir` to this git repo space (where `run/` and `data/` are stored)
	- Point paths to diffuse models (for variables `galdiff` and `isodiff`)
5. Update hardcoded paths in `get_sed.py`
	- Point `preprocessing_path` to the `run/` dir
5. Run bash file which calls `preprocess_likelihoodFitting.py` and `get_sed.py`
	source run_preprocess_sed.sh
	- All outputs are saved to directories in `run/` named after the target. If the directory does not exist, it will be created
	- These directories are organized as follows:
		- main dir space stores configuration file (<target>.yaml), fermipy log file, and txt file of output fit parameters
		- `output/` contains all output files from fermipy including fit results (*.fits, *.npy), source finding, the resulting SED results, etc
		- `output/plots/` contains debugging plots from likelihood fitting and SED creation
