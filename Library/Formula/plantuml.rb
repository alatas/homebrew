require 'formula'

class Plantuml <Formula
  url 'http://sourceforge.net/projects/plantuml/files/plantuml.jar/download'
  homepage 'http://plantuml.sourceforge.net/'
  md5 '327d82ff8dfcb2965b14ed25843ecdd5'
  version '1.0'

  def install
      prefix.install 'plantuml.jar'
  end
end
__END__
