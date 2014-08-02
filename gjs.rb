require 'formula'

class Gjs < Formula
  homepage 'https://wiki.gnome.org/Projects/Gjs'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gjs/1.40/gjs-1.40.1.tar.xz'
  sha256 '2f0d80ec96c6284785143abe51377d8a284977ea6c3cf0cef1020d92eae41793'

  depends_on 'pkg-config' => :build
  depends_on 'readline'
  depends_on 'spidermonkey24'
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'TingPing/gnome/cairo' # This should be optional but is not
  depends_on 'TingPing/gnome/gtk+3' => :recommended

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
