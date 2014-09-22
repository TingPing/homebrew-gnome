require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/3.14/gtk+-3.14.0.tar.xz'
  sha256 '68d6b57d15c16808d0045e96b303f3dd439cc22a9c06fdffb07025cd713a82bc'
  
  bottle do
      root_url 'http://dl.tingping.se/homebrew'
  end

  # 3 Patches to fix the menu bar
  patch do
    url 'https://github.com/jessevdk/gtk/commit/6fff515765d78967f589e1a31d2d6e3c1440b924.diff'
    sha1 '28cf087d47d0a7acfa641c46b742d7ba2375f571'
  end
  patch do
    url 'https://github.com/jessevdk/gtk/commit/311ec2fd5457ad5db163a8c3cdf3802b966bfa2a.diff'
    sha1 '0a7607b39134c3f21220d163ff0fefaaee841e83'
  end
  patch do
    url 'https://github.com/jessevdk/gtk/commit/b6bb19b498e3975ed6468426ffcace79e7d04cfa.diff'
    sha1 '406c3af3967f6c9465194ee03493100dae2d6324'
  end

  # TODO: Maybe pull over more patches.. hopefully 3.14.1 gets these.

  depends_on 'pkg-config' => :build
  depends_on 'jasper' => :optional
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'gdk-pixbuf'
  depends_on 'atk'
  depends_on 'TingPing/gnome/pango'
  depends_on 'TingPing/gnome/cairo'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--enable-quartz-backend",
                          "--disable-schemas-compile"
    system "make install"
    # Prevent a conflict between this and Gtk+2
    mv bin/'gtk-update-icon-cache', bin/'gtk3-update-icon-cache'
  end
end
