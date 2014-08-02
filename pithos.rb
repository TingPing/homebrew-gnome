require 'formula'

class Pithos < Formula
  homepage 'http://pithos.github.io'
  url 'https://github.com/pithos/pithos/archive/1.0.0.tar.gz'
  sha1 '30c596ad5f471b5a2aae1c0355d7d096b509fa31'
 
  depends_on :python3
  depends_on 'TingPing/gnome/pygobject3' => 'with-python3'
  depends_on 'Homebrew/python/python-dbus' => 'with-python3'
  depends_on 'gsettings-desktop-schemas'
  depends_on 'gst-plugins-good'
  depends_on 'gst-plugins-ugly' => 'with-mad'
  depends_on 'gst-libav'
  depends_on 'TingPing/gnome/gtk+3'
  
  resource 'pylast' do
    url 'https://pypi.python.org/packages/source/p/pylast/pylast-0.5.11.tar.gz'
    sha1 '0e432279ccbed69580d313db15c1a03a7a39c42c'
  end    

  def install
    inreplace 'setup.py' do |s|
      s.gsub! "/usr", "#{HOMEBREW_PREFIX}"
    end
      
    # TODO: Don't hardcode 3.4
    ENV['PYTHONPATH'] = "#{lib}/python3.4/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', "#{lib}/python3.4/site-packages"

    resource('pylast').stage do
      system 'python3', 'setup.py', 'install', "--prefix=#{libexec}"
    end

    system 'python3', 'setup.py', 'install', "--prefix=#{prefix}"

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end
end
