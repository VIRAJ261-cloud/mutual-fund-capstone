import os
folder = os.path.join(os.path.dirname(os.path.dirname(os.getcwd())),"data","raw")
filepath = os.path.join(os.getcwd(),"dataFolder.txt")
with open(filepath,"w") as f:
    f.write(folder)

