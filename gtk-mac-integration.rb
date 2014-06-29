require 'formula'

class GtkMacIntegration < Formula
  homepage 'https://wiki.gnome.org/Projects/GTK+/OSX/Integration'

#  stable do
#    url 'http://ftp.gnome.org/pub/gnome/sources/gtk-mac-integration/2.0/gtk-mac-integration-2.0.5.tar.xz'
#    sha256 '6c4ff7501d7ff35e49068052d80fcf76ce494e5953c5f3967e4958b1b0c67b9f'
#  end

  head do
      url 'git://git.gnome.org/gtk-mac-integration'
      depends_on 'gnome-common' => :build
      depends_on 'automake' => :build
      depends_on 'autoconf' => :build
      depends_on 'libtool' => :build
  end

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gtk-doc' => :build
  depends_on 'glib'
  depends_on 'TingPing/gnome/gtk+3' => :optional
  depends_on 'TingPing/gnome/gtk+' => :optional

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    # TODO: Fix building against both upstream.
    if build.with? 'gtk+3'
        args << '--with-gtk3'
    elsif build.with? 'gtk+'
        args << '--with-gtk2'
    else
        onoe 'You must build with either gtk+3 or gtk+ support.'
        exit
    end

    # TODO: Fix ./autogen.sh upstream.
    system "gnome-autogen.sh", *args
    system "make install"
  end
end
