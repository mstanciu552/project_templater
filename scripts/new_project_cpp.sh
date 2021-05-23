#!/bin/bash

# Change directory into specified path
cd $1

# Check if anything already exists
if [ -d $2 ]; then 
  read -p "File already exists. Do you want to delete and replace it?[Y/n]" permission
  echo $permission
  if [[ $permission == 'Y' || $permission == 'y' || -z $permission ]]; then 
    rm -rf $2
  else
    echo "Stopping templater..."
    exit
  fi
fi

# Make file structure
mkdir $2
echo "Created directory $2"
echo
cd $2

echo "Starting templating..."
echo
# Write template to main.cpp
echo "#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	printf(\"Hello World\");
	return 0;
}
" > main.cpp
echo "Added main.cpp"

# Write template to Makefile
echo "CC = g++
FLAGS = -Wall -Wextra
OBJ = main.cpp

OSFLAG 				:=
ifeq (\$(OS),Windows_NT)
	OSFLAG += WIN32
else
	UNAME_S := \$(shell uname -s)
	ifeq (\$(UNAME_S),Linux)
		OSFLAG += LINUX
	endif
	ifeq (\$(UNAME_S),Darwin)
		OSFLAG += OSX
	endif
		UNAME_P := \$(shell uname -p)
	ifeq (\$(UNAME_P),x86_64)
		OSFLAG += AMD64
	endif
		ifneq (\$(filter %86,\$(UNAME_P)),)
	OSFLAG += IA32
		endif
	ifneq (\$(filter arm%,\$(UNAME_P)),)
		OSFLAG += ARM
	endif
endif

ifeq (\$(findstring WIN32, \$(OSFLAG)), WIN32)
	EXT =.exe
else
	EXT =.sh
endif

all: build run

build: \$(OBJ)
	\$(CC) \$(FLAGS) \$(OBJ) -o build/main\$(EXT) 

run: build/main\$(EXT)
	build/main\$(EXT)

clean:
	rm build/main\$(EXT)

.PHONY: clean
" > Makefile
echo "Added Makefile"
echo

# Make the build folder
mkdir build

echo "Finished templating!"
