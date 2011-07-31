require 'formula'

class Realpath <Formula
  url 'git://github.com/dtjm/realpath.git'
  homepage 'http://stackoverflow.com/questions/284662/how-do-you-normalize-a-file-path-in-bash'
  version "HEAD"

  def install
    system "gcc -o realpath realpath.c"
    bin.install "realpath"
  end
end
