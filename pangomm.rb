require 'formula'

class Pangomm < Formula
  homepage 'http://www.pango.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pangomm/2.34/pangomm-2.34.0.tar.xz'
  sha256 '0e82bbff62f626692a00f3772d8b17169a1842b8cc54d5f2ddb1fec2cede9e41'

  depends_on 'pkg-config' => :build
  depends_on 'TingPing/gnome/pango'
  depends_on 'glibmm'
  depends_on 'TingPing/gnome/cairomm'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
