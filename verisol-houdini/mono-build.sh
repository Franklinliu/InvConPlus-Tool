PREFIX=/usr/local
VERSION=6.0.0.166
wget https://download.mono-project.com/sources/mono/mono-$VERSION.tar.xz
tar xvf mono-$VERSION.tar.xz
cd mono-$VERSION
./configure --prefix=$PREFIX
make
sudo make install