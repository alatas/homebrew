require 'formula'

class Qcachegrind <Formula
  url 'svn://anonsvn.kde.org/home/kde/trunk/KDE/kdesdk/kcachegrind/'
  homepage 'http://websvn.kde.org/trunk/KDE/kdesdk/kcachegrind/'
  md5 ''
  version 'trunk'

  # Commented out because if qt is not installed, brew will install it without
  # the proper flags
  #depends_on 'qt'

  def install
    
    # Check whether qt is installed with the proper flags
    qt = Formula.factory 'qt'

    if not qt.installed? then
        puts "qt not installed. I'll do it!"
        puts "(Go do something else. This will take a couple of hours.)"
        system 'brew install qt --with-qtdbus --with-qt3support'
    elsif not File.directory? qt.lib+'Qt3Support.framework' or
        not File.directory? qt.lib+'QtDbus.framework' then
        raise <<-EOS.undent
        qt must be compiled with dbus and qt3support, which are not enabled
        by default.
        EOS
    else
        puts "qt is installed with dbus and qt3support enabled";
    end
    
    system "qmake"
    system "make"
    prefix.install 'qcachegrind/qcachegrind.app'
    mkdir bin
    ln_s prefix+'qcachegrind.app/Contents/MacOS/qcachegrind', bin+'qcachegrind'
  end

  def patches
      {:p0 => DATA}
  end

  def caveats
      <<-EOS.undent
      qcachegrind seems to beachball when using the 'Callee Map' feature, so avoid using it.

      Run `brew linkapps` to link the App Bundle into your ~/Applications folder.
      You might need to create your ~/Applications folder by doing `mkdir ~/Applications`

      brew linkapps is an external command. More info:
      http://wiki.github.com/mxcl/homebrew/external-commands
      EOS
  end
end

__END__
### This patch fixes the file selection dialog filter which currently
### doesn't let you select anything!
Index: qcachegrind/qcgtoplevel.cpp
===================================================================
--- qcachegrind/qcgtoplevel.cpp	(revision 1155013)
+++ qcachegrind/qcgtoplevel.cpp	(working copy)
@@ -792,7 +792,7 @@
     file = QFileDialog::getOpenFileName(this,
 					tr("Open Callgrind Data"),
 					_lastFile,
-					tr("Callgrind Files (callgrind.*)"));
+					tr("Cachegrind Files (*cachegrind.*);;Callgrind Files (*callgrind.*);;All Files (*)"));
     loadTrace(file);
 }
 
@@ -839,7 +839,7 @@
     file = QFileDialog::getOpenFileName(this,
 					tr("Add Callgrind Data"),
 					_lastFile,
-					tr("Callgrind Files (callgrind.*)"));
+					tr("Cachegrind Files (*cachegrind.*);;Callgrind Files (*callgrind.*);;All Files (*)"));
     addTrace(file);
 }

=======
class Qcachegrind < Formula
  url 'http://kcachegrind.sourceforge.net/kcachegrind-0.7.0.tar.gz'
  homepage 'http://kcachegrind.sourceforge.net/'
  md5 '0001385bbc630afa353619de8768e946'

  depends_on 'graphviz' => :optional

  def install
    qt = Formula.factory 'qt'
    unless (qt.lib + 'Qt3Support.framework').exist?
      onoe 'QCachegrind requires Qt3Support. `brew install qt --with-qt3support`'
      exit 1
    end

    cd 'qcachegrind'
    system 'qmake -spec macx-g++ -config release'
    system 'make'
    bin.install 'qcachegrind.app/Contents/MacOS/qcachegrind'
  end

  def test
    system 'qcachegrind'
  end
end
