default: build

clean:
	docker rmi bborbe/taiga-frontend

build:
	docker build --rm=true -t bborbe/taiga-frontend .

run:
	docker run -h example.com -p 80:80 bborbe/taiga-frontend:latest

bash:
	docker run -i -t bborbe/taiga-frontend:latest /bin/bash

upload:
	docker push bborbe/taiga-frontend
