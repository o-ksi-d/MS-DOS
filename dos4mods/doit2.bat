set bootsecloc=\devel\dos4\src\boot
set binariesloc=\devel\dos4dist

del bootsec.com
xychop %bootsecloc%\msboot.bin bootsec.com 0x7c00 0x7dff
del dos4flop.img
mkdosfs --boot bootsec.com --sectors 720 -F 12 dos4flop.img
mcopy -i dos4flop.img %binariesloc%\io.sys ::
mcopy -i dos4flop.img %binariesloc%\msdos.sys ::
mcopy -i dos4flop.img %binariesloc%\command.com ::
mcopy -i dos4flop.img %binariesloc%\fdisk.exe ::
mcopy -i dos4flop.img %binariesloc%\format.com ::
mcopy -i dos4flop.img %binariesloc%\sys.com ::
mcopy -i dos4flop.img %binariesloc%\xcopy.exe ::

del dos4.vhd
rem parted mkpart 0x80,0x06,128,71680 dos4.vhd
parted mkpart 0x80,0x0b,504,954072 dos4.vhd
mkdosfs --sectors 954072 --offset 504 -F 16 -n "DOS4" dos4.vhd

rem invalidating the MBR signature will force the MBR to be written
rem by fdisk. Note that this fdisk doesn't have a /MBR option - even hidden
zap dos4.vhd 0x1ff 0x00
