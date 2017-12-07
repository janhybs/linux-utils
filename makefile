
prefix = $(HOME)/.local

bin = $(prefix)/bin
lib = $(prefix)/lib
share = $(prefix)/share

install:
	@mkdir -p $(bin)
	@mkdir -p $(lib)
	@mkdir -p $(share)/sshh

	#pip3 install --user colorama
	rm -rf 3rd-party/tree-1.7.0
	tar -xvf 3rd-party/tree-1.7.0.tgz -C 3rd-party
	make -C 3rd-party/tree-1.7.0 all prefix=$(prefix)
	cp 3rd-party/tree-1.7.0/tree $(bin)/tree
	rm -rf 3rd-party/tree-1.7.0

	cp src/penv $(bin)/penv
	@sed -i '1i#!$(shell which python3)' $(bin)/penv
	cp src/sshh/sshh $(bin)/sshh
	@sed -i '1i#!$(shell which python3)' $(bin)/sshh
	
	cp src/sshh/sshh.py $(share)/sshh/sshh.py
	cp src/sshh/sshh_completion.sh $(share)/sshh/
	
	cp --no-clobber src/sshh/*.pass $(share)/sshh/
	cp --no-clobber src/sshh/sshh.yaml $(share)/sshh/
	
	@echo "\nAdd following line to you $(HOME)/.bashrc\n"
	@echo "echo -e \"\\\nsource $(share)/sshh/sshh_completion.sh\" >> $(HOME)/.bashrc"
	@echo "\n"
	
