How to build DOS4 from sources

After getting a snapshot from github, on a Windows 2000 system
(tip - when running DOS programs under Windows 2000 under qemu under
Manjaro Linux on a Pinebook Pro, don't do alt-tab while grabbed or
everything grinds to a near-halt. In fact, don't change the grab status
either, otherwise nmake hangs e.g.):


Copy all of these things into the src directory
Modify setenv.bat as below and run it once
Run doit.bat
Explanation below.



edit setenv.bat
don't set CL=cl etc - that will cause them to self-compile as they are
  being used as extra parameters (controlled by tools.inc)
set this to the complete source tree path, not including the word "src"
  nor the trailing backslash:
set BAKROOT=e:\devel\dos4
the INCLUDE and LIB are incorrect and need a "bld" inserted
you can add ;%path% to the end of the PATH statement
so you end up with:
set LIB=%BAKROOT%\src\tools\bld\lib
set INCLUDE=%BAKROOT%\src\tools\bld\inc
set PATH=%BAKROOT%\src\tools;%path%

Some of the utilities (like message creation) need
CRLF, so we zip them with -l

I had a situation where building stopped and dir2.obj
was 0 bytes in size. No error message. Deleting dir2.obj
and running nmake again worked fine.

Also, likely triggered by lack of CRs in makefiles, nmake
behaves as if is it fully-buffered instead of line-buffered,
so it may be hung on a command reading from redirected stdin,
which itself is suffering from lack of CR, so you don't know
that a running command has hung.

nosrvbld managed to get a null pointer assignment in xma2ems
even with a corrected skl. Deleting the cl1 and rerunning
nmake ran successfully - and produced the exact same cl1 file.


cpy.bat will bundle up all the files, but you sort of still
need the 512 bytes starting at 0x7c00 in boot\msboot.bin in
order to create a boot floppy.

Which you can do by reading then executing doit2.bat

The provided autoexec.bat may be useful given that you
only have access to edlin on the DOS 4.0 system I think.

Note that you will need to manipulate the VHD yourself
to put all the built executables and source on it for
a fully functional system.

e.g. on Windows 10 you can go into disk management and mount it.
On Linux:
sudo mount -o loop,umask=000,offset=$((504*512)) -t vfat dos4.vhd mnt
(and "sudo umount mnt" to reverse)
(assuming you have done a "mkdir mnt" to create an empty directory)
