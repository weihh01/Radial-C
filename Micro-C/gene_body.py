import matplotlib as mpl
mpl.rcParams['figure.dpi'] = 96
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from coolpuppy import coolpup
from coolpuppy.lib.numutils import get_domain_score
from coolpuppy.lib.puputils import accumulate_values
from coolpuppy import plotpup
import cooler
import bioframe
import cooltools
from cooltools.lib import io
from cooltools import insulation, expected_cis
from cooltools.lib import plotting
from coolpuppy.lib.puputils import divide_pups

clr = cooler.Cooler('DMSO-20min.cool')
# Set up selected data resolution:
resolution = 10000

# Use bioframe to fetch the genomic features from the UCSC.
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)

# Select only chromosomes that are present in the cooler. 
# This step is typically not required! we call it only because the test data are reduced. 
hg38_arms = hg38_arms.set_index("chrom").loc[clr.chromnames].reset_index()
# call this to automaticly assign names to chromosomal arms:
hg38_arms = bioframe.make_viewframe(hg38_arms)

expected = expected_cis(
    clr,
    ignore_diags=0,
    view_df=hg38_arms,
    chunksize=1000000,
          nproc=40)

tads = pd.read_table('/mnt/disk6/1/Radial_Micro-C/RNA-seq/diff/DMSO_Flavo_60kb_u.bed')
def make_tads(insul_df, maxlen=1_500_000):
	tads = (
 	insul_df.groupby("chrom")
	.apply(
		lambda x: pd.concat(
		[x[:-1].reset_index(drop=True), x[1:].reset_index(drop=True)],
		axis=1,
		ignore_index=True,
		)
	)
	.reset_index(drop=True)
	)
	tads.columns = [["chrom1", "start1", "end1", "chrom2", "start2", "end2"]]
	tads.columns = tads.columns.get_level_values(0)
	tads = tads[
	(tads["start2"] - tads["start1"]) <= maxlen
	].reset_index(drop=True)
	tads["start"] = (tads["start1"] + tads["end1"]) // 2
	tads["end"] = (tads["start2"] + tads["end2"]) // 2
	tads = tads[["chrom1", "start", "end"]]
	tads.columns = ['chrom', 'start', 'end']
	return tads
def add_domain_score(snippet):
	snippet['domain_score'] = get_domain_score(snippet['data']) # Calculates domain score for each snippet according to Flyamer et al., 2017
	return snippet

def extra_sum_func(dict1, dict2):
	return accumulate_values(dict1, dict2, 'domain_score')

cc = coolpup.CoordCreator(tads, resolution=10000, features_format='bed', local=True, rescale_flank=1)
pu = coolpup.PileUpper(clr, cc, expected=expected, view_df=hg38_arms, ignore_diags=0, rescale_size=99, rescale=True)
pup_DMSO = pu.pileupsWithControl(postprocess_func=add_domain_score)

fig3 = plotpup.plot(pup_DMSO,
	score=True,
	height=5,
	vmax=2)
fig3.savefig('DMSO-20min.pdf')









clr = cooler.Cooler('Flavo-20min.cool')
# Set up selected data resolution:
resolution = 10000

# Use bioframe to fetch the genomic features from the UCSC.
hg38_chromsizes = bioframe.fetch_chromsizes('hg38')
hg38_cens = bioframe.fetch_centromeres('hg38')
hg38_arms = bioframe.make_chromarms(hg38_chromsizes, hg38_cens)

# Select only chromosomes that are present in the cooler. 
# This step is typically not required! we call it only because the test data are reduced. 
hg38_arms = hg38_arms.set_index("chrom").loc[clr.chromnames].reset_index()
# call this to automaticly assign names to chromosomal arms:
hg38_arms = bioframe.make_viewframe(hg38_arms)

expected = expected_cis(
    clr,
    ignore_diags=0,
    view_df=hg38_arms,
    chunksize=1000000,
    nproc=40)

cc = coolpup.CoordCreator(tads, resolution=10000, features_format='bed', local=True, rescale_flank=1)
pu = coolpup.PileUpper(clr, cc, expected=expected, view_df=hg38_arms, ignore_diags=0, rescale_size=99, rescale=True)
pup_Flavo = pu.pileupsWithControl(postprocess_func=add_domain_score)

fig2 = plotpup.plot(pup_Flavo,
	score=True,
	height=5,
	vmax=2)
fig2.savefig('Flavo-20min.pdf')




pup_divide = divide_pups(pup_Flavo ,pup_DMSO)

fig = plotpup.plot(pup_divide,
	score=True,
	height=5,
	vmax=1.5)

fig.savefig('20min.pdf')

