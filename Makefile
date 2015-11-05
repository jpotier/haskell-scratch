default: docker-integer-gmp docker-integer-simple

root:
	@mkdir root
root/bin: | root
	@mkdir root/bin
root/etc: | root
	@mkdir root/etc
root/etc/hosts: | root/etc
	@cp /etc/hosts root/etc/hosts
root/bin/sh: | root/bin
	@cp -L /bin/sh root/bin/
root/lib: | root
	@mkdir root/lib
root/usr/lib: | root/lib root/usr
	@mkdir root/usr/lib
root/usr/lib/libc.so.6: | root/usr/lib
	@cp -L /usr/lib/libc.so.6 root/usr/lib/
root/usr/lib/libdl.so.2: | root/usr/lib
	@cp -L /usr/lib/libdl.so.2 root/usr/lib/
root/usr/lib/libffi.so.6: | root/usr/lib
	@cp -L /usr/lib/libffi.so.6 root/usr/lib/
root/usr/lib/libm.so.6: | root/usr/lib
	@cp -L /usr/lib/libm.so.6 root/usr/lib/
root/usr/lib/libpthread.so.0: | root/usr/lib
	@cp -L /usr/lib/libpthread.so.0 root/usr/lib/
root/usr/lib/libutil.so.1: | root/usr/lib
	@cp -L /usr/lib/libutil.so.1 root/usr/lib/
root/usr/lib/librt.so.1: | root/usr/lib
	@cp -L /usr/lib/librt.so.1 root/usr/lib/
root/usr/lib/libz.so.1: | root/usr/lib
	@cp -L /usr/lib/libz.so.1 root/usr/lib/
root/usr/lib/libnss_files.so.2: | root/usr/lib
	@cp -L /usr/lib/libnss_files.so.2 root/usr/lib/
root/usr/lib/libnss_dns.so.2: | root/usr/lib
	@cp -L /usr/lib/libnss_dns.so.2 root/usr/lib/
root/usr/lib/libresolv.so.2: | root/usr/lib
	@cp -L /usr/lib/libresolv.so.2 root/usr/lib/
root/lib64: | root
	@mkdir root/lib64
root/lib64/ld-linux-x86-64.so.2: | root/lib64
	@cp -L /lib64/ld-linux-x86-64.so.2 root/lib64/
root/etc/protocols:  | root/etc
	@cp -L /etc/protocols root/etc/
root/etc/services:  | root/etc
	@cp -L /etc/services root/etc/
root/usr: | root
	@mkdir root/usr
root/usr/lib/gconv: | root/usr/lib
	@mkdir root/usr/lib/gconv
root/usr/lib/gconv/UTF-16.so: | root/usr/lib/gconv
	@cp -L /usr/lib/gconv/UTF-16.so root/usr/lib/gconv/
root/usr/lib/gconv/UTF-32.so: | root/usr/lib/gconv
	@cp -L /usr/lib/gconv/UTF-32.so root/usr/lib/gconv/
root/usr/lib/gconv/UTF-7.so: | root/usr/lib/gconv
	@cp -L /usr/lib/gconv/UTF-7.so root/usr/lib/gconv/
root/usr/lib/gconv/gconv-modules: | root/usr/lib/gconv
	@cp -L /usr/lib/gconv/gconv-modules root/usr/lib/gconv/
root/usr/lib/libgmp.so.10: | root/usr/lib
	@cp -L /usr/lib/libgmp.so.10 root/usr/lib/

docker-integer-gmp: | root/bin/sh root/etc/hosts root/usr/lib/libc.so.6 root/usr/lib/libdl.so.2 root/usr/lib/libffi.so.6 root/usr/lib/libm.so.6 root/usr/lib/libpthread.so.0 root/usr/lib/librt.so.1 root/usr/lib/libutil.so.1 root/usr/lib/libz.so.1 root/lib64/ld-linux-x86-64.so.2 root/usr/lib/gconv/UTF-16.so root/usr/lib/gconv/UTF-32.so root/usr/lib/gconv/UTF-7.so root/usr/lib/gconv/gconv-modules root/usr/lib/libgmp.so.10 root/usr/lib/libnss_files.so.2 root/usr/lib/libnss_dns.so.2 root/usr/lib/libresolv.so.2 root/etc/protocols root/etc/services
	@tar -cC root .|docker import - haskell-scratch:integer-gmp

docker-integer-simple: | root/bin/sh root/etc/hosts root/usr/lib/libc.so.6 root/usr/lib/libdl.so.2 root/usr/lib/libffi.so.6 root/usr/lib/libm.so.6 root/usr/lib/libpthread.so.0 root/usr/lib/librt.so.1 root/usr/lib/libutil.so.1 root/usr/lib/libz.so.1 root/lib64/ld-linux-x86-64.so.2 root/usr/lib/gconv/UTF-16.so root/usr/lib/gconv/UTF-32.so root/usr/lib/gconv/UTF-7.so root/usr/lib/gconv/gconv-modules root/usr/lib/libnss_files.so.2 root/usr/lib/libnss_dns.so.2 root/usr/lib/libresolv.so.2 root/etc/protocols root/etc/services
	@tar -c --exclude=libgmp.so.10 -C root .|docker import - haskell-scratch:integer-simple

clean:
	@rm -rf root

push:
	@docker tag -f haskell-scratch:integer-gmp fpco/haskell-scratch:integer-gmp
	@docker push fpco/haskell-scratch:integer-gmp
	@docker tag -f haskell-scratch:integer-simple fpco/haskell-scratch:integer-simple
	@docker push fpco/haskell-scratch:integer-simple
	@docker tag -f haskell-scratch:integer-simple fpco/haskell-scratch:latest
	@docker push fpco/haskell-scratch:latest

.PHONY: default docker-integer-gmp docker-integer-simple clean push
