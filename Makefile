config-copy:
	cp 'config/application.yml.sample' 'config/application.yml'
	
docker.start:
	docker-compose up

# Creates `blogger_test` in postgres if one is not there. This needs to be run before docker.migrate task
docker.create_test_db:
	docker-compose exec db psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'blogger_test'\
	" | grep -q 1 || docker-compose exec db psql -U postgres -c "CREATE DATABASE blogger_test"

# Creates `blogger_development` in postgres if it's not there
docker.create_dev_db:
	docker-compose exec db psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'blogger_development'\
	" | grep -q 1 || docker-compose exec db psql -U postgres -c "CREATE DATABASE blogger_development"

# Migrates the database
docker.migrate: docker.create_dev_db docker.create_test_db
	docker-compose exec web bundle exec rake db:migrate
	docker-compose exec -e RAILS_ENV=test -e DATABASE=blogger_test web bundle exec rake db:migrate