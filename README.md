# node-cloud-run
Connect to Google Cloud SQL in Cloud Run
https://cloud.google.com/run/docs/

Since there is no official support of accessing Cloud SQL from Cloud Run

https://cloud.google.com/run/docs/using-gcp-services


you can sidecar Cloud SQL Proxy inside your container which you can find my Dockerfile in this repo, and use the custum bash script to run both sql proxy and your node server app.

https://cloud.google.com/sql/docs/mysql/sql-proxy


You need to provide access to the database via add CloudSQL Client role to your Cloud Run service account (email ending with @serverless-robot-prod.iam.gserviceaccount.com ) which will give access to all your Cloud Run services. Also, you need to enable Cloud SQL Admin API.

https://cloud.google.com/sql/docs/postgres/admin-api/


