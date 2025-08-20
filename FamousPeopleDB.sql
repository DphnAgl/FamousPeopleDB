
CREATE TABLE famous_people (
    id INTEGER PRIMARY KEY,
    fullname TEXT,
    age INTEGER,
    profession_type TEXT,
    is_married INTEGER,   
    -- 1 = married, 0 = not married
    spouse_id INTEGER,
    region TEXT
);

CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    actor_id INTEGER,
    title TEXT,
    genre TEXT,
    duration INTEGER
);

CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    singer_id INTEGER,
    title TEXT
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    author_id INTEGER,
    title TEXT,
    publication_year INTEGER
);

CREATE TABLE character_books (
    id INTEGER PRIMARY KEY,
    character_id INTEGER,
    book_id INTEGER,
    FOREIGN KEY (character_id) 
    REFERENCES famous_people(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE character_relations (
    id INTEGER PRIMARY KEY,
    character_id INTEGER,
    related_character_id INTEGER,
    relation TEXT,
    FOREIGN KEY (character_id) 
    REFERENCES famous_people(id),
    FOREIGN KEY (related_character_id) 
    REFERENCES famous_people(id)
);

-- famous_people
INSERT INTO famous_people (id, fullname, age, profession_type, is_married, spouse_id, region) VALUES
(1, 'Tom Hanks', 66, 'Actor', 1, 2, 'USA'),
(2, 'Rita Wilson', 64, 'Actor', 1, 1, 'USA'),
(3, 'Beyonce Knowles', 40, 'Singer', 1, NULL, 'USA'),
(4, 'J.K. Rowling', 55, 'Author', 0, NULL, 'UK'),
(5, 'Harry Potter', 17, 'Fictional Character', 0, NULL, 'UK'),
(6, 'Robert Downey Jr.', 58, 'Actor', 1, NULL, 'USA'),
(7, 'Scarlett Johansson', 38, 'Actor', 0, NULL, 'USA'),
(8, 'Ed Sheeran', 32, 'Singer', 0, NULL, 'UK'),
(9, 'George R.R. Martin', 74, 'Author', 1, NULL, 'USA'),
(10, 'Hermione Granger', 17, 'Fictional Character', 0, NULL, 'UK');

-- movies
INSERT INTO movies (id, actor_id, title, genre, duration) VALUES
(1, 1, 'Forrest Gump', 'Drama', 142),
(2, 1, 'Cast Away', 'Adventure', 143),
(3, 2, 'Runaway Bride', 'Romantic Comedy', 116),
(4, 6, 'Iron Man', 'Action', 126),
(5, 6, 'Sherlock Holmes', 'Action', 128),
(6, 7, 'Lucy', 'Sci-Fi', 89);

-- songs
INSERT INTO songs (id, singer_id, title) VALUES
(1, 3, 'Halo'),
(2, 3, 'Single Ladies'),
(3, 8, 'Shape of You'),
(4, 8, 'Perfect');

-- books
INSERT INTO books (id, author_id, title, publication_year) VALUES
(1, 4, 'Harry Potter and the Philosopher''s Stone', 1997),
(2, 4, 'Harry Potter and the Chamber of Secrets', 1998),
(3, 9, 'A Game of Thrones', 1996),
(4, 9, 'A Clash of Kings', 1998);

-- character_books
INSERT INTO character_books (id, character_id, book_id) VALUES
(1, 5, 1),
(2, 5, 2),
(3, 10, 1),
(4, 10, 2);

-- character_relations
INSERT INTO character_relations (id, character_id, related_character_id, relation) VALUES
(1, 10, 5, 'Friend');

--What movies are they in? Are they married to each other?
SELECT 
m.title as movie_tile, 
m.actor_id, 
f.fullname as actor_name, 
f.spouse_id as spouse_name, 
s.fullname
FROM movies m
JOIN famous_people f 
ON m.actor_id = f.id
LEFT JOIN famous_people s
ON f.spouse_id = s.id;

--What songs did they write? Where are they from?
SELECT
s.title as song_title,
f.fullname as singer_name,
f.region
FROM songs s
JOIN famous_people f
ON s.singer_id = f.id;

--What books did they write?
SELECT
b.title as book_tile,
f.fullname as author_name
FROM books b
JOIN famous_people f
ON b.author_id = f.id;

--How are they related to other characters? What books do they show up in?
SELECT
f.fullname as character_name,
b.title as book_tile
FROM character_books cb
JOIN famous_people f
ON cb.character_id = f.id
JOIN books b
ON cb.book_id = b.id;

SELECT
f.fullname AS character_name,
r.relation,
f2.fullname AS related_to
FROM character_relations r
JOIN famous_people f 
ON r.character_id = f.id
JOIN famous_people f2
ON r.related_character_id = f2.id;
