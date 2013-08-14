default: tmp
tmp: server_config.tar
	python2 build.py
server_config:
	git clone git@github.com:RealGeeks/server_config.git
server_config.tar: server_config
	tar cvf server_config.tar server_config
clean:
	rm -rf server_config server_config.tar tmp
	
