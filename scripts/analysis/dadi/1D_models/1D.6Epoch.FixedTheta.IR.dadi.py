# -*- coding: utf-8 -*-
"""
Created on Tue Oct 16 16:46:27 2018
@author: annabelbeichman
"""
import matplotlib
matplotlib.use('Agg') # so graphics show up on hoffman
import sys
import argparse
import dadi
from dadi import Numerics, PhiManip, Integration, Spectrum
from numpy import array # don't comment this out
import datetime
todaysdate=datetime.datetime.today().strftime('%Y%m%d')


modelName="1D.6Epoch.FixedTheta.IR"

############### Parse input arguments ########################
parser = argparse.ArgumentParser(description='Infer a '+ modelName +' model from a 1D folded SFS in dadi')
parser.add_argument("--runNum",required=True,help="iteration number (e.g. 1-50)")
parser.add_argument("--pop",required=True,help="population identifier, e.g. 'CA'")
parser.add_argument("--mu",required=True,help="supply mutation rate in mutation/bp/gen")
parser.add_argument("--L",required=True,help="number of called neutral sites that went into making SFS (monomorphic+polymorphic)")
parser.add_argument("--sfs",required=True,help="path to folded SFS in dadi format that is output from easySFS pipeline (mask optional)")
parser.add_argument("--outdir",required=True,help="path to output directory")
# usage:
# python 1D.Bottleneck.dadi.py --runNum $i --pop CA --mu 8.64411385098638e-09 --L 4193488 --sfs [path to sfs] --outdir [path to outdir]
args = parser.parse_args()
runNum=str(args.runNum)
pop=str(args.pop)
mu=float(args.mu)
L=float(args.L)
outdir=str(args.outdir)
sfs=str(args.sfs)
maxiter=100
############### Input data ####################################
# for testing purposes:
#sfs="/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/datafiles/SFS/20180806/neutralSFS/CA.all_9.unfolded.sfs.dadi.format.20181105.txt"
fs=dadi.Spectrum.from_file(sfs) # this is folded from easySFS
# fold the fs:# fs=fs.fold() # folded
# check if it's folded, if not folded, fold it
if fs.folded==False:
    fs=fs.fold()
else:
    fs=fs
############### Set up General Dadi Parameters ########################
ns = fs.sample_sizes # get sample size from SFS (in haploids)
pts_l = [ns[0]+5,ns[0]+15,ns[0]+25] # this should be slightly larger (+5) than sample size and increase by 10
############### Set up Specific Model -- this will change from script to script ########################

theta1=189600
def sixEpoch(params, ns, pts): 
    t4,nu4,t5,nu5 = params
    xx = Numerics.default_grid(pts) # sets up grid
    phi = PhiManip.phi_1D(xx,theta0 = theta1) # sets up initial phi for population 
    phi = Integration.one_pop(phi, xx, 0.26, 1.87, theta0 = theta1)  
    phi = Integration.one_pop(phi, xx, 0.0055, 0.04, theta0 = theta1) 
    phi = Integration.one_pop(phi, xx, 0.037,21, theta0 = theta1)  
    phi = Integration.one_pop(phi, xx, t4, nu4, theta0 = theta1)
    phi = Integration.one_pop(phi, xx, t5, nu5, theta0 = theta1)
    fs = Spectrum.from_phi(phi, ns, (xx,)) 
    return fs
param_names=("t4","nu4","t5","n5")

upper_bound = [0.00041,0.1,0.00041,0.1] 
lower_bound = [0.00039,1e-4,0.00039,1e-4]
p0 = [0.0004,0.01,0.0004,0.01]



func=sixEpoch # set the function

############### Carry out optimization (same for any model) ########################
# Make extrapolation function:
func_ex = dadi.Numerics.make_extrap_log_func(func)
# perturb parameters
p0 = dadi.Misc.perturb_params(p0, fold=1, upper_bound=upper_bound,                                  lower_bound=lower_bound) 
# optimize: 
print('Beginning optimization ************************************************')
popt = dadi.Inference.optimize_log(p0, fs, func_ex, pts_l, 
                                   lower_bound=lower_bound,
                                   upper_bound=upper_bound,
                                   verbose=len(p0), maxiter=maxiter)
print('Finshed optimization **************************************************')                                   
                                   
# Calculate the best-fit model AFS. 
model = func_ex(popt, ns, pts_l)
# Likelihood of the data given the model AFS.
ll_model = dadi.Inference.ll_multinom(model, fs)

# and get lhood of the data
ll_data = dadi.Inference.ll_multinom(fs, fs)
# calculate best fit theta
theta = dadi.Inference.optimal_sfs_scaling(model, fs)

###### model specific scaling of parameters (will depend on mu and L that you supply) #######
# param_names=("nuB","nuF","TF")
Nanc=theta1 / (4*mu*L)
t4_scaled_gen=popt[0]*Nanc*2
nu4_scaled_dip=popt[1]*Nanc
t5_scaled_gen=popt[2]*Nanc*2
nu5_scaled_dip=popt[3]*Nanc
scaled_param_names=("Nanc_FromTheta_scaled_dip","t4_scaled_gen","nu4_scaled_dip","t5_scaled_gen","nu5_scaled_dip")
scaled_popt=(Nanc,t4_scaled_gen,nu4_scaled_dip,t5_scaled_gen,nu5_scaled_dip)


############### Write out output (same for any model) ########################
print('Writing out parameters **************************************************')                                   

outputFile=open(str(outdir)+"/"+str(pop)+".dadi.inference."+str(modelName)+".runNum."+str(runNum)+".output","w")
# get all param names:
param_names_str='\t'.join(str(x) for x in param_names)
scaled_param_names_str='\t'.join(str(x) for x in scaled_param_names)
header=param_names_str+"\t"+scaled_param_names_str+"\ttheta\tLL\tLL_data\tmodelFunction\tmu\tL\tmaxiter\trunNumber\trundate\tinitialParameters\tupper_bound\tlower_bound" # add additional parameters theta, log-likelihood, model name, run number and rundate
popt_str='\t'.join(str(x) for x in popt) # get opt'd parameters as a tab-delim string
scaled_popt_str='\t'.join(str(x) for x in scaled_popt)
# joint together all the output fields, tab-separated:
output=[popt_str,scaled_popt_str,theta1,ll_model,ll_data,func.func_name,mu,L,maxiter,runNum,todaysdate,p0,upper_bound,lower_bound] # put all the output terms together
output='\t'.join(str(x) for x in output) # write out all the output fields
# this should result in a 2 row table that could be input into R / concatenated with other runs
outputFile.write(('{0}\n{1}\n').format(header,output))
outputFile.close()

############### Output SFS ########################
print('Writing out SFS **************************************************')                                   

outputSFS=str(outdir)+"/"+str(pop)+".dadi.inference."+str(modelName)+".runNum."+str(runNum)+".expSFS"

# 20190117 -- fixed this to output EXPECTED sfs not obs sfs
model.to_file(outputSFS)
#outputSFS.close()

############### Output plot ########################
print('Making plots **************************************************')                                   

#import pylab
import matplotlib.pyplot as plt 
fig=plt.figure(1)
#pylab.ion()
outputFigure=str(str(outdir)+"/"+str(pop)+".dadi.inference."+str(modelName)+".runNum."+str(runNum)+".figure.png")
dadi.Plotting.plot_1d_comp_multinom(model, fs)
#pylab.show()
plt.savefig(outputFigure)
#pylab.clf()


###### exit #######
sys.exit()
