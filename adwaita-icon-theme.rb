require 'formula'

class AdwaitaIconTheme < Formula
  homepage 'http://gtk.org/'
  url 'https://download.gnome.org/core/3.14/3.14.2/sources/adwaita-icon-theme-3.14.1.tar.xz'
  sha256 'b776a7ad58c97f4c1ede316e44d8d054105429cb4e3a8ec46616a14b11df48ee'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build
  depends_on 'gtk+' => :build # Just for bin/gtk-update-icon-cache
  #depends_on 'inkscape' => :optional

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
