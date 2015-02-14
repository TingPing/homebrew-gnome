require 'formula'

class Glade < Formula
  homepage 'http://glade.gnome.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/glade/3.18/glade-3.18.3.tar.xz'
  sha256 'ecdbce46e7fbfecd463be840b94fbf54d83723b3ebe075414cfd225ddab66452'

  # Need these for the patch below
  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'gtk-doc' => :build

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'itstool' => :build
  depends_on 'yelp-tools' => :build
  depends_on 'gettext'
  depends_on 'gtk+3' => 'without-x11'

  # gtk-mac-integration is broken, this disables it for now.
  patch :DATA

  def install
    # Find our docbook catalog
    ENV['XML_CATALOG_FILES'] = "#{etc}/xml/catalog"

    ENV.append "CPPFLAGS", "-xobjective-c"
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-introspection=no"

    system "make", "install"
  end
end

__END__
From d1c118c13dae83228a2abaf90586723b314d0c37 Mon Sep 17 00:00:00 2001
From: TingPing <tingping@tingping.se>
Date: Sun, 29 Jun 2014 01:55:13 -0400
Subject: [PATCH] Remove gtk-mac-integration

---
 configure.ac | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0c19bdd..7dd21f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -258,31 +258,6 @@ if test "$native_win32" = "yes"; then
 fi

 dnl ================================================================
-dnl Check for GDK Quartz and MacOSX integration package
-dnl ================================================================
-_gdk_tgt=`$PKG_CONFIG --variable=targets gdk-3.0`
-AM_CONDITIONAL([GDK_TARGET_QUARTZ], [test x$_gdk_tgt = xquartz])
-if test "x$_gdk_tgt" = xquartz; then
-   PKG_CHECK_MODULES(GTK_MAC, gtk-mac-integration)
-
-   GTK_MAC_BUNDLE_FLAG=
-
-   AC_ARG_ENABLE(mac-bundle,
-      AS_HELP_STRING([--enable-mac-bundle], [enable mac bundling]),
-      build_bundle=yes, build_bundle=no)
-
-   if test "x$build_bundle" = xyes; then
-      AC_MSG_NOTICE([enableing mac bundle..])
-
-      GTK_MAC_BUNDLE_FLAG=-DMAC_BUNDLE
-   fi
-
-   AC_SUBST(GTK_MAC_BUNDLE_FLAG)
-   AC_SUBST(GTK_MAC_LIBS)
-   AC_SUBST(GTK_MAC_CFLAGS)
-fi
-
-dnl ================================================================
 dnl Enable installation of Gladeui catalog
 dnl ================================================================
 AC_ARG_ENABLE([gladeui],
--
1.8.5.2 (Apple Git-48)
