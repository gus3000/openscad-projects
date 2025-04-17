import sys
import subprocess
import os

OPENSCAD_EXECUTABLE = "C:\Program Files\OpenSCAD (Nightly)\openscad.exe"

def help():
    print("usage :", sys.argv[0],"scadFile","color1,color2,color3...")
    exit()

print("Rendering file with all colors")
# print(sys.argv)
try:
    scadFile = sys.argv[1] or help()
    colors = sys.argv[2]
except IndexError:
    help()

print("scad file :", scadFile)
colors = colors.split(",")
print("colors :", colors)

for color in colors:
    subprocess.run([OPENSCAD_EXECUTABLE,"-D", f'_WhichColor="{color}"', scadFile, "-o",f"{scadFile}-{color}.stl"])