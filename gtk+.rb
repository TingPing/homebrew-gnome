require 'formula'

class Gtkx < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.24.tar.xz'
  sha256 '12ceb2e198c82bfb93eb36348b6e9293c8fdcd60786763d04cfec7ebe7ed3d6d'
  
  bottle do
      root_url 'http://dl.tingping.se/homebrew'
      sha1 "c5171dc78f7288dde81ba63b63bb3bb251fad6cc" => :mavericks
  end

  depends_on 'pkg-config' => :build
  depends_on 'jasper' => :optional
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'gdk-pixbuf'
  depends_on 'atk'
  depends_on 'TingPing/gnome/pango'
  depends_on 'TingPing/gnome/cairo'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--disable-visibility",
                          "--with-gdktarget=quartz"
    system "make install"
  end
end
