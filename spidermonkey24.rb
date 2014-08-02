require 'formula'

class Spidermonkey24 < Formula
  homepage 'http://www.mozilla.org/js/spidermonkey/'
  url 'https://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2'
  sha1 'ce779081cc11bd0c871c6f303fc4a0091cf4fe66'
  version '24.2.0'

  depends_on 'readline'
  depends_on 'nspr'

  def install
    cd "js/src" do
      system "./configure", "--disable-tests",
                            "--disable-debug",
                            "--disable-debug-symbols",
                            "--prefix=#{prefix}"

      system "make"
      system "make", "install"
    end
  end
end
