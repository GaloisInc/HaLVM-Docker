IMAGES=fedora23-simple-base     fedora23-gmp-base     \
       fedora23-simple-extended fedora23-gmp-extended

IMAGE_TARGETS=$(foreach i,$(IMAGES),.build/$(i).image)

PUSH_LIST=$(foreach i,$(IMAGES),halvm/halvm:$(i))

all: ${IMAGE_TARGETS}

define require
.build/$1.image: .build/$2.image
endef

$(eval $(call require,fedora23-simple-extended,fedora23-simple-base))

################################################################################

clean:
	for i in $(IMAGES); do docker rmi halvm/halvm:$${i}; done
	rm -rf $(IMAGE_TARGETS)

upload:
	docker login
	docker push $(PUSH_LIST)

.build/%.image: %/Dockerfile
	docker build -t halvm/halvm:$* $*
	mkdir -p .build
	touch $@
