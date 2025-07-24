import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import cooler
import bioframe
import cooltools

clr = cooler.Cooler('/mnt/disk2/1/whh/private/Radial_Micro-C/merge/paper/figure2/loop/loop/MNase-20min.dedup.cool')
resolution = clr.binsize
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)
hg38_arms = hg38_arms.set_index("chrom").loc[clr.chromnames].reset_index()
paired_sites = pd.read_table('leftstripes_500kb_nona.bedpe')
paired_sites.loc[:, 'mid1'] = (paired_sites['start1'] + paired_sites['end1']) // 2
paired_sites.loc[:, 'mid2'] = (paired_sites['start2'] + paired_sites['end2']) // 2

import cooltools.lib.plotting

expected = cooltools.expected_cis(clr, view_df=hg38_arms, nproc=30, chunksize=1_000_000)
stack = cooltools.pileup(clr, paired_sites, view_df=hg38_arms, expected_df=expected, flank=100_000)
mtx = np.nanmean(stack, axis=2)
flank = 250

plt.imshow(
    np.log2(mtx),
    vmax=2.5,
    vmin=-2.5,
    cmap='coolwarm',
    interpolation='none')
plt.colorbar(label='log2 mean obs/exp')
ticks_pixels = np.linspace(0, flank * 2 // resolution, 5)
ticks_kbp = ((ticks_pixels - ticks_pixels[-1] / 2) * resolution // 1000).astype(int)
plt.xticks(ticks_pixels, ticks_kbp)
plt.yticks(ticks_pixels, ticks_kbp)
plt.xlabel('relative position, kbp')
plt.ylabel('relative position, kbp')
plt.title("MNase-20min")
plt.savefig('MNase-20min_leftstripes.jpg', dpi=300, format="tiff")
