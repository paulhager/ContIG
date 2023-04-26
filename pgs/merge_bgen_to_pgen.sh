# TODO: fill in path to imputed data (should contain .bgen files)
PTH_TO_IMP=/home/guests/projects/ukbb/genetics/
# TODO: fill in path to imputed data (should contain .sample files) (need to update below as well)
PTH_TO_SMP=/home/guests/projects/ukbb/genetics/

DST_PTH=/home/guests/projects/ukbb/genetics/imputed_merged/
mkdir -p $DST_PTH

MLOCAL=.
PTH_TO_SUBSET=$MLOCAL/iids_with_cardiac.txt

THREADS=40

# convert bgen to pgen and remove duplicates
for CHROMO in 8 9 10 11 12 13 14 15 16 17 18 19 20 21
do
  echo "Converting Chr$CHROMO"
  PTH_TO_OUT=$DST_PTH/ukb22828_imp_chr${CHROMO}
  # TODO: need to update the sample file to include your reference number
  plink2 \
    --make-pgen \
    --bgen ${PTH_TO_IMP}/ukb22828_c${CHROMO}_b0_v3.bgen ref-first \
    --sample ${PTH_TO_SMP}/ukb22828_c${CHROMO}_b0_v3.sample \
    --keep $PTH_TO_SUBSET \
    --rm-dup force-first \
    --out $PTH_TO_OUT \
    --threads $THREADS \
    --memory 50000
done

# merge all chromo pgens into one big pgen
PMERGE_LIST=${MLOCAL}/pmerge_list.txt
PGEN_MERGED=$DST_PTH/ukb_imp_allchr
#plink2 \
#  --pmerge-list $PMERGE_LIST \
#  --make-pgen \
#  --out $PGEN_MERGED \
#  --threads $THREADS \
#  --memory 50000

# clean up individual pgens
#ls ${DST_PTH}/ukb22828_imp_chr{1..22}.{log,pvar,psam,pgen}
#rm -I ${DST_PTH}/ukb22828_imp_chr{1..22}.{log,pvar,psam,pgen}
