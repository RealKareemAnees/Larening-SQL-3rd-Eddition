docker run --name my_postgres -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -e POSTGRES_DB=mydatabase -v pgdata:/var/lib/postgresql/data -p 5432:5432 -d postgres
