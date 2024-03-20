FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/ayushgptaa/SauceKudasai.git && \
    cd SauceKudasai && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:16 AS build

WORKDIR /SauceKudasai
COPY --from=base /git/SauceKudasai .
RUN npm install && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /SauceKudasai/build .
