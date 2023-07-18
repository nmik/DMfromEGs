#!/bin/bash
#Run likelihood stacking from SED outputs and interpret in DM space

#Assumes 	- directories for each target including data listed in file 'ft1.fits' 
#Inputs 	- Target name, black hole mass (1e8 solar masses) and distance (Mpc) 
#			_ Code pulls in computed SEDs from given targets
#Outputs 	- .npy file of DM likelihood values for each combination of DM mass/crossSection in <TARGET>/output/plots/dloglike
#			- likelihood plots in DM mass/crossSection space for every individual entry in <TARGET>/output/plots/
#			- likelihood plot of all entries in <TARGETS> stacked together in top level directory

# python schnittamn_likelihood_DM.py <target> <M_BH> <distance>

targets=("NGC4889" "NGC4649" "NGC1407")
m_bh=(208.0 47.3 46.5) #1e8 solar masses
distance=(102.0 16.5 29.0) #Mpc

for i in ${!targets[@]}; do
  python breakdown__schnittman_likelihood_DM.py ${targets[$i]} ${m_bh[$i]} ${distance[$i]} 0 4 40 -28 -22 60
done

python breakdown__plot_TSmaps_stack.py stackingTargets.txt 0 4 40 -28 -22 60