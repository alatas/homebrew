require 'formula'

class XcbProto < Formula
  url 'http://xcb.freedesktop.org/dist/xcb-proto-1.6.tar.gz'
  homepage 'http://xcb.freedesktop.org'
  md5 '8d29695e8faf5fcdce568c66eaeaa5ee'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
      system "false"
  end
end
