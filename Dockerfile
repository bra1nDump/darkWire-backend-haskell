FROM haskell:8.2.2

WORKDIR /app

COPY . ./
RUN stack build

EXPOSE 8000

CMD stack exec darkWire-backend-exe
