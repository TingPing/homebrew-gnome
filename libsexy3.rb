require 'formula'

class Libsexy3 < Formula
  homepage 'http://tingping.github.io/libsexy3/'
  head 'https://github.com/TingPing/libsexy3.git'
  url 'https://github.com/TingPing/libsexy3/releases/download/v1.0.0/libsexy3-1.0.0.tar.xz'
  sha1 'e01bcce6bb1d73cdf4f24bf134e18c2923c667ba'

  head do
    depends_on 'gnome-common' => :build
    depends_on 'automake' => :build
    depends_on 'autoconf' => :build
    depends_on 'libtool' => :build
    depends_on 'gtk-doc' => :build
  end

  depends_on 'intltool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'gobject-introspection' => :recommended
  depends_on 'vala' => :recommended
  depends_on 'iso-codes'
  depends_on 'TingPing/gnome/enchant-applespell'
  depends_on 'gtk+3' => 'without-x11'

  def install
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end
end
