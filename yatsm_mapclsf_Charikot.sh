#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=mapclsf_Charikot
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=3000
#SBATCH -o Outfiles/mapclsf_Charikot_%A_%a.out

module load Langs/Python/2.7-anaconda 

# running code

source activate yatsm
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 1990-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_1990_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 1992-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_1992_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 1994-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_1994_180814.tif

yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 1996-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_1996_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 1998-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_1998_180814.tif

yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2000-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2000_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2002-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2002_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2004-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2004_180814.tif

yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2006-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2006_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2008-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2008_180814.tif

yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2010-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2010_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2012-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2012_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2014-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2014_180814.tif
yatsm -v map --root /home/fas/seto/bc643 --result /home/fas/seto/bc643/scratch60/grace1/yatsm_out/141041_clipped_TC_SE_5bandsqa_out_0814_clsf --image /home/fas/seto/bc643/project/scratch60_temp/141041clipped/LT051410412011111301T2_clipped/LT051410412011111301T2_clipped.tif class 2016-01-01 /home/fas/seto/bc643/scratch60/grace1/micro/Charikot/Charikot_clsf0814/Charikot_clsf_2016_180814.tif
