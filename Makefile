MAKEFLAGS += --silent
MAKEFLAGS += --no-print-directory

run:
	@-$(MAKE) clean
	@-docker build -t get-codes .
	@-docker create --name solution get-codes
	@-docker cp solution:/app/assets ${PWD}
	@-docker rm -f solution

local: clean srv-codes enums

srv-codes:
	@-./src/srvCodes/main.sh

enums:
	@-./src/enums/main.sh

enum:
	@-./src/enums/run.sh ${source}

clean:
	@-rm -rf assets
	@-clear
