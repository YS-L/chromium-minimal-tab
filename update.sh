#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: update.sh PATH"
	exit
fi

PREV=$(grep "Current version:" README.md | sed s/"Current version: "//)

echo "Syncing ArchLinux packages..."
ARCHREPOS=$1
cd $ARCHREPOS
git pull

echo "Syncing arch-official..."
cd -
git checkout arch-official
rm -rf chromium
cp -r $ARCHREPOS/chromium/trunk chromium
CURRENT=$(grep "pkgver=" chromium/PKGBUILD | sed s/"pkgver="//)
git add -A
git commit -m "Bump arch-official to $CURRENT"

echo "Trying to merge arch-official into master..."
git checkout master

# Only merge if versions are different; otherwise this would undo the custom
# patch, which makes no sense.
if [ $PREV = $CURRENT ]; then
	echo "Version is updated; nothing to do. Done."
	exit
fi

git merge arch-official

if [ $? -neq 0 ]; then
	echo "Merge failed; check"	
	exit
fi

echo "Merge succeeded; bumping version in README..."
echo "Previous version: $PREV"
echo "Current version: $CURRENT"
sed s/"$PREV"/"$CURRENT"/ -i README.md
git add README.md
git commit -m "Bump version to $CURRENT"

echo "Done."
