copy getmsg.asm mapper
copy select2.asm select
copy panel.inf select

cd boot
zip -X -l -m temp *.skl
unzip temp
cd ..

cd bios
zip -X -l -m temp *.skl locscr
unzip temp
cd ..

cd dos
zip -X -l -m temp *.skl
unzip temp
cd ..

cd cmd\fdisk
zip -X -l -m temp fdisk5.skl
unzip temp
cd ..\..

cd dev\display
zip -X -l -m temp zero.dat
unzip temp
cd ..\..

cd dev\printer
zip -X -l -m temp zero.dat
unzip temp
cd ..\..

cd dev\xma2ems
zip -X -l -m temp *.skl
unzip temp
cd ..\..

cd dev\xmaem
zip -X -l -m temp *.skl
unzip temp
cd ..\..

nmake