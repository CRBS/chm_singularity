.PHONY: clean singularity

help:
	@echo "clean - remove all build and test artifacts"
	@echo "singularity - Creates singularity image"

clean:
	rm -fr build/

singularity: clean
	@echo 'Creating Singularity image'
	mkdir -p build
	vers=`cat VERSION | sed "s/\n//g"`; \
	echo 'Version $$vers'; \
	imgfile='build/chm.img' ; \
	sudo singularity create -s 4096 $$imgfile ; \
	sudo singularity bootstrap $$imgfile centos.def $$vers; \
	echo 'Singularity image created $imgfile'
	ls -l build

singularity22: clean
        @echo 'Creating Singularity v22 image'
        mkdir -p build
        imgfile='build/chm_s22.img' ; \
        sudo singularity create -s 4096 $$imgfile ; \
        sudo singularity bootstrap $$imgfile centos_singularity22.def; \
        echo 'Singularity image created $imgfile'
        ls -l build
