require 'formula'

class AdwaitaIconTheme < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.13/adwaita-icon-theme-3.13.3.tar.xz'
  sha256 '09528cd1ce938bd85dd892225e1ba1a1c6338df451613df9829d68c7b98befd5'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build
  depends_on 'TingPing/gnome/gtk+' => :build # Just for bin/gtk-update-icon-cache
  #depends_on 'inkscape' => :optional

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
