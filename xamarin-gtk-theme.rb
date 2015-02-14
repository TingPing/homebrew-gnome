require 'formula'

class XamarinGtkTheme < Formula
  homepage 'https://github.com/mono/xamarin-gtk-theme'
  head 'https://github.com/mono/xamarin-gtk-theme.git'

  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gtk+' => 'without-x11'
  depends_on 'gettext'

  def install
    system "gnome-autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  def caveats; <<-EOS.undent
    In order to use themes you must export these variables:
        export GTK_DATA_PREFIX=#{HOMEBREW_PREFIX}
        export GTK_EXE_PREFIX=#{HOMEBREW_PREFIX}
    Then set your default theme:
        echo 'gtk-theme-name="Xamarin"' >> $HOME/.gtkrc-2.0
    EOS
  end
end
