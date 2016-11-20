require 'formula'

class Cramfs < Formula
  url 'http://downloads.sourceforge.net/project/cramfs/cramfs/1.1/cramfs-1.1.tar.gz'
  homepage 'http://cramfs.sourceforge.net/'
  sha256 '133caca2c4e7c64106555154ee0ff693f5cf5beb9421ce2eb86baee997d22368'

  def install
    system "make"
    bin.install ["mkcramfs", "cramfsck"]
  end

  def test
    # this will fail we won't accept that, make it test the program works!
	system "mkdir cramfstest.in; echo hello > cramfstest.in/test.txt"
    system "mkcramfs -v cramfstest.in cramfstest.cram"
    system "cramfsck -x cramfstest.out cramfstest.cram"
	system "diff cramfstest.{in,out}"
	system "rm -rf cramfstest.{in,out,cram}"
  end

  def patches
      "https://gist.githubusercontent.com/dtjm/1207301/raw/e7283405867d9ef75fba9a1c57616e681b921872/cramfs-osx.diff"
  end
end
