require 'formula'

class GnomeThemesStandard < Formula
  homepage 'http://gnome.org'
  url 'https://download.gnome.org/core/3.14/3.14.2/sources/gnome-themes-standard-3.14.2.tar.xz'
  sha256 '2fc21963bd8b65afff9a7f1b025035adc6d9db2810a134172c7a0155d81a7d28'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'glib' => :build
  depends_on 'gettext'
  depends_on 'gtk+3' => :recommended
  depends_on 'gtk+' => :optional
  depends_on 'librsvg' => ['without-x11', 'with-gtk+3', :build] # FIXME: gtk+ if build.with gtk+

  if build.without?("gtk+3") && build.without?("gtk+")
    odie "You must build with gtk+ and/or gtk+3 support."
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    if build.without? 'gtk+3'
      args << '--disable-gtk3-engine'
    elsif build.without? 'gtk+'
      args << '--disable-gtk2-engine'
      ENV["GTK_UPDATE_ICON_CACHE"] = "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"
    end

    system "./configure", *args

    # Install requires the svg module for gdk-pixbuf
    ENV["GDK_PIXBUF_MODULEDIR"] = "#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV["GDK_PIXBUF_MODULE_FILE"] = "#{HOMEBREW_PREFIX}/etc/gtk-2.0/gdk-pixbuf.loaders"

    system "#{Formula["gdk-pixbuf"].opt_bin}/gdk-pixbuf-query-loaders", "--update-cache"
    system "make", "install"
  end
end
