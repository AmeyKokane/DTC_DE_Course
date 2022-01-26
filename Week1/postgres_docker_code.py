services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    volumes:
      - postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      interval: 5s
      retries: 5
    restart: always

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxis" \
  -v /Users/amey/git/data-engineering-zoomcamp/2_docker_sql/ny_taxis_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13



docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  dpage/pgadmin4


  #TO be able to connect PGADMIN container to POSTGRES container they need to be connected. Modifying above code to create network connection between these to containers.

docker network create pg-network

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxis" \
  -v /Users/amey/git/data-engineering-zoomcamp/2_docker_sql/ny_taxis_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4

URL="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv"

python3 ingest_data.py \
  --user=root \
    --password=root \
    --host=localhost \
    --port=5432 \
    --db=ny_taxis \
    --table_name=yellow_taxi_data \
    --url=${URL}


docker build -t taxi_ingest:v001 .

docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --user= root \
      --password= root \
      --host= localhost \
      --port= 5432 \
      --db= ny_taxis \
      --table_name= yellow_taxi_data \
      --url= ${URL}


