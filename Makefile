VERSION ?= latest

default: build

clean:
	docker rmi bborbe/taiga-frontend:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t bborbe/taiga-frontend:$(VERSION) .

run:
	docker run -h example.com -p 80:80 bborbe/taiga-frontend:$(VERSION)

shell:
	docker run -i -t bborbe/taiga-frontend:$(VERSION) /bin/bash

upload:
	docker push bborbe/taiga-frontend:$(VERSION)
