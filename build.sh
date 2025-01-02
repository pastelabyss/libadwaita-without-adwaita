PKGVER=1.6.0
sudo dnf install git meson gi-docgen sassc gobject-introspection vala patch cmake meson libsass gcc glib2-devel
git clone https://gitlab.gnome.org/GNOME/libadwaita.git

build() {
    cd libadwaita
    git checkout $PKGVER
    ../theming_patch.diff patch src/adw-style-manager.c
    meson build --prefix=/usr -Dexamples=false
    ninja -C build
}

package() {
    sudo ninja -C build install
}