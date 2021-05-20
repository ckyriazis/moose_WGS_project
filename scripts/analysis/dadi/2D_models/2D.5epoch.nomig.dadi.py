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


modelName="2D.5epoch.nomig"

############### Parse input arguments ########################
parser = argparse.ArgumentParser(description='Infer a '+ modelName +' model from a 1D folded SFS in dadi')
parser.add_argument("--runNum",required=True,help="iteration number (e.g. 1-50)")
parser.add_argument("--pop",required=True,help="population identifier, e.g. 'CA'")
parser.add_argument("--mu",required=True,help="supply mutation rate in mutation/bp/gen")
parser.add_argument("--L",required=True,help="number of called neutral sites that went into making SFS (monomorphic+polymorphic)")
parser.add_argument("--sfs",required=True,help="path to FOLDED SFS in dadi format from easySFS (mask optional)")
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
#sfs="/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/datafiles/SFS/20181119/easySFS_projection/neutral/projection-20181221-hetFilter-0.75/dadi-plusMonomorphic/CA-AK.plusMonomorphic.sfs" # 2D sfs
fs=dadi.Spectrum.from_file(sfs) # this is folded from easy SFS
# fold the fs:
#fs=fs.fold() # folded
# check if it's folded, if not folded, fold it
if fs.folded==False:
    fs=fs.fold()
else:
    fs=fs
############### Set up General Dadi Parameters ########################
ns = fs.sample_sizes # get sample size from SFS (in haploids)
pts_l = [ns[0]+5,ns[0]+15,ns[0]+25] # need 6 points because two populations 
############### Set up Specific Model -- this will change from script to script ########################
#nu1: Size of population 1 after split. 
#nu2: Size of population 2 after split. 
#T: Time in the past of split (in units of 2*Na generations)  
# m: Migration rate between populations (2*Na*m) 
#n1,n2: Sample sizes of resulting Spectrum 
#pts: Number of grid points to use in integration.
def split_5epoch_nomig(params, ns, pts): 
    nu1,nu2,nu3,t1,t2,t3,nuIR,nuMN = params 
    xx = Numerics.default_grid(pts) # sets up grid
    phi = PhiManip.phi_1D(xx) # sets up initial phi for population 
    phi = Integration.one_pop(phi, xx, t1, nu1)
    phi = Integration.one_pop(phi, xx, t2, nu2)
    phi = Integration.one_pop(phi, xx, t3, nu3)
    phi = PhiManip.phi_1D_to_2D(xx, phi)  # split into two pops
    phi = Integration.two_pops(phi, xx, 0.0008, nuIR, nuMN, m12=0, m21=0)  # two pops at diff sizes with symmetric migration
    fs = Spectrum.from_phi(phi, ns, (xx,xx)) 
    return fs
param_names=("nu1","nu2","nu3","t1","t2","t3","nuIR","nuMN")
#nu1 is anc pop growth
#nu2 is bottleneck
#nu3 is post-bott growth

lower_bound = [1, 1e-5, 1,1e-5,1e-5,1e-5,1e-5,1e-5]
upper_bound = [10, 0.5, 50, 1, 1, 1, 0.1, 50] 
p0 = [2, 0.01, 10, 0.1, 0.1, 0.1, 0.01, 10] # initial parameters


func=split_5epoch_nomig # set the functiion

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
# calculate best fit theta
theta = dadi.Inference.optimal_sfs_scaling(model, fs)

###### model specific scaling of parameters (will depend on mu and L that you supply) #######

Nanc=theta / (4*mu*L)
nu1_scaled_dip=popt[0]*Nanc
nu2_scaled_dip=popt[1]*Nanc
nu3_scaled_dip=popt[2]*Nanc
t1_scaled_gen=popt[3]*2*Nanc
t2_scaled_gen=popt[4]*2*Nanc
t3_scaled_gen=popt[5]*2*Nanc
nuIR_scaled_dip=popt[6]*Nanc
nuMN_scaled_dip=popt[7]*Nanc

#m_scaled_gen=popt[3]/(2*Nanc) # migration rates come out scaled by fraction of members of pop  scaled * 2Na according to dadi manual so here you actually DIVIDE by 2Na *not multiply* to get the migration fraction. Tricky tricky :)
# THIS IS TRICKY: confirmed here: https://groups.google.com/forum/#!topic/dadi-user/AY_4NoEjsx8
scaled_param_names=("Nanc_FromTheta_scaled_dip","nu1_scaled_dip","nu2_scaled_dip","nu3_scaled_dip","t1_scaled_gen","t2_scaled_gen","t3_scaled_gen","nuIR_scaled_dip","nuMN_scaled_dip")
scaled_popt=(Nanc,nu1_scaled_dip,nu2_scaled_dip,nu3_scaled_dip,t1_scaled_gen,t2_scaled_gen,t3_scaled_gen,nuIR_scaled_dip,nuMN_scaled_dip)
############### Write out output (same for any model) ########################
print('Writing out parameters **************************************************')                                   

outputFile=open(str(outdir)+"/"+str(pop)+".dadi.inference."+str(modelName)+".runNum."+str(runNum)+".output","w")
# get all param names:
param_names_str='\t'.join(str(x) for x in param_names)
scaled_param_names_str='\t'.join(str(x) for x in scaled_param_names)
header=param_names_str+"\t"+scaled_param_names_str+"\ttheta\tLL\tmodelFunction\tmu\tL\tmaxiter\trunNumber\trundate\tinitialParameters\tupper_bound\tlower_bound" # add additional parameters theta, log-likelihood, model name, run number and rundate
popt_str='\t'.join(str(x) for x in popt) # get opt'd parameters as a tab-delim string
scaled_popt_str='\t'.join(str(x) for x in scaled_popt)
# joint together all the output fields, tab-separated:
output=[popt_str,scaled_popt_str,theta,ll_model,func.func_name,mu,L,maxiter,runNum,todaysdate,p0,upper_bound,lower_bound] # put all the output terms together
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
dadi.Plotting.plot_2d_comp_multinom(model, fs)
#pylab.show()
plt.savefig(outputFigure)
#pylab.clf()


###### exit #######
sys.exit()
