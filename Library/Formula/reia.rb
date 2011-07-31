require 'formula'

class Reia <Formula
  url 'git://github.com/tarcieri/reia.git'
  homepage 'http://reia-lang.org/'
  md5 ''
  version 'HEAD'

  depends_on 'erlang'

  def install
      system 'rake'
      system 'rake install'
  end
end
