https://raw.githubusercontent.com/rec3141/diversity-scripts/master/convert_silva_taxonomy.r

REF_RAW_PATH="/workshop_ressources/reference_sets/"
REF_DBS="silva_132_ref_nr"
CUTADAPT=${which cutadapt}

FORWARDPRIMER=""
REVERSEPRIMER=""

MIN_LEN_REF="200"
MAX_LEN_REF="550"

PRIMER_MISMATCH_REF
MIN_PRIMER_OVERLAP_FRAC_REF

REF_USED_FP

REVERSEPRIMER_RC=`echo ${REVERSEPRIMER} | tr "[ATGCatgcRYSWKMBDHVryswkmbdhv]" "[TACGtacgYRSWMKVHDByrswmkvhdb]" | rev`
lenFP_CUT_REF=$(( ${#FORWARDPRIMER} * ${MIN_PRIMER_OVERLAP_FRAC_REF} ))
lenRP_CUT_REF=$(( ${#REVERSEPRIMER_RC} * ${MIN_PRIMER_OVERLAP_FRAC_REF} ))


cat ${REF_RAW_PATH}"/"${REF_DBS}".fasta" \
| \
${CUTADAPT} \
-g ${FORWARDPRIMER} \
--discard-untrimmed \
--minimum-length ${MIN_LEN_REF} \
-e ${PRIMER_MISMATCH_REF} \
-O ${lenFP_CUT_REF} \
- \
| \
${CUTADAPT} \
-a ${REVERSEPRIMER_RC} \
--discard-untrimmed \
--minimum-length ${MIN_LEN_REF} \
--maximum-length ${MAX_LEN_REF} \
-e ${PRIMER_MISMATCH_REF} \
-O ${lenRP_CUT_REF} \
- \
> ${REF_USED_FP}"/"${REF_DBS}"_"${FORWARDPRIMER}"_"${REVERSEPRIMER_RC}"_"${PRIMER_MISMATCH_REF}"_"${lenFP_CUT_REF}"_"${lenRP_CUT_REF}".fasta"'
