require 'formula'

class GnomeThemesStandard < Formula
  homepage 'http://gnome.org'
  url 'https://download.gnome.org/core/3.12/3.12.2/sources/gnome-themes-standard-3.12.0.tar.xz'
  sha256 'a05d1b7ca872b944a69d0c0cc2369408ece32ff4355e37f8594a1b70d13c3217'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'glib' => :build
  depends_on 'gettext'
  depends_on 'TingPing/gnome/gtk+3'
  depends_on 'TingPing/gnome/librsvg' => ['with-gtk+3', :build]

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end
