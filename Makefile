# ----- Docker section -----
docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-build:
	docker-compose build

# ----- Code section -----
check-code:
	isort api/ app/
	flake8 --extend-ignore E501 api/ app/ web/

# ----- Django section -----
start-dev-server: docker-up
	python manage.py runserver

migrate:
	python manage.py makemigrations
	python manage.py migrate

superuser:
	python manage.py createsuperuser --noinput

load-fake-data:
	python manage.py loaddata item

