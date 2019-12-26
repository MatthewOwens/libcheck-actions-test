TEST_TARGET = check
LIBS = -lm -D_REENTRANT -std=c11
TEST_LIBS = $(LIBS) `pkg-config --libs check`

CC = gcc
CFLAGS = -g -Wall -Isystems/ -Icomponents/ -Isrc/ -I/usr/local/include
TEST_CFLAGS = $(CFLAGS) `pkg-config --cflags check`

.PHONY: default all clean FORCE

default: all
all: $(TEST_TARGET)

TEST_OBJECTS = $(patsubst tests/%.c, tests/%.o, $(wildcard tests/*.c))
TEST_HEADERS = $(wildcard tests/*.h) $(wildcard tests/**/*.h)
TEST_SRCS = $(wildcard tests/*.c) $(wildcard tests/**/*.c)

.PRECIOUS: $(TARGET) $(TEST_OBJECTS)

$(TEST_TARGET): $(TEST_OBJECTS) FORCE
	@echo "========== Building $(TEST_TARGET) =========="
	$(CC) $(TEST_CFLAGS) $(TEST_OBJECTS) $(TEST_LIBS) -o $@
	@echo "========== RUNNING TESTS =========="
	./$(TEST_TARGET)
	@echo ""

tests/%o: tests/%.c
	$(CC) $(TEST_CFLAGS) -c $^ -o $@


clean:
	rm -f tests/*.o
	rm -f $(TEST_TARGET)

FORCE:


output:
	@echo "==== $(TARGET) ===="
	@echo "sources: $(SRCS)"
	@echo "headers: $(HEADERS)"
	@echo "objects: $(OBJECTS)"
	@echo "==== $(TEST_TARGET) ===="
	@echo "sources: $(TEST_SRCS)"
	@echo "headers: $(TEST_HEADERS)"
	@echo "objects: $(TEST_OBJECTS)"
