CXX = g++
CXX_FLAGS = -Wfatal-errors -Wall -Wextra -pedantic-errors -Wconversion -Wshadow \
            -g -fstack-protector-strong
# GIT_HASH := "$(shell git rev-parse HEAD)"
CXX_FLAGS += -DGIT_HASH=\"$(GIT_HASH)\"
BIN = a.out
LDFLAGS =
INCL =
LIBS = $(LDFLAGS)
SRC = $(wildcard *.cc)
OBJ = $(SRC:%.cc=%.o)
DEP = $(OBJ:%.o=%.d)
$(BIN) : $(OBJ)
	mkdir -p $(@D)
	$(CXX) $(CXX_FLAGS) $(INCL) $^ $(LIBS) -o $@
-include $(DEP)
%.o : %.cc
	$(CXX) $(CXX_FLAGS) $(INCL) -MMD -c $< -o $@
.PHONY : clean
clean :
	rm -f $(BIN) *.o *.d core.*
.PHONY : valgrind
valgrind :
	valgrind --leak-check=full --show-leak-kinds=all ./$(BIN)
