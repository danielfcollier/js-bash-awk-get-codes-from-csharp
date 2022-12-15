MAKEFLAGS += --silent
MAKEFLAGS += --no-print-directory

build:
	@-./src/srvCodes/main.sh

enums:
	@-./src/enums/main.sh

enum:
	@-./src/enums/run.sh ${source}

clean:
	@-rm -rf assets
