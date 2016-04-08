chromium-minimal-tab
====================

Chromium without the close buttons on tabs, for ArchLinux.

Screenshot:

![screenshot](screenshot.png)

The PKGBUILD is modified minimally from the official [chromium
package](https://www.archlinux.org/packages/extra/x86_64/chromium/). The most
recent version of the original PKGBUILD can be found on the branch
``arch-official``. Changes in the package from Arch upstream will be manually
merged into ``master`` from time to time.

Current version: 49.0.2623.110

## Usage

Build the package using the standard ``makepkg`` command:

```
cd chromium
makepkg -s
```

Then, install the resulting package using ``pacman``:

```
pacman -U <chromium-version.pkg.tar.xz>
```

Note that this will replace the previously installed chromium package, if any.
