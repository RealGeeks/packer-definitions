default: output
output:tmp
	mkdir -p output
	sh build.sh
tmp: server_config.tar
	mkdir tmp
	python2 generate_http_files.py
server_config:
	git clone git@github.com:RealGeeks/server_config.git
server_config.tar: server_config
	tar cvf server_config.tar server_config
reset:
	rm -rf tmp output output-*
clean:
	rm -rf server_config server_config.tar tmp output output-*
	
