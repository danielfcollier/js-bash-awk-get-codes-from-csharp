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
	@-bash ./src/srvCodes/main.sh

enums:
	@-bash ./src/enums/main.sh

enum:
	@-bash ./src/enums/run.sh ${source}

clean:
	@-rm -rf assets
	@-mkdir assets
	@-clear
