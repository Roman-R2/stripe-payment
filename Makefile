include .env
export

# ----- Docker section ---------------------------------------
# ----- Docker dev section -----
docker-dev-up:
	docker-compose up -d

docker-dev-build-up:
	docker-compose up -d --build

docker-dev-down:
	docker-compose down --remove-orphans

docker-dev-logs:
	docker-compose -f docker-compose.yml logs -f

# ----- Docker prod section -----
docker-prod-start: docker-prod-build-up docker-prod-migrate docker-prod-createsuperuser docker-prod-collectstatic docker-prod-loaddata

docker-prod-restart: docker-prod-down docker-prod-build-up docker-prod-migrate \
docker-prod-createsuperuser docker-prod-collectstatic docker-prod-loaddata

docker-prod-down:
	docker-compose -f docker-compose-production.yml down -v --remove-orphans

docker-prod-build-up:
	docker-compose -f docker-compose-production.yml up -d --build

docker-prod-migrate:
	docker-compose -f docker-compose-production.yml exec python-cli python manage.py makemigrations --noinput
	docker-compose -f docker-compose-production.yml exec python-cli python manage.py migrate --noinput

docker-prod-collectstatic:
	docker-compose -f docker-compose-production.yml exec python-cli python manage.py collectstatic --no-input --clear

docker-prod-createsuperuser:
	docker-compose -f docker-compose-production.yml exec python-cli python manage.py createsuperuser --noinput

docker-prod-loaddata:
	docker-compose -f docker-compose-production.yml exec python-cli python manage.py loaddata item


docker-prod-logs:
	docker-compose -f docker-compose-production.yml logs -f

docker-commit:
	docker commit stripe-payment-python-cli ${REGISTRY_ADDRESS}/stripe-payment-python-cli:${IMAGE_TAG}
	docker commit stripe-payment-postgres ${REGISTRY_ADDRESS}/stripe-payment-postgres:${IMAGE_TAG}
	docker commit stripe-payment-nginx ${REGISTRY_ADDRESS}/stripe-payment-nginx:${IMAGE_TAG}

docker-push:
	docker push ${REGISTRY_ADDRESS}/stripe-payment-python-cli:${IMAGE_TAG}
	docker push ${REGISTRY_ADDRESS}/stripe-payment-postgres:${IMAGE_TAG}
	docker push ${REGISTRY_ADDRESS}/stripe-payment-nginx:${IMAGE_TAG}

docker-pull:
	docker pull ${REGISTRY_ADDRESS}/stripe-payment-nginx:${IMAGE_TAG}
	docker pull ${REGISTRY_ADDRESS}/stripe-payment-postgres:${IMAGE_TAG}
	docker pull ${REGISTRY_ADDRESS}/stripe-payment-python-cli:${IMAGE_TAG}

# ----- Code section -----
check-code:
	docker-compose -f docker-compose.yml exec python-cli isort api/ app/
	docker-compose -f docker-compose.yml exec python-cli flake8 --extend-ignore E501,F401 api/ app/ web/

# ----- Django section -----
prepare-server: flush migrate superuser load-fake-data

start-simple-dev-server:
	python manage.py runserver

start-docker-dev-server: docker-dev-down docker-dev-build-up

flush:
	python manage.py flush --no-input

migrate:
	python manage.py makemigrations
	python manage.py migrate

superuser:
	python manage.py createsuperuser --noinput

load-fake-data:
	python manage.py loaddata item

some-scp:
	scp docker-compose-production-load.yml root@${REGISTRY_ADDRESS}:/root/stripe-payment
	scp Makefile root@${REGISTRY_ADDRESS}:/root/stripe-payment
	scp .env.prod root@${REGISTRY_ADDRESS}:/root/stripe-payment
	scp .env.prod.db root@${REGISTRY_ADDRESS}:/root/stripe-payment

vds-server-up: docker-pull
	docker-compose -f docker-compose-production-load.yml down -v --remove-orphans
	docker-compose -f docker-compose-production-load.yml up -d
	docker-compose -f docker-compose-production-load.yml exec python-cli python manage.py makemigrations --noinput
	docker-compose -f docker-compose-production-load.yml exec python-cli python manage.py migrate --noinput
	docker-compose -f docker-compose-production-load.yml exec python-cli python manage.py createsuperuser --noinput
	docker-compose -f docker-compose-production-load.yml exec -u root python-cli chown app:app /home/app/web/staticfiles
	docker-compose -f docker-compose-production-load.yml exec python-cli python manage.py collectstatic --no-input --clear
	docker-compose -f docker-compose-production-load.yml exec python-cli python manage.py loaddata item