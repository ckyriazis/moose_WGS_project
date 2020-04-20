#!/bin/bash
#$ -l highp,h_rt=100:00:00,h_data=12G
#$ -pe shared 4
#$ -N merge_chroms
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/13_MergeChroms
#$ -e /u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/13_MergeChroms
#$ -M ckyriazi





## This cats all the chroms for the allsites vcf.
## Script modified from Clare's version for caracals

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/moose_pipeline/hogdeer_reference/GCA_003798545.1_ASM379854v1_genomic.fna


indir='/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/11_FilterVCFfile'
outdir='/u/home/c/ckyriazi/kirk-bigdata/moose/hogdeer_output/13_MergeChroms'
prefix='9Moose_joint_FilterB_hogdeer_round1'
suffix='.vcf.gz'




java -cp ${GATK} org.broadinstitute.gatk.tools.CatVariants \
-R ${REFERENCE} \
-V ${indir}/${prefix}_1${suffix} \
-V ${indir}/${prefix}_2${suffix} \
-V ${indir}/${prefix}_3${suffix} \
-V ${indir}/${prefix}_4${suffix} \
-V ${indir}/${prefix}_5${suffix} \
-V ${indir}/${prefix}_6${suffix} \
-V ${indir}/${prefix}_7${suffix} \
-V ${indir}/${prefix}_8${suffix} \
-V ${indir}/${prefix}_9${suffix} \
-V ${indir}/${prefix}_10${suffix} \
-V ${indir}/${prefix}_11${suffix} \
-V ${indir}/${prefix}_12${suffix} \
-V ${indir}/${prefix}_13${suffix} \
-V ${indir}/${prefix}_14${suffix} \
-V ${indir}/${prefix}_15${suffix} \
-V ${indir}/${prefix}_16${suffix} \
-V ${indir}/${prefix}_17${suffix} \
-V ${indir}/${prefix}_18${suffix} \
-V ${indir}/${prefix}_19${suffix} \
-V ${indir}/${prefix}_20${suffix} \
-V ${indir}/${prefix}_21${suffix} \
-V ${indir}/${prefix}_22${suffix} \
-V ${indir}/${prefix}_23${suffix} \
-V ${indir}/${prefix}_24${suffix} \
-V ${indir}/${prefix}_25${suffix} \
-V ${indir}/${prefix}_26${suffix} \
-V ${indir}/${prefix}_27${suffix} \
-V ${indir}/${prefix}_28${suffix} \
-V ${indir}/${prefix}_29${suffix} \
-V ${indir}/${prefix}_30${suffix} \
-V ${indir}/${prefix}_31${suffix} \
-V ${indir}/${prefix}_32${suffix} \
-V ${indir}/${prefix}_33${suffix} \
-V ${indir}/${prefix}_34${suffix} \
-V ${indir}/${prefix}_35${suffix} \
-V ${indir}/${prefix}_36${suffix} \
-V ${indir}/${prefix}_37${suffix} \
-V ${indir}/${prefix}_38${suffix} \
-V ${indir}/${prefix}_39${suffix} \
-V ${indir}/${prefix}_40${suffix} \
-V ${indir}/${prefix}_41${suffix} \
-V ${indir}/${prefix}_42${suffix} \
-V ${indir}/${prefix}_43${suffix} \
-V ${indir}/${prefix}_44${suffix} \
-V ${indir}/${prefix}_45${suffix} \
-V ${indir}/${prefix}_46${suffix} \
-V ${indir}/${prefix}_47${suffix} \
-V ${indir}/${prefix}_48${suffix} \
-V ${indir}/${prefix}_49${suffix} \
-V ${indir}/${prefix}_50${suffix} \
-V ${indir}/${prefix}_51${suffix} \
-V ${indir}/${prefix}_52${suffix} \
-V ${indir}/${prefix}_53${suffix} \
-V ${indir}/${prefix}_54${suffix} \
-V ${indir}/${prefix}_55${suffix} \
-V ${indir}/${prefix}_56${suffix} \
-V ${indir}/${prefix}_57${suffix} \
-V ${indir}/${prefix}_58${suffix} \
-V ${indir}/${prefix}_59${suffix} \
-V ${indir}/${prefix}_60${suffix} \
-V ${indir}/${prefix}_61${suffix} \
-V ${indir}/${prefix}_62${suffix} \
-V ${indir}/${prefix}_63${suffix} \
-V ${indir}/${prefix}_64${suffix} \
-V ${indir}/${prefix}_65${suffix} \
-V ${indir}/${prefix}_66${suffix} \
-V ${indir}/${prefix}_67${suffix} \
-V ${indir}/${prefix}_68${suffix} \
-V ${indir}/${prefix}_69${suffix} \
-V ${indir}/${prefix}_70${suffix} \
-V ${indir}/${prefix}_71${suffix} \
-V ${indir}/${prefix}_72${suffix} \
-V ${indir}/${prefix}_73${suffix} \
-V ${indir}/${prefix}_74${suffix} \
-V ${indir}/${prefix}_75${suffix} \
-V ${indir}/${prefix}_76${suffix} \
-V ${indir}/${prefix}_77${suffix} \
-V ${indir}/${prefix}_78${suffix} \
-V ${indir}/${prefix}_79${suffix} \
-V ${indir}/${prefix}_80${suffix} \
-V ${indir}/${prefix}_81${suffix} \
-V ${indir}/${prefix}_82${suffix} \
-V ${indir}/${prefix}_83${suffix} \
-V ${indir}/${prefix}_84${suffix} \
-V ${indir}/${prefix}_85${suffix} \
-V ${indir}/${prefix}_86${suffix} \
-V ${indir}/${prefix}_87${suffix} \
-V ${indir}/${prefix}_88${suffix} \
-V ${indir}/${prefix}_89${suffix} \
-V ${indir}/${prefix}_90${suffix} \
-V ${indir}/${prefix}_91${suffix} \
-V ${indir}/${prefix}_92${suffix} \
-V ${indir}/${prefix}_93${suffix} \
-V ${indir}/${prefix}_94${suffix} \
-V ${indir}/${prefix}_95${suffix} \
-V ${indir}/${prefix}_96${suffix} \
-V ${indir}/${prefix}_97${suffix} \
-V ${indir}/${prefix}_98${suffix} \
-V ${indir}/${prefix}_99${suffix} \
-V ${indir}/${prefix}_100${suffix} \
-V ${indir}/${prefix}_101${suffix} \
-V ${indir}/${prefix}_102${suffix} \
-V ${indir}/${prefix}_103${suffix} \
-V ${indir}/${prefix}_104${suffix} \
-V ${indir}/${prefix}_105${suffix} \
-V ${indir}/${prefix}_106${suffix} \
-V ${indir}/${prefix}_107${suffix} \
-V ${indir}/${prefix}_108${suffix} \
-V ${indir}/${prefix}_109${suffix} \
-V ${indir}/${prefix}_110${suffix} \
-V ${indir}/${prefix}_111${suffix} \
-V ${indir}/${prefix}_112${suffix} \
-V ${indir}/${prefix}_113${suffix} \
-V ${indir}/${prefix}_114${suffix} \
-V ${indir}/${prefix}_115${suffix} \
-V ${indir}/${prefix}_116${suffix} \
-V ${indir}/${prefix}_117${suffix} \
-V ${indir}/${prefix}_118${suffix} \
-V ${indir}/${prefix}_119${suffix} \
-V ${indir}/${prefix}_120${suffix} \
-V ${indir}/${prefix}_121${suffix} \
-V ${indir}/${prefix}_122${suffix} \
-V ${indir}/${prefix}_123${suffix} \
-V ${indir}/${prefix}_124${suffix} \
-V ${indir}/${prefix}_125${suffix} \
-V ${indir}/${prefix}_126${suffix} \
-V ${indir}/${prefix}_127${suffix} \
-V ${indir}/${prefix}_128${suffix} \
-V ${indir}/${prefix}_129${suffix} \
-V ${indir}/${prefix}_130${suffix} \
-V ${indir}/${prefix}_131${suffix} \
-V ${indir}/${prefix}_132${suffix} \
-V ${indir}/${prefix}_133${suffix} \
-V ${indir}/${prefix}_134${suffix} \
-V ${indir}/${prefix}_135${suffix} \
-V ${indir}/${prefix}_136${suffix} \
-V ${indir}/${prefix}_137${suffix} \
-V ${indir}/${prefix}_138${suffix} \
-V ${indir}/${prefix}_139${suffix} \
-V ${indir}/${prefix}_140${suffix} \
-V ${indir}/${prefix}_141${suffix} \
-V ${indir}/${prefix}_142${suffix} \
-V ${indir}/${prefix}_143${suffix} \
-V ${indir}/${prefix}_144${suffix} \
-V ${indir}/${prefix}_145${suffix} \
-V ${indir}/${prefix}_146${suffix} \
-V ${indir}/${prefix}_147${suffix} \
-V ${indir}/${prefix}_148${suffix} \
-V ${indir}/${prefix}_149${suffix} \
-V ${indir}/${prefix}_150${suffix} \
-V ${indir}/${prefix}_151${suffix} \
-V ${indir}/${prefix}_152${suffix} \
-V ${indir}/${prefix}_153${suffix} \
-V ${indir}/${prefix}_154${suffix} \
-V ${indir}/${prefix}_155${suffix} \
-V ${indir}/${prefix}_156${suffix} \
-V ${indir}/${prefix}_157${suffix} \
-V ${indir}/${prefix}_158${suffix} \
-V ${indir}/${prefix}_159${suffix} \
-V ${indir}/${prefix}_160${suffix} \
-V ${indir}/${prefix}_161${suffix} \
-V ${indir}/${prefix}_162${suffix} \
-V ${indir}/${prefix}_163${suffix} \
-V ${indir}/${prefix}_164${suffix} \
-V ${indir}/${prefix}_165${suffix} \
-V ${indir}/${prefix}_166${suffix} \
-V ${indir}/${prefix}_167${suffix} \
-V ${indir}/${prefix}_168${suffix} \
-V ${indir}/${prefix}_169${suffix} \
-V ${indir}/${prefix}_170${suffix} \
-V ${indir}/${prefix}_171${suffix} \
-V ${indir}/${prefix}_172${suffix} \
-V ${indir}/${prefix}_173${suffix} \
-V ${indir}/${prefix}_174${suffix} \
-V ${indir}/${prefix}_175${suffix} \
-V ${indir}/${prefix}_176${suffix} \
-V ${indir}/${prefix}_177${suffix} \
-V ${indir}/${prefix}_178${suffix} \
-V ${indir}/${prefix}_179${suffix} \
-V ${indir}/${prefix}_180${suffix} \
-V ${indir}/${prefix}_181${suffix} \
-V ${indir}/${prefix}_182${suffix} \
-V ${indir}/${prefix}_183${suffix} \
-V ${indir}/${prefix}_184${suffix} \
-V ${indir}/${prefix}_185${suffix} \
-V ${indir}/${prefix}_186${suffix} \
-V ${indir}/${prefix}_187${suffix} \
-V ${indir}/${prefix}_188${suffix} \
-V ${indir}/${prefix}_189${suffix} \
-V ${indir}/${prefix}_190${suffix} \
-V ${indir}/${prefix}_191${suffix} \
-V ${indir}/${prefix}_192${suffix} \
-out ${outdir}/${prefix}'_192_scaffolds2.vcf.gz' \
-assumeSorted

