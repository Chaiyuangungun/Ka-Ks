###准备文件，蛋白序列文件，cds序列文件
####第一步---序列比对####
##1、蛋白序列比对##
#更改sample.pep.fasta为蛋白序列文件名，sample.cds.fasta为cds文件名#
muscle -in sample.pep.fasta -out sample_BD.pep.fasta ###如果没有muscle可以conda install muscle，也可以有其他序列比对软件
##2、蛋白序列与cds序列比对##
pal2nal.pl  sample_BD.pep.fasta  sample.cds.fasta -output fasta > cds_pep_aln.fa ###安装pal2nal.v14###
###wget http://www.bork.embl.de/pal2nal/distribution/pal2nal.v14.tar.gz
###tar -zxvf pal2nal.v14.tar.gz
###cd pal2nal.v14/
###可以看到pal2nal.pl，将其加入环境变量
### echo "export PATH=$PATH:/share/home/stu_chaikun/biosoft/pal2nal.v14/" >> ~/.bash_profile
### source ~/.bash_profile
##3、拆分并合并基因对##
csplit cds_pep_aln.fa /\>/ -n2 -s {*} -f gene -b "%1d.fa" ; rm gene0.fa ###csplit linux的文件拆分命令，具体参数自己搜索
rm cds_pep_aln*
ls *.fa >input_1
python3 KaKs_1.py -input input_1
bash run.sh
##4、转化fa文件为axt格式文件##
for i in *_*.fa
do
echo $i
perl parseFastaIntoAXT.pl $i
done
##5、计算Ka/Ks##
for i in *.fa.axt
do
echo $i
KaKs_Calculator  -i $i -o ${i%%.*}.kaks  ###KaKs_Calculator计算Ka/Ks
done
##6、合并Ka/Ks结果
ls *.kaks > input_2
python3 KaKs_2.py -input input_2 -output result
###结果result---共3列，第一列为计算的2个基因id，第二列为Ka/Ks，第三列为Pvalue
