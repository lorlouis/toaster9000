FQBN = arduino:avr:leonardo

SOURCE = toaster.ino
BUILD_PATH = build

CFLAGS = --build-cache-path $(BUILD_PATH)

PORT = $(shell arduino-cli board list | grep "$(FQBN)" | grep -o "^[^ ]*")

.PHONY: build
build:
	arduino-cli compile $(CFLAGS) --fqbn $(FQBN) $(SOURCE)

cdb:
	arduino-cli compile --only-compilation-database $(CFLAGS) --fqbn $(FQBN) $(SOURCE)

upload: build
	arduino-cli upload -p $(PORT) --fqbn $(FQBN)
