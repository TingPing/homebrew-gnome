require 'formula'

class YelpXsl < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/yelp-xsl/3.12/yelp-xsl-3.12.0.tar.xz'
  sha256 'dd0b8af338b1cdae50444273d7c761e3f511224421487311103edc95a4493656'

  depends_on 'pkg-config' => :build
  depends_on 'itstool' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end
