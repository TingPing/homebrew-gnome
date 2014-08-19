require "formula"

class Gedit < Formula
  homepage "https://wiki.gnome.org/Apps/Gedit"
  # Use git because the tarball doesn"t include ./autogen.sh...
  url "git://git.gnome.org/gedit", :tag => "3.12.2"

  # spell check is broken atm...
  #option "with-spell", "build spell check plugin"
  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "xz" => :build
  depends_on "vala" => :optional
  depends_on :python => :optional
  depends_on "gobject-introspection" => :optional
  depends_on "gettext"
  depends_on "libsoup"
  #depends_on "iso-codes" if build.with? "spell"
  #depends_on "TingPing/gnome/enchant-applespell" if build.with? "spell"
  depends_on "TingPing/gnome/libpeas"
  depends_on "TingPing/gnome/gtksourceview3"
  depends_on "TingPing/gnome/gtk+3"
  depends_on "TingPing/gnome/gtk-mac-integration" => "with-gtk+3"

  # Need these for the patches below
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "gtk-doc" => :build
  depends_on "TingPing/gnome/yelp-tools" => :build

  PATCH_BASE = "https://gist.githubusercontent.com/TingPing/882d261110ad38cf6992/raw/"
  patch do
    url PATCH_BASE + "6c2b29444b1e463ffa6668844063bec05de6f295/0001-Fixes-for-new-GtkosxApplication-API.patch"
    sha1 "aff984fbf41fb44181daa1a0914b4f795511bbc0"
  end
  patch do
    url PATCH_BASE + "7d444d60cfb19b1c76ffa94b8b9949bc3f9b58a4/0002-Fix-spell-checker-to-user-new-Gtkosx-API.patch"
    sha1 "8d8e85c10139cc12d97757537d3c9aa0fbcc5fc7"
  end
  patch do
    url PATCH_BASE + "c84390d6d9e035e62ec05010f09b39ad35960b41/0003-Prevent-Cocoa-command-line-argument-parsing-for-file.patch"
    sha1 "4b015b5b573beb81132b6d6712446e669898ebad"
  end
  patch do
    url PATCH_BASE + "cee086f9273d153d574920e5fc3d514a527ea872/0004-Check-for-gtk-mac-integration-gtk3.patch"
    sha1 "fc8da516380cb3348dd532217059f0fc2679ae62"
  end
  patch do
    url PATCH_BASE + "3166217dae811ef4d2cb9200a55b80c6a0683667/0005-Silence-Wformat-nonliteral-errors-with-clang.patch"
    sha1 "1aaf6affd4f0afe459623d81d0bac8343677504c"
  end
  patch do
    url PATCH_BASE + "782b9fb191a2635dfda3d0277b3bb2bf882b3abd/0006-Fix-api-change-on-OSX.patch"
    sha1 "afc3104facf326f797c649b60953baabca7ea379"
  end
  patch do
    url PATCH_BASE + "c85e464adef918f134fc24f8a52c16e5b7724f12/0007-Just-disable-outdated-OSX-code-for-now.patch"
    sha1 "22dbbca2d374590f16db6b067654e4ed220a61eb"
  end

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-schemas-compile
      --disable-spell
    ]

    #if build.without? "spell"
    #  args << "--disable-spell"
    #end

    system "./autogen.sh", *args
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "--targetdir=#{HOMEBREW_PREFIX}/etc/glib-2.0/schemas",
            "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end
end
