require 'formula'

class Pithos < Formula
  homepage 'http://pithos.github.io'
  url 'https://github.com/pithos/pithos/archive/1.4.1.tar.gz'
  sha256 '33682e5f7ac37ae99f91d09ceeb76fd51ca2cee0a326cbc8118079b24a51fbd5'

  depends_on :python3
  depends_on 'tingping/gnome/pygobject3' => 'with-python3'
  depends_on 'Homebrew/python/python-dbus' => 'with-python3'
  depends_on 'gsettings-desktop-schemas'
  depends_on 'gst-plugins-good'
  depends_on 'gst-plugins-ugly' => 'with-mad'
  depends_on 'gst-libav'
  depends_on 'gtk+3' => 'without-x11'

  resource 'pylast' do
    url 'https://github.com/pylast/pylast/archive/2.1.0.tar.gz'
    sha256 '953731026db8dcecd1bdffa826eead2b122c0a16ba51b9328f90532a74a47239'  
  end

  resource 'pync' do
    url 'https://github.com/SeTeM/pync/archive/v1.6.1.tar.gz'
    sha256 '04f5339847dd6b677a935756699323ab4d35c128bf8123406a9042a3883cf7d9'
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
