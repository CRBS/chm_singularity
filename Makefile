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
	imgfile=`echo build/chm-$$vers.img` ; \
	sudo singularity create -s 4096 $$imgfile ; \
	sudo singularity bootstrap $$imgfile centos.def $$vers; \
	echo 'Singularity image created $imgfile'
	ls -l build
