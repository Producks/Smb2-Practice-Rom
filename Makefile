OS := $(shell uname)

ifeq ($(OS), Linux)
    BUILD := ./build.sh
else
    BUILD := ./build.bat
endif

all:
	$(BUILD)
