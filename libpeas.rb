require 'formula'

class Libpeas < Formula
  homepage 'http://gnome.org/'
  url 'http://ftp.gnome.org/pub/GNOME/core/3.12/3.12.2/sources/libpeas-1.10.0.tar.xz'
  sha1 '3111b53eca619d8cbe9ad7d9ca74767b281eef2a'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'TingPing/gnome/gtk+3'
  # TODO: glade, pygobject

  # Need these for the patch below
  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'gtk-doc' => :build

  # Remove using ancient gtk-mac-integration
  # TODO: Fix upstream
  patch :p0, :DATA

  def install
    system "gnome-autogen.sh", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end

__END__
--- configure.ac.orig	2014-07-03 14:39:59.000000000 -0400
+++ configure.ac	2014-07-03 14:40:12.000000000 -0400
@@ -136,12 +136,6 @@
 AC_MSG_RESULT([$os_osx])
 AM_CONDITIONAL(OS_OSX, test "$os_osx" = "yes")

-if test "$os_osx" = "yes"; then
-	AC_DEFINE([OS_OSX],[1],[Defined if os is Mac OSX])
-
-	PKG_CHECK_MODULES(IGE_MAC, ige-mac-integration)
-fi
-
 dnl ================================================================
 dnl Check for GDB
 dnl ================================================================
