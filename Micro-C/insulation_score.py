import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

import cooler
import cooltools.lib.plotting
from cooltools import insulation
import cooltools

resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-1min_rep1.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-1min_rep1_insulation_table.bed',index=False,sep='\t')



resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-1min_rep2.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-1min_rep2_insulation_table.bed',index=False,sep='\t')



resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-5min_rep1.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-5min_rep1_insulation_table.bed',index=False,sep='\t')

resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-5min_rep2.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-5min_rep2_insulation_table.bed',index=False,sep='\t')





resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-20min_rep1.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-20min_rep1_insulation_table.bed',index=False,sep='\t')

resolution = 40000
clr = cooler.Cooler('/mnt/disk4/whh/Radial_Micro-C/merge/MNase-20min_rep2.UMI.dedup.mcool::/resolutions/40000')
windows = [3*resolution, 5*resolution, 10*resolution, 25*resolution]
insulation_table = insulation(clr, windows, verbose=True)
first_window_summary =insulation_table.columns[[ str(windows[-1]) in i for i in insulation_table.columns]]
insulation_table[['chrom','start','end','region','is_bad_bin']+list(first_window_summary)].iloc[1000:1005]
insulation_table.to_csv('MNase-20min_rep2_insulation_table.bed',index=False,sep='\t')
