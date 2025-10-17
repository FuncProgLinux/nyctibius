# The directory where the build system Makefiles are stored
MAKE_DIR := build-system

# Show help by default when managing configurations. This is
# to avoid changing guix with blank commands.
all: help

# === LOAD Makefiles
include $(MAKE_DIR)/Makefile.dev
include $(MAKE_DIR)/Makefile.fmt
include $(MAKE_DIR)/Makefile.lint

help:
	@perl $(MAKE_DIR)/help.pl "$(MAKEFILE_LIST)"
