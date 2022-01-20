# Files
BINARY = main
COMPRESS = project
DEBUG = debug

# Directories
BIN = core
SRC = src
OBJ = obj
HDR = include

# Compiler
CC = gcc
CFLAGS = -Wall -o

SRCS = $(wildcard $(SRC)/*.c)
OBJS = $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))
HDRS = $(patsubst $(SRC)/%.c, $(HDR)/%.h, $(SRCS))

$(BIN)/$(BINARY): $(OBJS) $(OBJ)/$(BINARY).o
	$(CC) $(CFLAGS) $@ $^

$(OBJ)/$(BINARY).o: $(BIN)/$(BINARY).c $(HDRS)
	$(CC) -c $(CFLAGS) $@ $<

$(OBJ)/%.o: $(SRC)/%.c $(HDR)/%.h
	$(CC) -c $(CFLAGS) $@ $<

all: clean $(BIN)/$(BINARY) rar

debug: clean
debug: BINARY = $(DEBUG)
debug: CFLAGS = -Wall -g -o
debug: $(BIN)/$(BINARY)

zip:
	$(RM) $(COMPRESS).zip
	zip $(COMPRESS) -r *

rar:
	$(RM) $(COMPRESS).rar
	rar a $(COMPRESS) -r *

clean:
	$(RM) $(BIN)/$(BINARY) $(BIN)/$(DEBUG) $(OBJ)/*.o $(COMPRESS).rar $(COMPRESS).zip
