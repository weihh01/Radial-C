import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import pandas as pd
import os
import cooltools
import cooler
import cooler
from matplotlib.colors import LogNorm
import cooltools.lib.plotting



clr_10kb = cooler.Cooler("MNase-1min.dedup.cool")

start = 157729835
end = 158674834
region = ('chr2',start,end)
extents = (start, end, end, start)
norm = LogNorm(vmin=0.0001, vmax=0.1)
f, axs = plt.subplots(
        nrows=1,
        ncols=1)
norm_raw = LogNorm(vmin=1, vmax=600)
im = axs.matshow(clr_10kb.matrix(balance=True).fetch(region), cmap='fall', norm=norm, extent=extents)
plt.colorbar(im, ax=axs, fraction=0.046, label='corrected frequencies')
plt.savefig('balance_1min_chr2_1e.tiff', dpi= 300, format = "tiff")
