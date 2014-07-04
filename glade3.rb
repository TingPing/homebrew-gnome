require 'formula'

class Glade3 < Formula
  homepage 'http://glade.gnome.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/glade3/3.8/glade3-3.8.5.tar.xz'
  sha256 '58a5f6e4df4028230ddecc74c564808b7ec4471b1925058e29304f778b6b2735'

  # Need these for the patch below
  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'gtk-doc' => :build
  depends_on 'gnome-doc-utils' => :build

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'scrollkeeper' => :build
  depends_on 'gettext'
  depends_on 'libxml2' => 'with-python'
  depends_on 'TingPing/gnome/gtk+'
  depends_on 'TingPing/gnome/gtk-mac-integration' => 'with-gtk+'

  # Fix building with gtk-mac-integration
  patch :DATA

  def install
    # Find our docbook catalog
    ENV['XML_CATALOG_FILES'] = "#{etc}/xml/catalog"

    ENV.prepend_path "PYTHONPATH", "#{Formula["libxml2"].opt_prefix}/lib/python2.7/site-packages"

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make" # separate steps required
    system "make", "install"
  end
end

__END__
From 91ae92d605f3f17cc4caefd6464ef98eb77f3b45 Mon Sep 17 00:00:00 2001
From: TingPing <tingping@tingping.se>
Date: Mon, 26 May 2014 20:19:16 -0400
Subject: [PATCH] Fix gtk-mac-integration support

---
 configure.ac       |  2 +-
 src/glade-window.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index c0c6452..e75687d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,7 +230,7 @@ dnl ================================================================
 _gdk_tgt=`$PKG_CONFIG --variable=target gdk-2.0`
 AM_CONDITIONAL([GDK_TARGET_QUARTZ], [test x$_gdk_tgt = xquartz])
 if test "x$_gdk_tgt" = xquartz; then 
-   PKG_CHECK_MODULES(GTK_MAC, gtk-mac-integration)
+   PKG_CHECK_MODULES(GTK_MAC, gtk-mac-integration-gtk2)
 
    GTK_MAC_BUNDLE_FLAG=
 
diff --git a/src/glade-window.c b/src/glade-window.c
index f2ef58c..18f3250 100644
--- a/src/glade-window.c
+++ b/src/glade-window.c
@@ -3395,34 +3395,34 @@ glade_window_init (GladeWindow *window)
 	{
 		/* Fix up the menubar for MacOSX Quartz builds */
 		GtkWidget *sep;
-		GtkOSXApplication *theApp = g_object_new(GTK_TYPE_OSX_APPLICATION, NULL);
+		GtkosxApplication *theApp = g_object_new(GTKOSX_TYPE_APPLICATION, NULL);
 		gtk_widget_hide (menubar);
-		gtk_osxapplication_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
+		gtkosx_application_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
 		widget =
 			gtk_ui_manager_get_widget (window->priv->ui, "/MenuBar/FileMenu/Quit");
 		gtk_widget_hide (widget);
 		widget =
 			gtk_ui_manager_get_widget (window->priv->ui, "/MenuBar/HelpMenu/About");
-		gtk_osxapplication_insert_app_menu_item (theApp, widget, 0);
+		gtkosx_application_insert_app_menu_item (theApp, widget, 0);
 		sep = gtk_separator_menu_item_new();
 		g_object_ref(sep);
-		gtk_osxapplication_insert_app_menu_item (theApp, sep, 1);
+		gtkosx_application_insert_app_menu_item (theApp, sep, 1);
 
 		widget =
 			gtk_ui_manager_get_widget (window->priv->ui, "/MenuBar/EditMenu/Preferences");
-		gtk_osxapplication_insert_app_menu_item  (theApp, widget, 2);
+		gtkosx_application_insert_app_menu_item  (theApp, widget, 2);
 		sep = gtk_separator_menu_item_new();
 		g_object_ref(sep);
-		gtk_osxapplication_insert_app_menu_item (theApp, sep, 3);
+		gtkosx_application_insert_app_menu_item (theApp, sep, 3);
 
 		widget =
 			gtk_ui_manager_get_widget (window->priv->ui, "/MenuBar/HelpMenu");
-		gtk_osxapplication_set_help_menu(theApp, GTK_MENU_ITEM(widget));
+		gtkosx_application_set_help_menu(theApp, GTK_MENU_ITEM(widget));
 
 		g_signal_connect(theApp, "NSApplicationWillTerminate",
 				 G_CALLBACK(quit_cb), window);
 
-		gtk_osxapplication_ready(theApp);
+		gtkosx_application_ready(theApp);
 
 	}
 #endif
-- 
1.8.5.2 (Apple Git-48)
