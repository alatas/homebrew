require 'formula'

class Lftp < Formula
  url 'http://ftp.yars.free.net/pub/source/lftp/lftp-4.3.3.tar.bz2'
  homepage 'http://lftp.yar.ru/'
  md5 '91757a201c1030714ac1996f27437cc7'

  depends_on 'pkg-config' => :build
  depends_on 'readline'
  depends_on 'gnutls'

  def install
    # Bus error
    ENV.no_optimization if MACOS_VERSION == 10.5
    ENV["PKG_CONFIG_PATH"] = "/usr/local/Cellar/gnutls/2.8.5/lib/pkgconfig:" + ENV["PKG_CONFIG_PATH"]

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
