input_dir="test_fastqs"
output_dir="test_output"
cores=30 

for i in $input_dir/*R1_001.fastq.gz; do 
  samplename=`echo $i | awk '{gsub("_L001_R1_001.fastq.gz","",$0); print}'`;echo -e $samplename
done \
| parallel -j $cores '\
gunzip -c {}_L001_R1_001.fastq.gz > '$output_dir'/`basename {}`_L001_R1_001.fastq; \
gunzip -c {}_L001_R2_001.fastq.gz > '$output_dir'/`basename {}`_L001_R2_001.fastq'
