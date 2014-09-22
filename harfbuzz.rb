require "formula"

class Harfbuzz < Formula
  homepage "http://www.freedesktop.org/wiki/Software/HarfBuzz"
  url "http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.35.tar.bz2"
  sha1 "6f4401af396069214be2ba15b884361ef540e501"

  bottle do
     root_url 'http://dl.tingping.se/homebrew'
  end

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gobject-introspection"
  depends_on "icu4c"
  depends_on "freetype"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-coretext=yes
      --with-freetype=yes
      --with-icu
      --enable-introspection
    ]

    system "./configure", *args
    system "make", "install"
  end
end
