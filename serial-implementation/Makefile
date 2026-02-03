SRC_DIR = src
INC_DIR = include

# Detect OS
ifeq ($(OS),Windows_NT)
    CC = gcc
    CFLAGS = -IC:/msys64/mingw64/include -I$(INC_DIR)
    LDFLAGS = -LC:/msys64/mingw64/lib -ltiff -lm
    RM = del /Q
    EXE = .exe
else
    CC = gcc
    CFLAGS = -I/opt/homebrew/opt/libtiff/include -I$(INC_DIR)
    LDFLAGS = -L/opt/homebrew/opt/libtiff/lib -ltiff -lm
    RM = rm -f
    EXE =
endif

# Object files
OBJ = $(SRC_DIR)/main.o $(SRC_DIR)/tiff_image_vectorization.o $(SRC_DIR)/kd_tree.o $(SRC_DIR)/knn_operations.o $(SRC_DIR)/sorting.o $(SRC_DIR)/DBSCAN.o 

# Target name
TARGET = main_serial$(EXE)

# Default rule
all: $(TARGET)

# Link everything into the executable in the ROOT
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Compile object files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c 
	$(CC) $(CFLAGS) -c $< -o $@

#$(KDTREE_DIR)/%.o: $(KDTREE_DIR)/%.c
#	$(CC) $(CFLAGS) -c $< -o $@

# Clean compiled files
clean:
	$(RM) $(SRC_DIR)/*.o $(TARGET)

.PHONY: all clean
