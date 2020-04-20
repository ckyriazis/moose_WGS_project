import numpy as np
import scipy
import pandas
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style('white')
sns.set_style('ticks')
sns.set_context('notebook')
import h5py
import allel; print('scikit-allel', allel.__version__)



callset_fn = '/u/home/c/ckyriazi/kirk-bigdata/Ag1000G_data_hdf5/ag1000g.phase1.ar3.h5'
callset = h5py.File(callset_fn, mode='r')
callset

chrom = '3L'

variants = allel.VariantChunkedTable(callset[chrom]['variants'], 
                                     names=['POS', 'REF', 'ALT', 'DP', 'MQ', 'QD', 'num_alleles'],
                                     index='POS')
print(variants)

pos = variants['POS'][:]
print(pos)

def plot_windowed_variant_density(pos, window_size, title=None):
    
    # setup windows 
    bins = np.arange(0, pos.max(), window_size)
    
    # use window midpoints as x coordinate
    x = (bins[1:] + bins[:-1])/2
    
    # compute variant density in each window
    h, _ = np.histogram(pos, bins=bins)
    y = h / window_size
    
    # plot
    fig, ax = plt.subplots(figsize=(12, 3))
    sns.despine(ax=ax, offset=10)
    ax.plot(x, y)
    ax.set_xlabel('Chromosome position (bp)')
    ax.set_ylabel('Variant density (bp$^{-1}$)')
    if title:
        ax.set_title(title)
    fig.savefig("snp_density.png")



plot_windowed_variant_density(pos, window_size=100000, title='Raw variant density')




