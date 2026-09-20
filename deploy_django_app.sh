#!/bin/bash

<<task
deploy a django app
and check code for errors
task

code_clone(){
	echo "cloning the django app..."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements(){
	echo "installing dependencies..."
	sudo apt-get install docker.io nginx -y
}

required_restarts(){
	sudo chown $USER /var/run/docker.sock
	sudo systemctl enable docker
	sudo systemctl enable nginx
	sudo systemctl restart docker
}

deploy(){
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo "*****deployment started********"
if [ -d "django-notes-app" ]; then
	echo "the code directory already exists"
	cd django-notes-app
else
	code_clone
	cd djano-notes-app
fi

if ! install_requirements; then
	echo "installation failed"
	exit 1
fi
 
if ! required_restarts; then
	echo "System fault identified"
	exit 1
fi
 
if ! deploy; then
	echo "Deployment failed, mailing the admin..."
	exit 1
fi

echo "*******deployment done********"
