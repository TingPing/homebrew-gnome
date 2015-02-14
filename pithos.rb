require 'formula'

class Pithos < Formula
  homepage 'http://pithos.github.io'
  url 'https://github.com/pithos/pithos/archive/1.0.1.tar.gz'
  sha1 '5e7d8b47cd68a1d454d7ac8ddffffa079e3ad68a'

  depends_on :python3
  depends_on 'pygobject3' => 'with-python3'
  depends_on 'Homebrew/python/python-dbus' => 'with-python3'
  depends_on 'gsettings-desktop-schemas'
  depends_on 'gst-plugins-good'
  depends_on 'gst-plugins-ugly' => 'with-mad'
  depends_on 'gst-libav'
  depends_on 'gtk+3' => 'without-x11'

  resource 'pylast' do
    url 'https://pypi.python.org/packages/source/p/pylast/pylast-1.0.0.tar.gz'
    sha1 '6bd452723b530f93e016a2024632a230fd0e1ee8'
  end

  resource 'pync' do
    url 'https://github.com/SeTeM/pync/archive/v1.6.1.tar.gz'
    sha1 '81d880a36e44f0a5a90d786bd4576d3ab11dd3bc'
  end

  def install
    inreplace 'setup.py' do |s|
      s.gsub! "/usr", "#{HOMEBREW_PREFIX}"
    end

    resource('pylast').stage do
      ENV['PYTHONPATH'] = "#{libexec}/lib/python3.4/site-packages"
      system 'python3', 'setup.py', 'install', "--prefix=#{libexec}"
    end

    resource('pync').stage do
      ENV['PYTHONPATH'] = "#{libexec}/lib/python3.4/site-packages"
      system 'python3', 'setup.py', 'install', "--prefix=#{libexec}"
    end

    ENV['PYTHONPATH'] = "#{lib}/python3.4/site-packages"
    mkdir_p ENV['PYTHONPATH']
    system 'python3', 'setup.py', 'install', "--prefix=#{prefix}"

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end
end
