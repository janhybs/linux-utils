
prefix = $(HOME)/.local

bin = $(prefix)/bin
lib = $(prefix)/lib
etc = $(prefix)/etc
share = $(prefix)/share

install:
	@mkdir -p $(bin)
	@mkdir -p $(lib)
	@mkdir -p $(etc)
	@mkdir -p $(share)/sshh

	#pip3 install --user colorama
	rm -rf 3rd-party/tree-1.7.0
	tar -xvf 3rd-party/tree-1.7.0.tgz -C 3rd-party
	make -C 3rd-party/tree-1.7.0 all prefix=$(prefix)
	cp 3rd-party/tree-1.7.0/tree $(bin)/tree
	rm -rf 3rd-party/tree-1.7.0


	rm -rf 3rd-party/bash-completion-2.1
	tar -xvf 3rd-party/bash-completion-2.1.tar.gz -C 3rd-party
	cd 3rd-party/bash-completion-2.1 && ./configure --prefix=$(prefix)
	rm -rf 3rd-party/bash-completion-2.1

	cp src/penv $(bin)/penv
	@sed -i '1i#!$(shell which python3)' $(bin)/penv
	cp src/sshh/sshh $(bin)/sshh

	cp src/sshh/sshh.py $(share)/sshh/sshh.py
	cp src/sshh/sshh_completion.sh $(share)/sshh/
	
	-cp --no-clobber src/sshh/*.pass $(share)/sshh/
	-cp --no-clobber src/sshh/sshh.yaml $(share)/sshh/
	
	@/bin/echo "\nAdd following line to you $(HOME)/.bashrc\n"
	@/bin/echo "echo -e \"\\\nsource $(share)/sshh/sshh_completion.sh\" >> $(HOME)/.bashrc"
	@/bin/echo "\n"

	@/bin/echo "\nAdd following line to you $(HOME)/.bashrc\n"
	@/bin/echo "echo -e \"\\\nsource $(etc)/profile.d/bash_completion.sh\" >> $(HOME)/.bashrc"
	@/bin/echo "\n"
	
