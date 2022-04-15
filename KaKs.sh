###准备文件，蛋白序列文件，cds序列文件
####第一步---序列比对####
##1、蛋白序列比对##
muscle -in sample.pep.fasta -out sample_BD.pep.fasta ###如果没有muscle可以conda install muscle，也可以有其他序列比对软件
##2、蛋白序列与cds序列比对##
pal2nal.pl  sample_BD.pep.fasta  sample.cds.fasta -output fasta > cds_pep_aln.fa 
##3、拆分并合并基因对##
csplit cds_pep_aln.fa /\>/ -n2 -s {*} -f gene -b "%1d.fa" ; rm gene0.fa ###csplit linux的文件拆分命令，具体参数自己搜索
ls *.fa >input_1
python3 KaKs_1.py -input input_1
bash run.sh
##4、转化fa文件为axt格式文件##
for i in *.fa
do
echo $i
perl parseFastaIntoAXT.pl $i
done
##5、计算Ka/Ks##
for i in *.fa.axt
do
echo $i
KaKs_Calculator  -i $i -o ${i%%.*}.kaks.  ###KaKs_Calculator计算Ka/Ks
done
##6、合并Ka/Ks结果
ls *.kaks > inupt_2
python3 KaKs_2.py -input input_2 -output result
###结果result---共3列，第一列为计算的2个基因id，第二列为Ka/Ks，第三列为Pvalue
