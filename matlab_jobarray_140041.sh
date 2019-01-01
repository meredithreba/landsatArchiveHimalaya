#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=outJobArry
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day
#SBATCH --time=24:00:00
#SBATCH --array=1-23
##SBATCH --mem-per-cpu=30G
#SBATCH -o Outfiles/outJobArry_%A_%a.out

module load Apps/Matlab/R2014a

file=$(ls /home/fas/seto/bc643/scratch60/grace1/clsf_outtxt_for_clustering/out_breakdown/140041_out.txt_?? | head -n $SLURM_ARRAY_TASK_ID | tail -1 )
export  file
matlab << EOF

file = getenv('file')
file_name=char(file);
out_ori=dlmread(file_name);


pixel_withinshp=dlmread('/home/fas/seto/bc643/scratch60/grace1/urbOnlyPix_WithinShpNoOverlay/140041_urbpix_WithinShpnoOverlay_matlab.txt'); %read in urban only pixelX & pixelY within in shp no overlay
[r_o,c_o]=size(out_ori);

out_WithinShpNoOverlay_name_firstpart=char('/home/fas/seto/bc643/scratch60/grace1/clsf_outtxt_for_clustering/140041_out_WithinShpnoOverlay_');
out_WithinShpNoOverlay_name=[out_WithinShpNoOverlay_name_firstpart file_name(end-2:end) '.txt'];
fid=fopen(char(out_WithinShpNoOverlay_name),'w');

for i=1:r_o
        index=[out_ori(i,1),out_ori(i,2)];
        if ismember(index,pixel_withinshp,'rows')==1 %ismember
            fprintf(fid,'%d ',out_ori(i,:)); %write results
            fprintf(fid,'\n ');
        end
end

fclose(fid);
EOF