import argparse

def get_ids(id_file):
    ids = []
    with open(id_file,"r") as f1:
        for line in f1:
            ids.append(line.strip())
    return ids
def write(ids,outfile):
    result = {}
    for id in ids:
        with open(id,"r") as f1:
            for line in f1:
                lines = line.strip().split()
                if lines[0] == "Sequence":
                    continue
                id = lines[0]
                ka_ks = lines[4]
                Pvalue = lines[5]
                result[id] = ka_ks+"\t"+Pvalue
    with open(outfile,"w") as f2:
        f2.write("Sequence\tKa/Ks\tPvalue\n")
        for id in result:
            f2.write(id+"\t"+result[id]+"\n")
parser = argparse.ArgumentParser(description='manual to this script')
parser.add_argument("-input", type=str)#文件id
parser.add_argument("-output", type=str)#文件id
args = parser.parse_args()  

id_file = args.input
outfile = args.output
ids = get_ids(id_file)
write(ids,outfile)
