SRC_DIR = c/src

# Detect OS
ifeq ($(OS),Windows_NT)
    CC = gcc
    CFLAGS = -IC:/msys64/mingw64/include -Ic/include 
    LDFLAGS = -LC:/msys64/mingw64/lib -ltiff -lm
    RM = del /Q
    EXE = .exe
else
    CC = gcc
    CFLAGS = -I/opt/homebrew/opt/libtiff/include -Ic/include 
    LDFLAGS = -L/opt/homebrew/opt/libtiff/lib -ltiff -lm
    RM = rm -f
    EXE =
endif

# Object files
OBJ = $(SRC_DIR)/main.o $(SRC_DIR)/tiff_image_vectorization.o $(SRC_DIR)/kd_tree.o $(SRC_DIR)/knn_operations.o $(SRC_DIR)/sorting.o $(SRC_DIR)/DBSCAN.o 

# Header dependencies
HEADERS = c/include/*.h

# Compile object files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

#$(KDTREE_DIR)/%.o: $(KDTREE_DIR)/%.c
#	$(CC) $(CFLAGS) -c $< -o $@

# Link everything into main (image_to_tensor)
main: $(OBJ)
	$(CC) $(OBJ) -o $@$(EXE) $(LDFLAGS)

# Clean compiled files
clean:
	$(RM) $(SRC_DIR)/*.o main$(EXE) tiff_analyzer$(EXE) kd_tree$(EXE) text.txt

.PHONY: clean
