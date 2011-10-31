require 'formula'

class SquashfsTools < Formula
  url 'http://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.2/squashfs4.2.tar.gz'
  homepage 'http://squashfs.sourceforge.net/'
  md5 '1b7a781fb4cf8938842279bd3e8ee852'

  def install
    Dir.chdir "squashfs-tools"
    system "make"
    bin.install ["mksquashfs", "unsquashfs"]
  end

  # Remove FNM_EXTMATCH option
  # (http://zettelchen.blogspot.com/2009/04/build-squashfs-tools-for-mac-os-x.html)
  # Change l{get,set,list}xattr() functions to OS-X specific API without the "l" prefix
  def patches
    DATA
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test squashfs`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end


__END__
diff -ru squashfs4.2/squashfs-tools/mksquashfs.c squashfs4.2-osx/squashfs-tools/mksquashfs.c
--- squashfs4.2/squashfs-tools/mksquashfs.c	2011-10-31 11:29:19.715837270 -0700
+++ squashfs4.2-osx/squashfs-tools/mksquashfs.c	2011-10-31 11:29:19.935837264 -0700
@@ -4363,7 +4363,7 @@
 				regexec(path->name[i].preg, name, (size_t) 0,
 					NULL, 0) == 0 :
 				fnmatch(path->name[i].name, name,
-					FNM_PATHNAME|FNM_PERIOD|FNM_EXTMATCH) ==
+					FNM_PATHNAME|FNM_PERIOD) ==
 					 0;
 
 			if(match && path->name[i].paths == NULL) {
diff -ru squashfs4.2/squashfs-tools/unsquashfs.c squashfs4.2-osx/squashfs-tools/unsquashfs.c
--- squashfs4.2/squashfs-tools/unsquashfs.c	2011-10-31 11:29:19.775837269 -0700
+++ squashfs4.2-osx/squashfs-tools/unsquashfs.c	2011-10-31 11:29:20.055837260 -0700
@@ -29,8 +29,9 @@
 #include "compressor.h"
 #include "xattr.h"
 
-#include <sys/sysinfo.h>
+/*#include <sys/sysinfo.h>*/
 #include <sys/types.h>
+#include <sys/sysctl.h>
 
 struct cache *fragment_cache, *data_cache;
 struct queue *to_reader, *to_deflate, *to_writer, *from_writer;
@@ -1204,7 +1205,7 @@
 			int match = use_regex ?
 				regexec(path->name[i].preg, name, (size_t) 0,
 				NULL, 0) == 0 : fnmatch(path->name[i].name,
-				name, FNM_PATHNAME|FNM_PERIOD|FNM_EXTMATCH) ==
+				name, FNM_PATHNAME|FNM_PERIOD) ==
 				0;
 			if(match && path->name[i].paths == NULL)
 				/*
diff -ru squashfs4.2/squashfs-tools/unsquashfs_xattr.c squashfs4.2-osx/squashfs-tools/unsquashfs_xattr.c
--- squashfs4.2/squashfs-tools/unsquashfs_xattr.c	2011-10-31 11:29:19.782503935 -0700
+++ squashfs4.2-osx/squashfs-tools/unsquashfs_xattr.c	2011-10-31 11:29:20.069170593 -0700
@@ -49,8 +49,8 @@
 		int prefix = xattr_list[i].type & SQUASHFS_XATTR_PREFIX_MASK;
 
 		if(root_process || prefix == SQUASHFS_XATTR_USER) {
-			int res = lsetxattr(pathname, xattr_list[i].full_name,
-				xattr_list[i].value, xattr_list[i].vsize, 0);
+			int res = setxattr(pathname, xattr_list[i].full_name,
+				xattr_list[i].value, xattr_list[i].vsize, 0, XATTR_NOFOLLOW);
 
 			if(res == -1)
 				ERROR("write_xattr: failed to write xattr %s"
diff -ru squashfs4.2/squashfs-tools/xattr.c squashfs4.2-osx/squashfs-tools/xattr.c
--- squashfs4.2/squashfs-tools/xattr.c	2011-10-31 11:29:19.785837268 -0700
+++ squashfs4.2-osx/squashfs-tools/xattr.c	2011-10-31 11:29:20.075837260 -0700
@@ -130,7 +130,7 @@
 	struct xattr_list *xattr_list = NULL;
 
 	while(1) {
-		size = llistxattr(filename, NULL, 0);
+		size = listxattr(filename, NULL, 0, XATTR_NOFOLLOW);
 		if(size <= 0) {
 			if(size < 0 && errno != ENOTSUP)
 				ERROR("llistxattr for %s failed in read_attrs,"
@@ -145,7 +145,7 @@
 			return 0;
 		}
 
-		size = llistxattr(filename, xattr_names, size);
+		size = listxattr(filename, xattr_names, size, XATTR_NOFOLLOW);
 		if(size < 0) {
 			free(xattr_names);
 			if(errno == ERANGE)
@@ -182,10 +182,10 @@
 		}
 
 		while(1) {
-			vsize = lgetxattr(filename, xattr_list[i].full_name,
-								NULL, 0);
+			vsize = getxattr(filename, xattr_list[i].full_name,
+								NULL, 0, 0, XATTR_NOFOLLOW);
 			if(vsize < 0) {
-				ERROR("lgetxattr failed for %s in read_attrs,"
+				ERROR("getxattr failed for %s in read_attrs,"
 					" because %s\n", filename,
 					strerror(errno));
 				free(xattr_list[i].full_name);
@@ -199,15 +199,15 @@
 				goto failed;
 			}
 
-			vsize = lgetxattr(filename, xattr_list[i].full_name,
-						xattr_list[i].value, vsize);
+			vsize = getxattr(filename, xattr_list[i].full_name,
+						xattr_list[i].value, vsize, 0, XATTR_NOFOLLOW);
 			if(vsize < 0) {
 				free(xattr_list[i].value);
 				if(errno == ERANGE)
 					/* xattr grew?  Try again */
 					continue;
 				else {
-					ERROR("lgetxattr failed for %s in "
+					ERROR("getxattr failed for %s in "
 						"read_attrs, because %s\n",
 						filename, strerror(errno));
 					free(xattr_list[i].full_name)

