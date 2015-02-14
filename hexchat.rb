require 'formula'

class Hexchat < Formula
  homepage 'https://hexchat.github.io/'
  head 'https://github.com/hexchat/hexchat.git'
  url 'https://dl.hexchat.net/hexchat/hexchat-2.10.2.tar.xz'
  sha1 '3ce831cde92f2f9999a217523d124e5b4cd08333'

  # TODO: Don't run on stable builds
  depends_on 'gnome-common' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on :python => :optional
  depends_on :python3 => :optional
  depends_on 'gettext'
  depends_on 'gtk+' => 'without-x11'
  depends_on 'gtk-mac-integration' => 'with-gtk+'
  depends_on 'TingPing/gnome/enchant-applespell'

  option 'without-perl', 'Build without Perl support'
  option 'without-plugins', 'Build without plugin support'

  def install
    args = %W[--prefix=#{prefix}
              --disable-dependency-tracking
              --enable-openssl]

    if build.with? "python3"
      py_ver = Formula["python3"].version.to_s[0..2] # e.g "3.4"
      ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
      args << "--enable-python=python#{py_ver}"
    elsif build.with? "python"
      ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig/"
      ENV.append_path "PKG_CONFIG_PATH", "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig/"
      args << "--enable-python=python2.7"
    else
      args << "--disable-python"
    end

    args << "--disable-perl" if build.without? "perl"
    args << "--disable-plugin" if build.without? "plugins"

    system "./autogen.sh"
    system "./configure", *args
    system "make", "install"

    rm_rf share/"applications"
    rm_rf share/"appdata"
  end
end
