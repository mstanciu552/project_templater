CC = g++
FLAGS = -Wall -Wextra
OBJ = main.cpp

OSFLAG 				:=
ifeq ($(OS),Windows_NT)
	OSFLAG += WIN32
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG += LINUX
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG += OSX
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		OSFLAG += AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
	OSFLAG += IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		OSFLAG += ARM
	endif
endif

ifeq ($(findstring WIN32, $(OSFLAG)), WIN32)
	EXT =.exe
else
	EXT =.sh
endif

all: build run

build: $(OBJ)
	$(CC) $(FLAGS) $(OBJ) -o build/temp$(EXT) 

run: build/temp$(EXT)
	build/temp$(EXT)

clean:
	rm build/temp$(EXT)

.PHONY: clean