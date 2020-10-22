#Batch converts HEIC images to JPG
#You need to have ImageMagick installed in order for this script to work: https://imagemagick.org/script/download.php#windows/
#Place this .py file in the same folder as your HEIC images and do not use subfolders

import os, subprocess
import time

os.getcwd()
loc = str(input("Enter Folder Path (e.g. D:\Folder): "))
os.chdir(loc)

directory = '.'
N = 1
T = 0
time_old = time.time()

for filename in os.listdir(directory):
    if filename.lower().endswith(".heic"):
        T = T + 1
        continue
print("\n" + "Converting..." + "\n" + str(T) + " HEIC Images Found" + "\n")

for filename in os.listdir(directory):
    if filename.lower().endswith(".heic"): 
        time_diff = time.time() - time_old
        print("Image" + " " + str(N) + "/" + str(T) + " " + 'Converting %s...' % os.path.join(directory, filename) + " Total Elapsed Time = " + str(int(time_diff // 60)) + " minute(s) " + str(round(time_diff % 60, 3)) + " seconds" + '\n')
        subprocess.run(["magick", "%s" % filename, "%s" % (filename[0:-5] + '.jpg')])
        N = N+1
        continue
