require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.7.tar.xz"
  sha1 "8cdb1b45bbbec373256695e019f07cd6716980b8"

  bottle do
    root_url 'http://dl.tingping.se/homebrew'
    revision 1
  end

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'TingPing/gnome/cairo'
  depends_on 'TingPing/gnome/harfbuzz'
  depends_on 'fontconfig'
  depends_on 'gobject-introspection'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection=yes
      --without-xft
    ]

    system "./configure", *args
    system "make", "install"
  end

  def post_install
    system "#{bin}/pango-querymodules > '#{HOMEBREW_PREFIX}/etc/pango/pango.modules'"
  end

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end
