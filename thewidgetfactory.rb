require 'formula'

class Thewidgetfactory < Formula
  homepage 'https://github.com/TingPing/thewidgetfactory'
  head 'https://github.com/TingPing/thewidgetfactory.git'

  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'TingPing/gnome/gtk+'

  def install
    system "./autogen.sh", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end
