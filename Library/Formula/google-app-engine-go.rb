require 'formula'
require 'hardware'

class GoogleAppEngineGo < Formula
  homepage 'http://code.google.com/appengine/downloads.html#Google_App_Engine_SDK_for_Go'

  packages = {
    :amd64 => {
      :url => "http://googleappengine.googlecode.com/files/go_appengine_sdk_darwin_amd64-1.5.5.zip",
      :md5 => "72aeb8fe1e42cf84cc867c9b5766606f",
      :version => "1.5.5-amd64"
    },
    :i386 => {
      :url => "http://googleappengine.googlecode.com/files/go_appengine_sdk_darwin_386-1.5.5.zip",
      :md5 => "",
      :version => "1.5.5-386"
    }
  }

  if ARGV.include? '--32bit'
      ohai "Using 32-bit (i386) architecture"
      package = packages[:i386]
  elsif Hardware.is_64_bit?
      ohai "Detected 64-bit (amd64) architecture"
      package = packages[:amd64]
  else
      ohai "Detected 32-bit (i386) architecture"
      package = packages[:i386]
  end

  url     package[:url]
  md5     package[:md5]
  version package[:version]

  skip_clean :all

  def options
      [
          ['--32bit', 'Override arch detection and install the 32-bit version.']
      ]
  end

  def install
      cd '..'
      share.install 'google_appengine' => name
      bin.mkpath
      %w[appcfg.py bulkload_client.py bulkloader.py dev_appserver.py remote_api_shell.py].each do |fn|
          ln_s share+name+fn, bin
      end
  end
end
