#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import cooler
import bioframe
import cooltools
from packaging import version
import cooltools.lib.plotting
from matplotlib.font_manager import FontProperties
import matplotlib as mpl

if version.parse(cooltools.__version__) < version.parse('0.5.2'):
    raise AssertionError(
        "tutorials rely on cooltools version 0.5.2 or higher, please check your cooltools version and update to the latest")

data_dir = './'

clr_dmso = cooler.Cooler(data_dir + '/DMSO-20min.cool')
clr_tpa = cooler.Cooler(data_dir + '/dTAG-20min.cool')

resolution = clr_dmso.binsize

hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)
hg38_arms = hg38_arms.set_index("chrom").loc[clr_dmso.chromnames].reset_index()

motif_prefix_list = ['boundaries','boundaries']

# Read CTCF motif data
for motif_prefix in motif_prefix_list:
    ctcf_motif_file = f'{motif_prefix}.bed'
    ctcf = bioframe.read_table(ctcf_motif_file, schema='bed').query(f'chrom in {clr_dmso.chromnames}')
    ctcf['mid'] = (ctcf.end + ctcf.start) // 2
    globals()[f'sites_{motif_prefix}'] = ctcf

# Calculate expected cis
expected_dmso = cooltools.expected_cis(clr_dmso, view_df=hg38_arms, nproc=40, chunksize=500_000)
expected_tpa = cooltools.expected_cis(clr_tpa, view_df=hg38_arms, nproc=40, chunksize=500_000)

for motif_prefix in motif_prefix_list:
    for condition in ["dmso", "tpa"]:
        stack = cooltools.pileup(eval(f'clr_{condition}'), eval(f'sites_{motif_prefix}'), view_df=hg38_arms,
                                 expected_df=eval(f'expected_{condition}'), flank=500_000)
        sites = eval(f'sites_{motif_prefix}')
        mask = np.array(sites.strand == '-', dtype=bool)
        stack[:, :, mask] = stack[::-1, ::-1, mask]
        globals()[f'mtx_{condition}_{motif_prefix}'] = np.nanmean(stack, axis=2)
        print(f'mtx_{condition}_{motif_prefix} finish!')

for motif_prefix in motif_prefix_list:
    for condition in ["dmso", "tpa"]:
        globals()[f'mtx_{condition}_{motif_prefix}_p'] = np.where(eval(f'mtx_{condition}_{motif_prefix}') == 0, np.nan,
                                                                  eval(f'mtx_{condition}_{motif_prefix}'))
        np.savetxt(f'fig7.Aggregated_plot_for_CTCF_motifs_mtx_{condition}_{motif_prefix}.tsv',
                   eval(f'mtx_{condition}_{motif_prefix}_p'), delimiter='\t')

    globals()[f'mtx_fc_{motif_prefix}_p'] = eval(f'mtx_tpa_{motif_prefix}_p') / eval(f'mtx_dmso_{motif_prefix}_p')
    np.savetxt(f'fig7.Aggregated_plot_for_CTCF_motifs_mtx_fc_{motif_prefix}.tsv', eval(f'mtx_fc_{motif_prefix}_p'),
               delimiter='\t')

# Plotting
mpl.rcParams['pdf.fonttype'] = 42
mpl.rcParams['ps.fonttype'] = 42
font_properties = FontProperties(family='Arial')
conditions = ['dmso', 'tpa', "fc"]
motif_prefixes = ['boundaries','boundaries']
flank = 500000
cmap = plt.cm.get_cmap('coolwarm')
cmap.set_bad(color='#E6E2DF')
fig, axes = plt.subplots(nrows=len(conditions), ncols=len(motif_prefixes), figsize=(4, 4), sharex=True, sharey=True)

for i, condition in enumerate(conditions):
    for j, motif_prefix in enumerate(motif_prefixes):
        mtx_p = eval(f'mtx_{condition}_{motif_prefix}_p')
        ax = axes[i, j]
        ax.axis('off')
        if condition == "fc":
            im = ax.imshow(mtx_p, vmax=1.3, vmin=0.7, cmap=cmap, interpolation='none')
        else:
            im = ax.imshow(mtx_p, vmax=1.3, vmin=0.7, cmap=cmap, interpolation='none')
            normal_im = im
        ticks_pixels = np.linspace(0, flank * 2 // resolution, 5)
        ticks_kbp = ((ticks_pixels - ticks_pixels[-1] / 2) * resolution // 1000).astype(int)
        ax.set_xticks(ticks_pixels)
        ax.set_yticks([])
        ax.set_xticklabels(ticks_kbp, fontsize=16)
        ax.set_yticklabels([])
        if i == len(conditions) - 1 and j == len(motif_prefixes) - 1:
            ax.set_xlabel('Relative Position (kbp)', fontsize=16)
        if j == 0:
            if condition == "fc":
                ax.text(-0.1, 0.5, "dTAG / DMSO", transform=ax.transAxes, va='center', ha='right', rotation='vertical',
                        fontsize=16, fontproperties=font_properties)
            else:
                ax.text(-0.1, 0.5, condition.upper(), transform=ax.transAxes, va='center', ha='right',
                        rotation='vertical',
                        fontsize=16, fontproperties=font_properties)
        if i == 0:
            ax.text(0.5, 1.05, motif_prefix, transform=ax.transAxes, va='bottom', ha='center', fontsize=16,
                    fontproperties=font_properties)

plt.subplots_adjust(wspace=0.05, hspace=0.05)
cax = plt.axes([0.92, 0.4, 0.02, 0.45])
colorbar = plt.colorbar(normal_im, cax=cax, ticks=[0.7, 1, 1.3], label='Observed / Expected')
cax2 = plt.axes([0.92, 0.12, 0.02, 0.22])
colorbar2 = plt.colorbar(im, cax=cax2, ticks=[0.7, 1, 1.3], label='dTAG / DMSO')
fig.set_size_inches(10, 5)

plt.rcParams.update({'font.size': 16, 'font.family': 'Arial'})
plt.savefig('fig7.Aggregated_plot_for_CTCF_motifs.pdf', format="pdf", bbox_inches='tight')
