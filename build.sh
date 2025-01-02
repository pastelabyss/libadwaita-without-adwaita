#!/bin/bash

PKGVER=1.6.0

prepare() {
    sudo dnf remove libadwaita
    sudo dnf install git meson gi-docgen sassc gobject-introspection vala patch cmake meson libsass gcc glib2-devel
    git clone https://gitlab.gnome.org/GNOME/libadwaita.git
}
build() {
    cd libadwaita
    git checkout $PKGVER
    ../theming_patch.diff patch src/adw-style-manager.c
    meson build --prefix=/usr -Dexamples=false
    ninja -C build
}

install_libadwaita() {
    sudo ninja -C build install
}

main() {
    # Prepare for build
    prepare()
    # Build
    build()
    # Install with ninja
    install_libadwaita()
}
