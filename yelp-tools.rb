require 'formula'

class YelpTools < Formula
  homepage 'http://gtk.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/yelp-tools/3.12/yelp-tools-3.12.1.tar.xz'
  sha256 '7a5370d7adbec3b6e6b7b5e7e5ed966cb99c797907a186b94b93c184e97f0172'

  depends_on 'pkg-config' => :build
  depends_on 'itstool' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build
  depends_on 'yelp-xsl'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end
