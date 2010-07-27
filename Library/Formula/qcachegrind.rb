require 'formula'

class Qcachegrind <Formula
  url 'svn://anonsvn.kde.org/home/kde/trunk/KDE/kdesdk/kcachegrind/'
  homepage ''
  md5 ''
  version 'trunk'

  depends_on 'qt'

  def install
    system "qmake"
    system "make"
    bin.install('qcachegrind/qcachegrind.app/Contents/MacOS/qcachegrind')
  end

  def patches
      {
          :p0 => 
          "http://gist.github.com/raw/491405/file-dialog-filters.diff"
      }
  end
end
