require 'formula'

class Gtksourceview3 < Formula
  homepage 'http://projects.gnome.org/gtksourceview/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtksourceview/3.12/gtksourceview-3.12.2.tar.xz'
  sha1 '157ee7291988f89eebdbf6c4bb05e9901572f1ad'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'
  depends_on 'TingPing/gnome/gtk+3'
  depends_on 'TingPing/gnome/gtk-mac-integration' => 'with-gtk+3'
  # TODO: glade
 
  # Need these for the patch below
  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'gtk-doc' => :build

  # Fixes looking for old gtk-mac-integration
  patch :p0, :DATA

  def install
    system "gnome-autogen.sh", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
--- configure.ac.orig	2014-07-03 14:14:53.000000000 -0400
+++ configure.ac	2014-07-03 14:15:15.000000000 -0400
@@ -115,7 +115,7 @@
 if test "$os_osx" = "yes"; then
 	AC_DEFINE([OS_OSX], [1], [Defined if os is Mac OSX])

-	PKG_CHECK_MODULES(GTK_MAC, gtk-mac-integration >= 2.0.0)
+	PKG_CHECK_MODULES(GTK_MAC, gtk-mac-integration-gtk3 >= 2.0.0)
 fi

 # Check for Glade3
