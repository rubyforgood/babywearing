If you would like to develop and run the application locally under docker (the advantage being that
all related services will start automatically), follow these steps:

1. These instructions assume you are on MacOS
2. Download and install Docker Desktop for Mac: https://hub.docker.com/editions/community/docker-ce-desktop-mac 
3. Following steps will be performed in terminal and in the root of the project 
4. For login (to Docker Hub) you will be given a link to create an account if needed
    ```
    docker login
    docker-compose build
    docker-compose up
    ```
5. database migration & seed data
    ``` 
     docker-compose exec app bin/rails db:migrate
     docker-compose exec app bin/rails db:seed
    ```