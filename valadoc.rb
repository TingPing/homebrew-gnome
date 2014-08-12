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

  patch :DATA

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
end

__END__
From 58ee10baa0273d9bf88963d97d71d94d2fdf9a78 Mon Sep 17 00:00:00 2001
From: TingPing <tingping@tingping.se>
Date: Tue, 12 Aug 2014 00:45:41 -0400
Subject: [PATCH] Fix coretext warning

---
 src/libvaladoc/charts/simplechartfactory.vala | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libvaladoc/charts/simplechartfactory.vala b/src/libvaladoc/charts/simplechartfactory.vala
index 06da97e..8707d70 100644
--- a/src/libvaladoc/charts/simplechartfactory.vala
+++ b/src/libvaladoc/charts/simplechartfactory.vala
@@ -25,7 +25,7 @@
 public class Valadoc.Charts.SimpleFactory : Charts.Factory {
 	protected virtual Gvc.Node configure_type (Gvc.Node node, Api.Node item) {
  		node.safe_set ("shape", "box", "");
-		node.safe_set ("fontname", "Times", "");
+		node.safe_set ("fontname", "Times-Roman", "");
 		node.safe_set ("label", item.get_full_name (), "");
 		return node;
 	}
-- 
1.8.5.2 (Apple Git-48)

