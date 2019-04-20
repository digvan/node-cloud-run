# Use the official Node.js 10 image.
# https://hub.docker.com/_/node
FROM node:10

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package.json package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . .

# Thre is no official support to connect to Cloud SQL in Cloud Run therefore we are using cloud sql proxy to connect to DB
# download the cloudsql proxy binary 
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O ./cloud_sql_proxy
RUN chmod +x ./cloud_sql_proxy

# copy the wrapper script and credentials

COPY run.sh ./run.sh


#
# -- build minimal image --
#
FROM node:10

WORKDIR /root

# copy everything from our build folder
COPY --from=0 /usr/src/app .
RUN chmod +x run.sh
CMD ["./run.sh"]
