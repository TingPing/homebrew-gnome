require 'formula'

class Gdl < Formula
  homepage "https://developer.gnome.org/gdl/"
  url "http://ftp.gnome.org/pub/GNOME/sources/gdl/3.12/gdl-3.12.0.tar.xz"
  sha256 "4770f959f31ed5e616fe623c284e8dd6136e49902d19b6e37938d34be4f6b88d"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "libxml2"
  depends_on "gtk+3"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
