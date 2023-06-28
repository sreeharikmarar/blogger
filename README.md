# README

Follow the instruction to get the
application up and running.


* Ruby & Rails version
    ```
    $: ruby-2.6.8
    $: Rails 6.1.4.4
    ```

* System dependencies

    ```
    $: bundle install
    ```

* Configuration
    
    * Make changes to application.yaml.sample and then run the following   
    
    ```
    $: make config-copy
    ```

* Database creation & Schema migration

    ```
    $: make docker.create_test_db
    $: make docker.create_dev_db
    $: make docker.migrate_db
    ```

* How to run the test suite
    
    ```
    $: RAILS_ENV=test bundle exec rspec
    ```

* Generate OpenAPI Spec

    ```
    $: RAILS_ENV=test OPENAPI=1 bundle exec rspec
    ```
* Generated OpenAPI Spec can be accessed from  
  - [openapi.yaml](./doc/openapi.yaml)

* Build image
    
    * Dockerfile is located at the root level
    
    ```
    $: docker build -t blogger:latest . --platform linux/amd64
    ```

* Push to container registry
    
    ```
    $: docker tag blogger:latest gcr.io/<project-id>/blogger:latest
    $: docker push gcr.io/<project-id>/blogger:latest
    ```

* Deployment instructions
    
    * All k8s yaml spec can be found under kubernetes folder. 

    ```
    $: kubectl apply -f kubernetes/blogger_credentials.yaml
    $: kubectl apply -f kubernetes/blogger_migration_job.yaml
    $: kubectl apply -f kubernetes/blogger_deployment.yaml
    $: kubectl apply -f kubernetes/blogger_service.yaml
    ```
