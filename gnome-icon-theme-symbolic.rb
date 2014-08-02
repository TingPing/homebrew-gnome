require "formula"

class GnomeIconThemeSymbolic < Formula
  homepage "https://developer.gnome.org"
  url "http://ftp.gnome.org/pub/GNOME/core/3.12/3.12.2/sources/gnome-icon-theme-symbolic-3.12.0.tar.xz"
  sha1 "e0d84c1d8983f37c7697afd55df69de8aae02b03"

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
    
    # Workaround make install failing to find index
    system "mkdir", "-p", "#{prefix}/share/icons/gnome"
    system "touch", "#{prefix}/share/icons/gnome/index.theme"

    system "make", "install"

    system "rm", "#{prefix}/share/icons/gnome/index.theme"
  end

  def post_install
    Formula["gnome-icon-theme"].post_install
  end
end
