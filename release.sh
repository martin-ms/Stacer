#!/bin/bash
VERSION=1.3.3
DIR=stacer-$VERSION
export VERSION=$VERSION

rm -rf release build
mkdir release build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++ ..
make -j $(nproc)
cd ..

mkdir -p release/$DIR/stacer
cp -r icons applications debian release/$DIR
cp -r build/output/* release/$DIR/stacer
cp icons/hicolor/256x256/apps/stacer.png release/$DIR/stacer
cat applications/stacer.desktop > release/$DIR/stacer/default.desktop

# translations
lupdate stacer/stacer.pro -no-obsolete
lrelease stacer/stacer.pro
mkdir -p release/$DIR/stacer/translations
mv translations/*.qm release/$DIR/stacer/translations

# tarball
tar -czf release/$DIR.tar.gz -C release $DIR

# linuxdeployqt
wget -qc https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage
chmod +x linuxdeployqt-continuous-x86_64.AppImage

unset QTDIR
unset QT_PLUGIN_PATH
unset LD_LIBRARY_PATH

./linuxdeployqt-continuous-x86_64.AppImage release/$DIR/stacer/stacer -bundle-non-qt-libs -no-translations -unsupported-allow-new-glibc -appimage
mv Stacer-$VERSION-x86_64.AppImage release

rm linuxdeployqt-continuous-x86_64.AppImage

cd release/$DIR
dh_make --createorig --indep --yes
debuild --no-lintian -us -uc
