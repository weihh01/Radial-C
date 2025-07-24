#!/usr/bin/env python
# coding: utf-8

import numpy as np
import pandas as pd
import bioframe
import cooler
import cooltools
from itertools import combinations

import matplotlib.pyplot as plt

plt.style.use('seaborn-poster')
import matplotlib as mpl
from matplotlib.font_manager import FontProperties

mpl.rcParams['pdf.fonttype'] = 42
mpl.rcParams['ps.fonttype'] = 42
font_properties = FontProperties(family='Arial')
from matplotlib import ticker
from matplotlib.patches import Rectangle
from matplotlib import colors

resolution = 500
clr = cooler.Cooler('MNase-1min_500bp.cool')
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)
hg38_arms = hg38_arms[hg38_arms.chrom.isin(clr.chromnames)].reset_index(drop=True)
cvd_smooth_agg = cooltools.expected_cis(
    clr=clr,
    view_df=hg38_arms,
    smooth=True,
    aggregate_smoothed=True,
    nproc=80
)
cvd_smooth_agg['s_bp'] = cvd_smooth_agg['dist'] * resolution
cvd_smooth_agg['balanced.avg.smoothed.agg'].loc[cvd_smooth_agg['dist'] < 2] = np.nan
cvd_merged_MNase_1min = cvd_smooth_agg.drop_duplicates(subset=['dist'])[['s_bp', 'balanced.avg.smoothed.agg']]
der_MNase_1min = np.gradient(np.log(cvd_merged_MNase_1min['balanced.avg.smoothed.agg']),
                             np.log(cvd_merged_MNase_1min['s_bp']))

resolution = 500
clr = cooler.Cooler('MNase-5min_500bp.cool')
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)
hg38_arms = hg38_arms[hg38_arms.chrom.isin(clr.chromnames)].reset_index(drop=True)
cvd_smooth_agg = cooltools.expected_cis(
    clr=clr,
    view_df=hg38_arms,
    smooth=True,
    aggregate_smoothed=True,
    nproc=40
)
cvd_smooth_agg['s_bp'] = cvd_smooth_agg['dist'] * resolution
cvd_smooth_agg['balanced.avg.smoothed.agg'].loc[cvd_smooth_agg['dist'] < 2] = np.nan
cvd_merged_MNase_5min = cvd_smooth_agg.drop_duplicates(subset=['dist'])[['s_bp', 'balanced.avg.smoothed.agg']]
der_MNase_5min = np.gradient(np.log(cvd_merged_MNase_5min['balanced.avg.smoothed.agg']),
                             np.log(cvd_merged_MNase_5min['s_bp']))

resolution = 500
clr = cooler.Cooler('MNase-20min_500bp.cool')
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)
hg38_arms = hg38_arms[hg38_arms.chrom.isin(clr.chromnames)].reset_index(drop=True)
cvd_smooth_agg = cooltools.expected_cis(
    clr=clr,
    view_df=hg38_arms,
    smooth=True,
    aggregate_smoothed=True,
    nproc=40
)
cvd_smooth_agg['s_bp'] = cvd_smooth_agg['dist'] * resolution
cvd_smooth_agg['balanced.avg.smoothed.agg'].loc[cvd_smooth_agg['dist'] < 2] = np.nan
cvd_merged_MNase_20min = cvd_smooth_agg.drop_duplicates(subset=['dist'])[['s_bp', 'balanced.avg.smoothed.agg']]
der_MNase_20min = np.gradient(np.log(cvd_merged_MNase_20min['balanced.avg.smoothed.agg']),
                              np.log(cvd_merged_MNase_20min['s_bp']))

def plot_graph(cvd_merged, ax, der, label, color):
    ax = ax
    ax.loglog(
        cvd_merged['s_bp'],
        cvd_merged['balanced.avg.smoothed.agg'],
        '-',
        markersize=4,
        label=label,
        color=color,
        alpha=1,
        linewidth=2
    )
    ax.legend(loc="upper right", frameon=False, prop={'size': 14})
    ax.set(
        xlabel='Genomic distance (Mp)',
        ylabel='Contact probability',
        xlim=(5e2, 2e8),
        ylim=(1e-8, 0.1)
    )

    ax.set_aspect(1)

def plot_graph(cvd_merged, ax, der, label, color):
    ax.loglog(
        cvd_merged['s_bp'],
        cvd_merged['balanced.avg.smoothed.agg'],
        '-',
        markersize=4,
        label=label,
        color=color,
        alpha=1,
        linewidth=2
    )

f, ax = plt.subplots(figsize=(4, 6))
plot_graph(cvd_merged_MNase_1min, ax, der_MNase_1min, '1 min', "#386CAF")
plot_graph(cvd_merged_MNase_5min, ax, der_MNase_5min, '5 min', "#fc9533")
plot_graph(cvd_merged_MNase_20min, ax, der_MNase_20min, '20 min', "#9f79d3")

left = 5e5
right = 1e7
bottom = 1e-6
top = 5e-5

rect = Rectangle(
    xy=(left, bottom),
    width=right - left,
    height=top - bottom,
    edgecolor='k',
    facecolor='none',
    linewidth=1,
    linestyle='-'
)
ax.add_patch(rect)

ax.legend(loc="lower left", frameon=False, prop={'size': 12})
ax.set(
    xlabel='Genomic distance (bp)',
    ylabel='Contact probability',
    xlim=(5e2, 2e8),
    ylim=(1e-8, 0.1)
)
ax.set_aspect(1)

ax.xaxis.set_major_locator(plt.FixedLocator([1e3, 1e4, 1e5, 1e6, 1e7, 1e8]))
ax.xaxis.set_major_formatter(ticker.FuncFormatter(
    lambda x, pos: f'{x / 1e6:.0f}M' if x >= 1e6 else f'{x / 1e3:.0f}k' if x >= 1e3 else f'{x:.0f}'))
ax.tick_params(axis='both', which='major', labelsize=10)

plt.savefig("cooler_IC_contact_frequency_main.pdf", bbox_inches='tight')
plt.savefig("cooler_IC_contact_frequency_main.png", dpi=600, bbox_inches='tight')
plt.show()

def plot_graph(cvd_merged, ax, der, label, color):
    ax = ax
    ax.loglog(
        cvd_merged['s_bp'],
        cvd_merged['balanced.avg.smoothed.agg'],
        '-',
        markersize=4,
        label=label,
        color=color,
        alpha=1,
        linewidth=2
    )
    ax.set(
        xlabel='Genomic distance (Mp)',
        ylabel='Contact probability',
        xlim=(left, right),
        ylim=(bottom, top)
    )

    ax.set_aspect(1)


fig, ax = plt.subplots(
    figsize=(4, 4),
    nrows=1
)

plot_graph(cvd_merged_MNase_1min, ax, der_MNase_1min, '1 min', "#386CAF")
plot_graph(cvd_merged_MNase_5min, ax, der_MNase_5min, '5 min', "#fc9533")
plot_graph(cvd_merged_MNase_20min, ax, der_MNase_20min, '20 min', "#9f79d3")

ax.xaxis.set_major_locator(plt.FixedLocator([1e3, 1e4, 1e5, 1e6, 1e7, 1e8]))

ax.xaxis.set_tick_params(labelsize=14, pad=5)
ax.yaxis.set_tick_params(labelsize=14, pad=5)
ax.set_xlabel('Genomic distance (bp)', fontsize=15)
ax.set_ylabel('Contact probability', fontsize=15)

fig.set_size_inches(2, 2)
plt.rcParams.update({'font.size': 18, 'font.family': 'Arial'})

plt.savefig("cooler_IC_contact_frequency_zoom_in.pdf", bbox_inches='tight')
plt.savefig("cooler_IC_contact_frequency_zoom_in.png", dpi=600, bbox_inches='tight')