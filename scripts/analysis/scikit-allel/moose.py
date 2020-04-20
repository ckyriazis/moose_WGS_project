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



callset_fn = '9Moose_joint_Filter_B_NC_037355.1.h5'
callset = h5py.File(callset_fn, mode='r')
print(callset)


variants = allel.VariantChunkedTable(callset['variants'], 
                                     names=['POS', 'REF', 'ALT','FILTER', 'DP', 'MQ', 'QD'],
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


def plot_variant_hist(f, bins=30):
    x = variants[f][:]
    fig, ax = plt.subplots(figsize=(7, 5))
    sns.despine(ax=ax, offset=10)
    ax.hist(x, bins=bins)
    ax.set_xlabel(f)
    ax.set_ylabel('No. variants')
    ax.set_title('Variant %s distribution' % f)
    fig.savefig("DP_hist.png")

plot_variant_hist('DP', bins=50)



variants_filtered = variants[variants['FILTER'][:] == 'PASS']

x = variants_filtered['DP'][:]
print(max(x))




