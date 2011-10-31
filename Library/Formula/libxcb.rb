require 'formula'

class Libxcb < Formula
  url 'http://xcb.freedesktop.org/dist/libxcb-1.7.tar.gz'
  homepage 'http://xcb.freedesktop.org'
  md5 'f715e53c9c1b25f856d14d6123663d96'

  depends_on "xcb-proto"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
      system "false"
  end
end
