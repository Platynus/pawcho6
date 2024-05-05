# Sprawozdanie z labolatorium 6

# Zadanie Wykonał Patryk Pawelec
## numer indeksu 97696

## 1. Utworzenie repozytorium za pomoca komendy gh repo create

![obraz](https://github.com/Platynus/pawcho6/assets/56522713/e972ef16-7d78-484e-8d4f-266af361f529)

## 2.Sklonowanie repozytorium z poprzedniego labolatorium

![obraz](https://github.com/Platynus/pawcho6/assets/56522713/6f93c2a0-5e29-482b-8e72-8907fb2fb9cb)

## 3. Zmodyfikowanie istniejącego pliku dockerfile

Można zobaczyć w historii commitów

## 4. Dodanie pobierania repozytorium z wykorzystaniem protokołu SSH

![obraz](https://github.com/Platynus/pawcho6/assets/56522713/a320a9f4-f230-4aa0-aea5-f64871df0a2b)

## 5. Próba budowy docker file z SSH 
### Wykorzystana komenda 
```
docker build -t test .
```
![obraz](https://github.com/Platynus/pawcho6/assets/56522713/5c64ecf7-0768-49c8-9f61-9fde30ef87b2)

## 6. Przygotowanie Buildkit
### Uruchomienie Buildkit w dedykowanym kontenerze
```
docker run --rm --privileged -d moby/buildkit:latest
```
### Ustawienie zmiennej środowiskowej BUILDKIT_HOST
```
docker run --rm --privileged -d --name buildkit moby/buildkit

docker ps -filter name=buildkit
```
![obraz](https://github.com/Platynus/pawcho6/assets/56522713/e0fff910-291f-4ad8-90ca-eda265b70011)

## 7. Przesłanie i budowa obrazu

### Zalogowanie do 

Next labolatory to learn Docker
