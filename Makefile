ifeq ($(OS),Windows_NT)
    RM = rm -f
    EXE = .exe
    LINK = cp -f
    P = $(1)
else
    RM = rm -f
    EXE =
    LINK = ln -sf
    P = $(1)
endif

.PHONY: serial mpi clean-serial clean-mpi

serial:
	$(MAKE) -C serial-implementation
	$(LINK) $(call P,serial-implementation/main_serial$(EXE)) main_serial$(EXE)

clean-serial:
	-$(MAKE) -C serial-implementation clean
	$(RM) main_serial$(EXE)

mpi:
	$(MAKE) -C mpi-implementation
	$(LINK) $(call P,mpi-implementation/main_mpi$(EXE)) main_mpi$(EXE)

clean-mpi:
	-$(MAKE) -C mpi-implementation clean
	$(RM) main_mpi$(EXE)