#!/bin/bash

#if there is no input, default to "lab" only
if [ "$#" -eq 0 ]; then
divs=(lab);
else
divs=("$@");
fi
#setting up the variables
lgrnd="lgrind -i -o ";
cgcc="gcc -g -o labc ";
asmgcc="gcc -g -o labasm ";
texext=".tex ";
cext=".c";
asmext=".s";

#creating the c code portion of the makefile
echo -n "labc: "
for d in "${divs[@]}"; 
do 
echo -n "$d$cext ";
done
echo "";
echo -e -n "\t $cgcc";
for d in "${divs[@]}"; 
do 
echo -n "$d$cext ";
done
echo "";

#creating the assembly code portion of the makefile
echo -n "labasm: "
for d in "${divs[@]}"; 
do 
echo -n "$d$asmext ";
done
echo "";
echo -e -n "\t $asmgcc";
for d in "${divs[@]}"; 
do 
echo -n "$d$asmext ";
done
echo "";

#creating the latex documentation portion of the makefile
echo -n "doc: "
for d in "${divs[@]}"; 
do 
echo -n "$d$cext ";
echo -n "$d$asmext ";
done
echo "";

for d in "${divs[@]}"; 
do 
echo -e -n "\t";
echo "$grnd""$d$texext""$d$cext";
echo -e -n "\t";
echo "$grnd""$d$texext""$d$asmext";
done
#generating a pdf document from the files
echo -e "\tlatex lab.tex"
echo -e "\tdvipdf lab.dvi"
