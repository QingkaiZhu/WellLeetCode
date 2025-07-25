# Makefile at repo root

.PHONY: tag-index test clean

# regenerate TAG_INDEX.md
tag-index:
	sh ./generate_tag_index.sh

# # example: run all Python tests
# test-py:
# 	cd python && pytest
# 
# # example: build C++ tests
# test-cpp:
# 	cd cpp && mkdir -p build && cd build && cmake .. && make && ctest
# 
# # run both
# test: test-py test-cpp
# 
# # clean any build artifacts
# clean:
# 	rm -rf python/__pycache__
# 	rm -rf cpp/build

