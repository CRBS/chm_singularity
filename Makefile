.PHONY: clean singularity

help:
	@echo "clean - remove all build and test artifacts"
	@echo "singularity22 - Creates singularity 2.2 image"

clean:
	rm -fr build/

singularity22: clean
	@echo 'Creating Singularity v22 image'
	mkdir -p build
	imgfile='build/chm_s22.img' ; \
	sudo singularity create -s 3296 $$imgfile ; \
	sudo singularity bootstrap $$imgfile centos_singularity22.def; \
	echo 'Singularity image created $imgfile'
	ls -l build
