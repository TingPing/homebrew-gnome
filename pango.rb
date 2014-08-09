require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.5.tar.xz"
  sha256 "be0e94b2e5c7459f0b6db21efab6253556c8f443837200b8736d697071276ac8"

  bottle do
    root_url 'http://dl.tingping.se/homebrew'
    revision 1
  end

  # Need these for the patch below
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'gtk-doc' => :build

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'TingPing/gnome/cairo'
  depends_on 'TingPing/gnome/harfbuzz'
  depends_on 'fontconfig'
  depends_on 'gobject-introspection'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  # Fix crash running on Yosemite
  patch :DATA

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection=yes
      --without-xft
    ]

    system "./autogen.sh", *args
    system "make", "install"
  end

  def post_install
    system "#{bin}/pango-querymodules > '#{HOMEBREW_PREFIX}/etc/pango/pango.modules'"
  end

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end

__END__
--- pango/modules/basic/basic-coretext.c.orig	2014-08-09 08:36:41.000000000 +0200
+++ pango/modules/basic/basic-coretext.c	2014-08-09 08:40:46.000000000 +0200
@@ -93,6 +93,7 @@ struct RunIterator
   CTRunRef current_run;
   CFIndex *current_indices;
   const CGGlyph *current_cgglyphs;
+  CGGlyph *current_cgglyphs_buffer;
   CTRunStatus current_run_status;
 };
 
@@ -102,6 +103,9 @@ run_iterator_free_current_run (struct Ru
   iter->current_run_number = -1;
   iter->current_run = NULL;
   iter->current_cgglyphs = NULL;
+  if (iter->current_cgglyphs_buffer)
+    free (iter->current_cgglyphs_buffer);
+  iter->current_cgglyphs_buffer = NULL;
   if (iter->current_indices)
     free (iter->current_indices);
   iter->current_indices = NULL;
@@ -117,10 +121,18 @@ run_iterator_set_current_run (struct Run
 
   iter->current_run_number = run_number;
   iter->current_run = CFArrayGetValueAtIndex (iter->runs, run_number);
+  ct_glyph_count = CTRunGetGlyphCount (iter->current_run);
+
   iter->current_run_status = CTRunGetStatus (iter->current_run);
   iter->current_cgglyphs = CTRunGetGlyphsPtr (iter->current_run);
+  if (!iter->current_cgglyphs)
+    {
+      iter->current_cgglyphs_buffer = (CGGlyph *)malloc (sizeof (CGGlyph) * ct_glyph_count);
+      CTRunGetGlyphs (iter->current_run, CFRangeMake (0, ct_glyph_count),
+                      iter->current_cgglyphs_buffer);
+      iter->current_cgglyphs = iter->current_cgglyphs_buffer;
+    }
 
-  ct_glyph_count = CTRunGetGlyphCount (iter->current_run);
   iter->current_indices = malloc (sizeof (CFIndex *) * ct_glyph_count);
   CTRunGetStringIndices (iter->current_run, CFRangeMake (0, ct_glyph_count),
                          iter->current_indices);
@@ -205,6 +217,7 @@ run_iterator_create (struct RunIterator 
   iter->current_run = NULL;
   iter->current_indices = NULL;
   iter->current_cgglyphs = NULL;
+  iter->current_cgglyphs_buffer = NULL;
 
   /* Create CTLine */
   attributes = CFDictionaryCreate (kCFAllocatorDefault,
