require 'formula'

class Cramfs < Formula
  url 'http://downloads.sourceforge.net/project/cramfs/cramfs/1.1/cramfs-1.1.tar.gz'
  homepage 'http://cramfs.sourceforge.net/'
  md5 'd3912b9f7bf745fbfea68f6a9b9de30f'

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
      "https://raw.github.com/gist/1207301/fb4bb28e4f26d35bab81bb8f64ef0efd566e8778/cramfs-osx.diff"
  end
end
