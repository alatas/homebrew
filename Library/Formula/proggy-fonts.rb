require 'formula'

class ProggyFonts < Formula
  url 'http://www.proggyfonts.com/download/download_bridge.php?get=ProggyClean.ttf.zip'
  homepage 'http://www.proggyfonts.com'
  md5 '522c036b817b7deadb110499ac2849a6'
  version '1'

  def caveats
    readme = nil
    File.open(prefix+"Readme.txt", "r") do |file|
        readme = file.read
    end
    readme
  end

  def install
    prefix.install Dir["*"]
    ohai "Installing fonts to ~/Library/Fonts"
    system "ln -sf #{prefix+"ProggyClean.ttf"} ~/Library/Fonts"
    system "ln -sf #{prefix+"ProggyCleanCE.ttf"} ~/Library/Fonts"
  end
end
