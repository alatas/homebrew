require 'formula'

class Darcs <Formula
  url 'http://darcs.net/binaries/macosx/darcs-2.5-OSX-10.6-i386.tar.gz'
  homepage 'http://darcs.net/'
  md5 'd9d6c05463846f9b4cf9386ea714cb16'
  version '2.5'

  def install
    system 'tar zxvf darcs*tar.gz'
    bin.install 'darcs'
  end
end
