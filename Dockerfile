FROM node:16.14.0 as build
ARG REACT_APP_TG_API_ID
ARG REACT_APP_TG_API_HASH

WORKDIR /apps

COPY yarn.lock .
COPY package.json .
COPY api/package.json api/package.json
COPY web/package.json web/package.json

Expose 4000

RUN npx browserslist@latest --update-db
RUN yarn cache clean
RUN yarn install --network-timeout 1000000
COPY . .

# Run the web service on container startup.
CMD [ "yarn", "workspaces", "run", "build" ]

# RUN  workspaces run build
