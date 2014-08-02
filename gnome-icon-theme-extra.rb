require "formula"

class GnomeIconThemeExtra < Formula
  homepage "https://developer.gnome.org"
  url "http://ftp.gnome.org/pub/GNOME/core/3.12/3.12.2/sources/gnome-icon-theme-extras-3.12.0.tar.xz"
  sha1 "1ec91dc4f20c6877589124bc76c1ac2db1accb01"

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "TingPing/gnome/gtk+3" => :build # for gtk3-update-icon-cache
  depends_on "icon-naming-utils" => :build
  depends_on "intltool" => :build
  depends_on "TingPing/gnome/gnome-icon-theme"

  def install
    ENV["GTK_UPDATE_ICON_CACHE"] = "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-icon-mapping"
    system "make", "install"
  end

  def post_install
    Formula["gnome-icon-theme"].post_install
  end
end
