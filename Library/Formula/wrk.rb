require 'formula'

class Wrk < Formula
  homepage 'https://github.com/wg/wrk'
  url 'https://github.com/wg/wrk.git'
  md5 ''
  head 'https://github.com/wg/wrk.git', :using => :git
  version 'HEAD'

  # depends_on 'cmake' => :build

  def install
    system "make"
    bin.install "wrk"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test wrk`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
