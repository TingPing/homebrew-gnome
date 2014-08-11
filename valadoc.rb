require 'formula'

class Valadoc < Formula
  homepage 'https://wiki.gnome.org/Projects/Valadoc'
  head 'git://git.gnome.org/valadoc'

  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'graphviz'
  depends_on 'glib'
  depends_on 'libgee'
  depends_on 'vala'

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end
