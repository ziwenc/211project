import os
count = 0

for filename in os.listdir("."):
    if(filename.endswith(".dcm")):
        count+=1
        print filename
        print count
        os.rename(filename,"%d.dcm"%count)
