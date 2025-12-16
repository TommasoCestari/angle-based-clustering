KDTREE_DIR = kdtree-0.5.7
SRC_DIR = c/src

# Detect OS
ifeq ($(OS),Windows_NT)
    # Windows with MSYS2/MinGW
    CC = gcc
    CFLAGS = -IC:/msys64/mingw64/include -Ic/include -I$(KDTREE_DIR)
    LDFLAGS = -LC:/msys64/mingw64/lib -ltiff -lm
    RM = del /Q
    EXE = .exe
else
    # Mac/Linux
    CC = gcc
    CFLAGS = -I/opt/homebrew/opt/libtiff/include -Ic/include -I$(KDTREE_DIR)
    LDFLAGS = -L/opt/homebrew/opt/libtiff/lib -ltiff -lm
    RM = rm -f
    EXE =
endif



# Compile image_to_tensor
image_to_tensor: $(SRC_DIR)/image_to_tensor.c $(SRC_DIR)/tiff_image_vectorization.c 
	$(CC) $(CFLAGS) $^ -o $@$(EXE) $(LDFLAGS)

# Compile tiff_analyzer
tiff_analyzer: $(SRC_DIR)/tiff_analyzer.c 
	$(CC) $(CFLAGS) $< -o $@$(EXE) $(LDFLAGS)

kd_tree: $(SRC_DIR)/kd_tree.c $(KDTREE_DIR)/kdtree.c
	$(CC) $(CFLAGS) $^ -o $@$(EXE) $(LDFLAGS)

# Compile all (default target)
all: image_to_tensor tiff_analyzer kd_tree

# Clean compiled files
clean:
	$(RM) image_to_tensor$(EXE) tiff_analyzer$(EXE) clustering$(EXE) text.txt

.PHONY: all clean