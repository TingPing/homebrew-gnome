require 'formula'

class GtkMacIntegration < Formula
  homepage 'https://wiki.gnome.org/Projects/GTK+/OSX/Integration'

#  stable do
#    url 'http://ftp.gnome.org/pub/gnome/sources/gtk-mac-integration/2.0/gtk-mac-integration-2.0.5.tar.xz'
#    sha256 '6c4ff7501d7ff35e49068052d80fcf76ce494e5953c5f3967e4958b1b0c67b9f'
#  end

  head do
      # Fork with a few improvements, will merge upstream
      url 'https://github.com/TingPing/gtk-mac-integration.git', :branch => 'build'
      depends_on 'gnome-common' => :build
      depends_on 'automake' => :build
      depends_on 'autoconf' => :build
      depends_on 'libtool' => :build
  end

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gtk-doc' => :build
  depends_on 'glib'
  depends_on 'gtk+3' => :optional
  depends_on 'gtk+' => :recommended

  if build.without?("gtk+3") && build.without?("gtk+")
    odie "You must build with gtk+ and/or gtk+3 support."
  end

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    if build.with? 'gtk+3'
        args << '--with-gtk3'
    end
    if build.with? 'gtk+'
        args << '--with-gtk2'
    end

    system "./autogen.sh", *args
    system "make", "install"
  end
end
