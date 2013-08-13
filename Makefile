default: output-virtualbox
tmp:
	python2 build.py
server_config:
	git clone git@github.com:RealGeeks/server_config.git
server_config.tar: server_config
	tar cvf server_config.tar server_config
packer_build: server_config.tar
	packer build template.json
clean:
	rm -rf server_config server_config.tar tmp
	
