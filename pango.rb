require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.6.tar.xz"
  sha256 "4c53c752823723875078b91340f32136aadb99e91c0f6483f024f978a02c8624"

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
