include config.mk

all:
	@ for dir in $(BUILD_DIR); \
	do \
		make -C $$dir; \
	done

.PHONY: clean
clean:
	rm -fr app/link_obj app/dep myapp
