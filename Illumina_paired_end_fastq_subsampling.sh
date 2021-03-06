input_dir="."
output_dir="."
threads=10 
for i in $input_dir/*R1_001.fastq; do 
  samplename=`echo $i | awk '{gsub("_L001_R1_001.fastq","",$0); print}'`;echo -e $samplename
done |\
parallel -j $threads '\
paste {}_L001_R1_001.fastq {}_L001_R2_001.fastq |\
awk '\''{printf("%s",$0); n++; if(n%4==0) {printf("\n");} else {printf("\t");}}'\'' |\
shuf | head -10000 |\
awk -F"\t" '\''{print $1"\n"$3"\n"$5"\n"$7 > "{}_sub_L001_R1_001.fastq"; print $2"\n"$4"\n"$6"\n"$8 > "{}_sub_L001_R2_001.fastq"}'\'''

for i in *fastq; do if [[ $i != *"_sub_"* ]]; then rm $i; fi ;done
