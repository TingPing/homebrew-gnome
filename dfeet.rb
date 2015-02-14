require "formula"

class Dfeet < Formula
  homepage "https://wiki.gnome.org/Apps/DFeet"
  url "http://download.gnome.org/sources/d-feet/0.3/d-feet-0.3.9.tar.xz"
  sha256 "6df917fc1c2ef43217fbeea94dc12ecfc2d136cac4c84dac2c89f03dfbca7953"

  depends_on "pkg-config" => :build
  depends_on "itstool" => :build
  depends_on "intltool" => :build
  depends_on :python
  depends_on "glib"
  depends_on "pygobject3" => "with-python"
  depends_on 'gtk+3' => 'without-x11'

  def install
    ENV["GTK_UPDATE_ICON_CACHE"] = "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-tests",
                          "--disable-schemas-compile"
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "--targetdir=#{HOMEBREW_PREFIX}/etc/glib-2.0/schemas",
            "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end
end
