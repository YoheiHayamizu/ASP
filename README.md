# ASP-code
reasoning and planning in MDP Domain.

## asp_files
asp_files provides some codes which plan in MDP.

## asp2py
this provides a parser which converts output from clingo to strings.

## original_asp_files
it is for just in case. This directory is the original code when I get this code

# installation
You need to install Clingo on Ubuntu 18.04. 
To install Clingo, follow the instruction:
	
	git clone https://github.com/potassco/clingo.git <path to clingo>
	cd <path to clingo>
	git submodule update --init --recursive
	
If you haven't install lua yet;

	git apt install lua5.3 liblua5.3-dev

	make
	
	make install

To test the ASP files, run this command: 

	clingo -c n=10 *.asp -n 0

where n-1 is the maximum number of actions allowed in planning. 
where -n means to comute at most <n> models (0 for all)
