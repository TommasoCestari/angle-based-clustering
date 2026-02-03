.PHONY: serial mpi clean-serial clean-mpi

all: serial mpi

serial:
	$(MAKE) -C serial-implementation
	ln -sf serial-implementation/main_serial ./main_serial

mpi:
	$(MAKE) -C mpi-implementation
	ln -sf mpi-implementation/main_mpi ./main_mpi

clean-serial:
	-$(MAKE) -C serial-implementation clean
	rm -f main_serial

clean-mpi:
	-$(MAKE) -C mpi-implementation clean
	rm -f main_mpi