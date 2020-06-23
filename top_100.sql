--Desafío - Top 100
--Para realizar este desafío debes haber estudiado previamente todo el material disponibilizado en la sesión online correspondiente a la unidad.
--Una vez terminado el desafío, comprime la carpeta y sube el .zip
--Instrucciones
-- 1. Crear base de datos llamada películas (1 punto)
CREATE DATABASE movies;
\c movies

-- 2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas. (2 puntos)
CREATE TABLE movies(
    id INT PRIMARY KEY,
    name_movie VARCHAR(100),
    release_year INT,
    director VARCHAR(50)
);

CREATE TABLE actors(
    id INT,
    name_actor VARCHAR(50),
    FOREIGN KEY (id) REFERENCES movies(id)
);

-- 3. Cargar ambos archivos a su tabla correspondiente (1 punto)
\copy movies FROM 'peliculas.csv' csv header;
\copy actors FROM 'reparto.csv' csv;

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto. (0.5 puntos)
SELECT name_movie, release_year, director, name_actor FROM movies JOIN actors ON movies.id=actors.id WHERE movies.name_movie='Titanic';

-- 5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)
SELECT name_movie FROM movies JOIN actors ON movies.id=actors.id WHERE actors.name_actor='Harrison Ford';

-- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.(1 puntos)
SELECT director,count(*) FROM movies GROUP BY director ORDER BY count(*) DESC LIMIT 10; 

-- 7. Indicar cuantos actores distintos hay (1 puntos)
SELECT count (DISTINCT name_actor) FROM actors; 
SELECT DISTINCT name_actor FROM actors;

-- 8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.(1 punto)
SELECT name_movie, release_year FROM movies WHERE release_year >= 1990 AND release_year <= 1999 ORDER BY name_movie;

-- 9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)
SELECT name_actor, name_movie, release_year FROM movies JOIN actors ON movies.id=actors.id WHERE release_year=2001;

-- 10. Listar los actores de la película más nueva (1 punto)
SELECT name_actor, name_movie, release_year FROM movies JOIN actors ON movies.id=actors.id WHERE release_year=(SELECT MAX(release_year) FROM movies);

-- Para la realización de este desafío se deben descargar los siguientes archivos, que se ecuentran en
-- plataforma en el archivo zip llamado Apoyo Desafío
-- peliculas.csv
-- reparto.csv