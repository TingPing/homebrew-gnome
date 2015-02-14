require 'formula'

class AdwaitaIconTheme < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.13/adwaita-icon-theme-3.13.91.tar.xz'
  sha256 'd0cf4705d3439c68d344431b62cca5fe6fcf91bd38c745c48b2476d0aa41b8ad'

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
