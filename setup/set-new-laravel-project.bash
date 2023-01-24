#!/bin/bash

set -eu

# Fail on a single failed command in a pipeline
set -o pipefail 


echo -n "Project Name: "
read name


setup-mysql-database() {
	sudo mysql -e "DROP DATABASE IF EXISTS ${name};"
	sudo mysql -e "CREATE DATABASE ${name};"
	sudo mysql -e "DROP   USER IF EXISTS '${name}-user'@'localhost';"
	sudo mysql -e "CREATE USER '${name}-user'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	sudo mysql -e "GRANT ALL PRIVILEGES ON * . * TO '${name}-user'@'localhost';"
	sudo mysql -e "FLUSH PRIVILEGES;"
}


start-laravel-project() {
	composer create-project --prefer-dist laravel/laravel ${name};
}


update-project-name() {
	sed -i -e "s/my_project_name/${name}/g" ./Makefile
	sed -i -e "s/my_project_name/${name}/g" ./README.md 
}


remove-setup-files() {
	rm -rf ./setup/
}


setup-mysql-database
start-laravel-project
remove-setup-files
