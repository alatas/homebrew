require 'formula'

class Fuzz < Formula
  url 'http://downloads.sourceforge.net/project/fuzz/fuzz/0.6/fuzz-0.6.tar.gz'
  homepage ''
  md5 '8c8e7c49729e0a98c0414faac7778ec7'

  # depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--mandir=#{man}"
    system "make install"
  end

  def test
    system "fuzz -r 10 cat"
  end
end
