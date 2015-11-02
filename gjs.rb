require 'formula'

class Gjs < Formula
  homepage 'https://wiki.gnome.org/Projects/Gjs'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gjs/1.44/gjs-1.44.0.tar.xz'
  sha256 '88c960f6ad47a6931d123f5d6317d13704f58572f68a4391913a254ff27dce80'

  depends_on 'pkg-config' => :build
  depends_on 'readline'
  depends_on 'spidermonkey24'
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'cairo' # This should be optional but is not
  depends_on 'gtk+3' => :recommended

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
