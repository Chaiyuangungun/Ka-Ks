import argparse

def get_ids(id_file):
    ids = []
    with open(id_file,"r") as f1:
        for line in f1:
            ids.append(line.strip())
    return ids
def write_run(ids):
    with open("run.sh","w") as f1:
        for num in range(len(ids)-1):#3 1
            for num_1 in range(len(ids)-num-1):#1
                f1.write("cat "+ids[num]+" "+ids[num_1+num+1]+" > "+ids[num].replace(".fa","")+"_"+ids[num_1+num+1].replace("gene","")+"\n")

        
parser = argparse.ArgumentParser(description='manual to this script')
parser.add_argument("-input", type=str)#文件id
args = parser.parse_args()  

id_file = args.input
ids = get_ids(id_file)
write_run(ids)
