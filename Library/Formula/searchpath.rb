require 'formula'

class Searchpath <Formula
  url 'http://searchpath.org/searchpath/SearchPath.hs'
  homepage 'http://searchpath.org/'
  md5 'e31c93dbcebed75b34d342f1bee13d31'
  version '0.93'

  depends_on 'haskell-platform'

  def install
    system 'cabal install network regex-compat'
    system 'ghc --make SearchPath.hs -o sp'
    bin.install 'sp'
  end
end
