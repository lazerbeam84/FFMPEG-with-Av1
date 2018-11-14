#!/usr/bin/env bash

echo "#######################################"
echo "#######################################"
echo "##          Starting Install         ##"
echo "## Copyright @github.com/lazerbeam84 ##"
echo "#######################################"
echo "#######################################"
echo "---------------------------------------"

echo "######################"
echo "## Installing preps ##"
echo "######################"

apt-get update
apt-get -y dist-upgrade

echo "---------------------------------------"
echo "#######################"
echo "## Installing Components ##"
echo "#######################"

apt-get -y install autoconf automake build-essential git cmake git-core libass-dev libfreetype6-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev libx264-dev yasm libx265-dev libnuma-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev

echo "---------------------------------------"
echo "#######################"
echo "## Installing FFMPEG ##"
echo "#######################"

mkdir -p ~/ffmpeg_sources ~/bin
cd ~/ffmpeg_sources
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2
tar xjvf nasm-2.13.03.tar.bz2
cd nasm-2.13.03
./autogen.sh



PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
echo "---------------------------------------"
echo "###############################"
echo "## Installing libaom modules ##"
echo "###############################"

cd ~/ffmpeg_sources
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir aom_build
cd aom_build
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED=off -DENABLE_NASM=on ../aom
PATH="$HOME/bin:$PATH" make
make install

echo "---------------------------------------"
echo "################################"
echo "## Installing FFMPEG Snapshot ##"
echo "################################"
cd ~/ffmpeg_sources
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --extra-libs="-lpthread -lm" --bindir="$HOME/bin" --enable-gpl --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-nonfree
PATH="$HOME/bin:$PATH" make
make install

echo "---------------------------------------"
echo "######################"
echo "## Managing Sources ##"
echo "######################"

hash -r
echo "export PATH=$PATH:$HOME/bin" >> ~/.bashrc
source ~/.profile
source ~/.bashrc

echo "---------------------------------------"
echo "#######################################"
echo "#######################################"
echo "##          Installation DONE        ##"
echo "## Copyright @github.com/lazerbeam84 ##"
echo "#######################################"
echo "#######################################"
