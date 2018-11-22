#!/usr/bin/env bash

echo "---------------------------------------"
echo "#######################################"
echo "#######################################"
echo "##          Starting Install         ##"
echo "## Copyright @github.com/lazerbeam84 ##"
echo "#######################################"
echo "#######################################"
echo "---------------------------------------"

echo "---------------------------------------"
echo "######################"
echo "## Installing preps ##"
echo "######################"
echo "---------------------------------------"

apt-get update -y
apt-get -y dist-upgrade
echo "---------------------------------------"
echo "---------------------------------------"
echo "#"
echo "#L#"
echo "#LA#"
echo "#LAZ#"
echo "#LAZE#"
echo "#LAZER#"
echo "#LAZERB#"
echo "#LAZERBE#"
echo "#LAZERBEA#"
echo "#LAZERBEAM#"
echo "##LAZERBEAM8#"
echo "##LAZERBEAM84##"
echo "##LAZERBEAM84######"
echo "##LAZERBEAM84#########"
echo "##LAZERBEAM84############"
echo "#############################"
echo "## Installing Dependencies ##"
echo "#############################"
echo "---------------------------------------"
echo "---------------------------------------"openssl

apt-get -y install autoconf automake build-essential git libgnutls28-dev cmake git-core libass-dev libfreetype6-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev  libxcb-shm0-dev libssl-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev libx264-dev yasm libx265-dev libnuma-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev libzthread-2.3-2 libzthread-dev doxygen

echo "---------------------------------------"
echo "#######################"
echo "## Installing FFMPEG ##"
echo "#######################"
echo "---------------------------------------"

echo "---------------------------------------"
echo "#######################"
echo "## Installing NASM ##"
echo "#######################"
echo "---------------------------------------"

echo "---------------------------------------"
mkdir -p ~/ffmpeg_sources ~/bin
cd ~/ffmpeg_sources
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2
tar xjvf nasm-2.13.03.tar.bz2
rm -rf nasm-2.13.03.tar.bz2
cd nasm-2.13.03
./autogen.sh
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
echo "---------------------------------------"

echo "---------------------------------------"
echo "###############################"
echo "## Installing libaom modules ##"
echo "###############################"
echo "---------------------------------------"

echo "---------------------------------------"
mkdir -p ~/ffmpeg_sources/libaom
cd ~/ffmpeg_sources/libaom
git clone https://aomedia.googlesource.com/aom
cmake ./aom
make
make install
ldconfig -v
echo "---------------------------------------"

echo "---------------------------------------"
echo "################################"
echo "## Installing FFMPEG Snapshot ##"
echo "################################"
echo "---------------------------------------"
cd ~/ffmpeg_sources
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
rm -rf ffmpeg-snapshot.tar.bz2cd 
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" 
./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --extra-libs="-lpthread -lm" \
	--bindir="$HOME/bin" --enable-gpl --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx \
	--enable-libx264 --enable-libx265 --enable-nonfree 
PATH="$HOME/bin:$PATH" 
make
make install
ldconfig -v
hash -r
echo "---------------------------------------"

echo "---------------------------------------"
echo "############################"
echo "## Building Documentation ##"
echo "############################"
echo "---------------------------------------"

echo "MANPATH_MAP $HOME/bin $HOME/ffmpeg_build/share/man" >> ~/.manpath
echo "HTML formatted documentation is available in ~/ffmpeg_build/share/doc/ffmpeg."

echo "---------------------------------------"
echo "######################"
echo "## Managing Sources ##"
echo "######################"
echo "---------------------------------------"
cd ~
source ~/.profile
source ~/.bashrc
cp ~/bin/ffmpeg /usr/bin/
cp ~/bin/ffplay /usr/bin/
cp ~/bin/ffprobe /usr/bin/

ffplay http://www.wowza.com/_h264/BigBuckBunny_115k.mov

echo "---------------------------------------"
echo "---------------------------------------"
echo "#######################################"
echo "#######################################"
echo "##          Installation DONE        ##"
echo "## Copyright @github.com/lazerbeam84 ##"
echo "#######################################"
echo "#######################################"
echo "---------------------------------------"
echo "---------------------------------------"
