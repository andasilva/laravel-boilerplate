## Application boiler

This a boiler to use:
 - Laravel 8 + Jetstream + InertiaJS (Vuejs)
 - Postgres 13
 - Nginx
 
### How to use it?
Run: 
`
docker-compose up
`

Then you need to run migrations with the following command:

`
docker exec boiler-app php artisan migrate
`

Note: It's possible to add an Entrypoint for that (in the dockerfile of the Laravel app).
 
#### Laravel
 
This boiler comes with jetstream: https://jetstream.laravel.com/1.x/introduction.html

The dockerfile run php-fpm (on port 9000) to serve the php files to nginx. 
 
#### Postgres 13
Nothing special with this image, only PostreSQL 13 :)

#### Nginx
The dockerfile for this image take the public folder from laravel app and serve static files.

### More

This is a simple readme, it will be completed during the evolution of this boiler.

Don't forget to change the environments values. They are here only for the project be ready to start/test.
