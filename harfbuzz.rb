require "formula"

class Harfbuzz < Formula
  homepage "http://www.freedesktop.org/wiki/Software/HarfBuzz"
  url "http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.33.tar.bz2"
  sha256 "d313c5bf04b8acd01e8f16979d6d2e5fe65184eb28816b70ea0f374be11314c7"

  bottle do
     root_url 'http://dl.tingping.se/homebrew'
  end

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gobject-introspection"
  depends_on "freetype"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-coretext=yes
      --with-freetype=yes
      --enable-introspection
    ]

    system "./configure", *args
    system "make", "install"
  end
end
