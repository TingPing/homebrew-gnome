require 'formula'

class EnchantApplespell < Formula
  homepage 'http://www.abisource.com/projects/enchant/'
  url 'http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz'
  sha1 '321f9cf0abfa1937401676ce60976d8779c39536'

  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'glib'
  
  keg_only 'Not to conflict with normal enchant formula'
  
  # Support loading modules from custom prefixes
  patch do
    url 'https://gist.githubusercontent.com/TingPing/2d88a875b50da15c352d/raw/c341219dad11db356e9f3544f5d27d1651a22233/enchant-prefix.patch'
    sha1 '092054881d38750620e4840373cde84f7b1f2ce6'
  end
  
  # Fix building applespell module
  patch do
    url 'https://gist.githubusercontent.com/TingPing/2d88a875b50da15c352d/raw/f6f1f658191d02db4243767e1f1f9127d72e96b6/enchant-applespell.patch'
    sha1 '11cd365bb4509c8caa6b69be9ed8fee02190fa0e'
  end

  def install
    system "gnome-autogen.sh", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-ispell",
                          "--disable-myspell",
                          "--disable-aspell",
                          "--enable-applespell"

    system "make", "install"
  end
end
