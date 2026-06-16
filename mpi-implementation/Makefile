# Makefile for mpi-implementation

SRC_DIR = src
INC_DIR = include

CC = mpicc
CFLAGS = -Iinclude -fopenmp
LDFLAGS = -ltiff -lm -fopenmp
RM = rm -f

# Object files
OBJ = $(SRC_DIR)/main.o $(SRC_DIR)/tiff_image_vectorization_mpi.o $(SRC_DIR)/kd_tree.o $(SRC_DIR)/knn_operations.o $(SRC_DIR)/sorting.o $(SRC_DIR)/DBSCAN.o $(SRC_DIR)/non_border_assigning.o $(SRC_DIR)/log_results.o

# Header dependencies
HEADERS = $(INC_DIR)/*.h

# Target name
TARGET = main_mpi

# Default rule
all: $(TARGET)

# Link everything into the executable
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Compile object files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean compiled files
clean:
	$(RM) $(SRC_DIR)/*.o main_mpi

.PHONY: clean
