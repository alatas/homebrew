require 'formula'

class Phpmyadmin < Formula
  url 'http://sourceforge.net/projects/phpmyadmin/files%2FphpMyAdmin%2F3.3.10%2FphpMyAdmin-3.3.10-english.tar.gz/download#!md5!f399aed03797442d535a75b9fffe81fc'
  homepage 'http://phpmyadmin.net'
  md5 'f399aed03797442d535a75b9fffe81fc'
  version '3.3.10'

  depends_on 'php'

  def install
    prefix.install Dir["*"]
    system "mkdir -p /usr/local/var/www/html";
    system "(cd /usr/local/var/www/html; ln -s #{prefix} phpmyadmin)"
    system "(cd #{prefix}; cp config.sample.inc.php config.inc.php)"
  end

  def caveats
    <<-EOB
        Todo after installation:

        1. Edit the #{prefix}/config.inc.php file
           - Add the blowfish secret ket
        2. If you want PMA metadata:
           - Uncomment all the *pma* configuration stuff
           - Create the pma user
           - Run the pma table scripts:
             cat scripts/{create_tables.sql, upgrade_tables_mysql_4_1_2+.sql} | mysql -uroot
    EOB
  end
end
