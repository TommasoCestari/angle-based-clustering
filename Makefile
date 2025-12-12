CC = gcc
CFLAGS = -I/opt/homebrew/opt/libtiff/include -Ic/include
LDFLAGS = -L/opt/homebrew/opt/libtiff/lib -ltiff
SRC_DIR = c/src

# Create build directory if needed
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile image_to_tensor
image_to_tensor: $(SRC_DIR)/image_to_tensor.c $(SRC_DIR)/tiff_image_vectorization.c 
	$(CC) $(CFLAGS) $^ -o $@$(EXE) $(LDFLAGS)

# Compile tiff_analyzer
tiff_analyzer: $(SRC_DIR)/tiff_analyzer.c 
	$(CC) $(CFLAGS) $< -o $@$(EXE) $(LDFLAGS)

# Compile both (default target)
all: image_to_tensor tiff_analyzer

# Clean compiled files
clean:
	$(RM) image_to_tensor$(EXE) tiff_analyzer$(EXE) text.txt

.PHONY: all clean