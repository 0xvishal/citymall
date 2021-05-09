FROM node:11.15.0
RUN mkdir -p /usr/src/app/frontend
RUN mkdir -p /usr/src/app/build 
WORKDIR /usr/src/app
COPY ./frontend/. /usr/src/app/frontend/
COPY package.json /usr/src/app
RUN cd frontend && yarn && yarn run build
RUN yarn
COPY . /usr/src/app
RUN rm -rf frontend			
CMD ["yarn", "run", "start"]
