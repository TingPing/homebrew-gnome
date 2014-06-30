require 'formula'

class GtkQuartzEngine < Formula
  homepage 'https://wiki.gnome.org/Projects/GTK%2B/OSX'
  head 'https://github.com/jralls/gtk-quartz-engine.git'

  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'TingPing/gnome/gtk+'

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make install"
  end
  
  def caveats; <<-EOS.undent
    In order to use themes you must export these variables:
        export GTK_DATA_PREFIX=#{HOMEBREW_PREFIX}
        export GTK_EXE_PREFIX=#{HOMEBREW_PREFIX}
    Then set your default theme:
        echo 'gtk-theme-name="Quartz"' >> $HOME/.gtkrc-2.0
    EOS
  end
end
