require 'formula'

class Vsftpd <Formula
    url      'ftp://vsftpd.beasts.org/users/cevans/vsftpd-2.2.2.tar.gz'
    homepage 'http://vsftpd.beasts.org/'
    md5      '6d6bc136af14c23f8fef6f1a51f55418'

    def install

        inreplace 'builddefs.h' do |content|
          
            content.gsub! /#undef VSF_BUILD_SSL/, 
                          '#define VSF_BUILD_SSL'
        end

        system 'make'

        #FileUtils.mkdir_p [sbin, man5, man8]

        sbin.install('vsftpd')
        man8.install('vsftpd.8')
        man5.install('vsftpd.conf.5');
    end

    def patches
        { 
            :p0 => [
                # Add "phony" target list to Makefile
                "http://trac.macports.org/export/69899/trunk/dports/net/vsftpd/files/patch-Makefile.diff",

                # Add OSX-specific #defines
                "http://trac.macports.org/export/69899/trunk/dports/net/vsftpd/files/patch-sysdeputil.c.diff",
                
                # Add OS X libpam.dylib
                "http://trac.macports.org/export/69899/trunk/dports/net/vsftpd/files/patch-vsf_findlibs.sh.diff",

                # chroot_local_user=YES and pam_service_name=ftpd
                "http://trac.macports.org/export/69899/trunk/dports/net/vsftpd/files/patch-vsftpd.conf.diff" ]
        }
    end
end
