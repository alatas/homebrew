require 'formula'

class Gocode < Formula
  url 'https://github.com/nsf/gocode/tarball/compatible-with-go-weekly.2011-06-02'
  homepage 'https://github.com/nsf/gocode'
  md5 '7c2737b1eb5087ab1f6cb3c8d83c79e2'
  head 'https://github.com/nsf/gocode.git'
  version '20110602'

  def install
    system "make"
    bin.mkdir
    bin.install %w(gocode)
    prefix.install %w(vim emacs)
  end

  def caveats; <<-EOS.undent
    ### Vim setup

        1.  Install official Go vim scripts from **$GOROOT/misc/vim**.
            If you did that already, proceed to the step 2.
        2.  Install gocode vim scripts. Usually it's enough to do the following:

                `cd vim && ./update.bash`

        3.  Make sure vim has filetype plugin enabled. Simply add that to your
            **.vimrc**:

                `filetype plugin on`

        4.  Autocompletion should work now. Use `<C-x><C-o>` for autocompletion
            (omnifunc autocompletion).

    ### Emacs setup

        1.  Install [auto-complete-mode](http://www.emacswiki.org/emacs/AutoComplete)
        2.  Copy **emacs/go-autocomplete.el** file from the gocode source
            distribution to a directory which is in your 'load-path' in emacs.
        3.  Add these lines to your **.emacs**:

                (require 'go-autocomplete)
	    	    (require 'auto-complete-config)

      EOS
  end
end
