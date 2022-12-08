CREATE DATABASE cs3200proj;

GRANT ALL PRIVILEGES ON cs3200proj.* TO 'webapp'@'%';

FLUSH PRIVILEGES;

USE cs3200proj;

CREATE TABLE Adm(
    admin_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    loc TEXT
);

CREATE TABLE Actor(
    actor_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    admin_id INTEGER NOT NULL,
    CONSTRAINT fk_1 
        FOREIGN KEY (admin_id) REFERENCES Adm (admin_id)
);

CREATE TABLE Director(
    dir_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    fav_genre VARCHAR(50),
    cur_project VARCHAR(75),
    admin_id INTEGER NOT NULL,
    CONSTRAINT fk_2 
        FOREIGN KEY (admin_id) REFERENCES Adm (admin_id)
);

CREATE TABLE Project(
    p_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(30) NOT NULL,
    cast INTEGER,
    country VARCHAR(50) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL,
    duration INTEGER,
    dir_id INTEGER NOT NULL,
    proj_release_date DATE,
    CONSTRAINT fk_3 
        FOREIGN KEY (dir_id) REFERENCES Director (dir_id)   
);

CREATE TABLE Role(
    role_id INTEGER NOT NULL AUTO_INCREMENT,
    projectid INTEGER NOT NULL,
    primary key (role_id, projectid),
    role_type VARCHAR(50) NOT NULL,
    char_name VARCHAR(60) NOT NULL,
    description TEXT,
    age_range VARCHAR(10),
    gender VARCHAR(20),
    status BOOLEAN,
    CONSTRAINT fk_4 
        FOREIGN KEY (projectid) REFERENCES Project (p_id)
);

CREATE TABLE Application(
    projectid INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    primary key (role_id, projectid, actor_id),
    resume TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    submit_time DATETIME NOT NULL,
    CONSTRAINT fk_5 
        FOREIGN KEY (projectid) REFERENCES Project (p_id),
    CONSTRAINT fk_6 
        FOREIGN KEY (role_id) REFERENCES Role (role_id),
    CONSTRAINT fk_7 
        FOREIGN KEY (actor_id) REFERENCES Actor (actor_id)
);

CREATE TABLE Reviews(
    description TEXT,
    rating INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    dir_id INTEGER NOT NULL,
    primary key (actor_id, dir_id),
    CONSTRAINT fk_8 
        FOREIGN KEY (dir_id) REFERENCES Director (dir_id),
    CONSTRAINT fk_9 
        FOREIGN KEY (actor_id) REFERENCES Actor (actor_id),
    CONSTRAINT rating CHECK (rating BETWEEN 1 AND 5)
);

INSERT INTO Adm
    (admin_id,first_name,last_name,loc)
values
    (1, 'Janessa', 'Poynter', 'Jackson'),
    (2, 'Sherri', 'Antonin', 'Kalidung'),
    (3, 'Rosalynd', 'Kuhnwald', 'Johanneshov'),
    (4, 'Lennie', 'Taffley', 'Pushkinskiye Gory'),
    (5, 'Dion', 'Hornig', 'Matamey'),
    (6, 'Anthe', 'Dukelow', 'Årsta'),
    (7, 'Fay', 'Eallis', 'Gaocheng'),
    (8, 'Meredith', 'Graysmark', 'Ramalhal'),
    (9, 'Jenine', 'Clarabut', 'Tegalagung'),
    (10, 'Trip', 'Winspur', 'Vazhiny'),
    (11, 'Gael', 'Cornner', 'Kangar'),
    (12, 'Chad', 'Ladewig', 'Podhum'),
    (13, 'Mathe', 'Offiler', 'Iturama'),
    (14, 'Julia', 'Cleef', 'Dete'),
    (15, 'Cecilia', 'Chamley', 'Saba Yoi'),
    (16, 'Janis', 'Songest', 'Hepu'),
    (17, 'Bogart', 'Cartlidge', 'Belize City'),
    (18, 'Inessa', 'Lebourn', 'Sikka'),
    (19, 'Germana', 'Rider', 'Ţubarjal'),
    (20, 'Rollins', 'Matthews', 'Mysiadło');


INSERT INTO Actor
    (actor_id,first_name,last_name,DOB, admin_id)
values
    (1, 'Legra', 'Schonfelder', '1992-08-15', 13),
    (2, 'Andi', 'Levee', '1973-10-12', 14),
    (3, 'Cacilia', 'Tessington', '1957-07-26', 15),
    (4, 'Fernando', 'Wynes', '1967-01-20', 2),
    (5, 'Bria', 'Fellini', '1960-02-21', 7),
    (6, 'Marketa', 'Klimkiewich', '2014-04-10', 14),
    (7, 'Melony', 'Allibon', '1994-02-11', 10),
    (8, 'Park', 'Maidlow', '2000-12-24', 12),
    (9, 'Darren', 'Monkhouse', '1996-08-15', 11),
    (10, 'Eddy', 'Iles', '1998-12-10', 4),
    (11, 'Katerina', 'Haug', '1963-01-06', 19),
    (12, 'Ertha', 'Trammel', '2013-07-27', 13),
    (13, 'Chas', 'Janse', '1986-09-18', 16),
    (14, 'Asia', 'Musselwhite', '2007-09-18', 1),
    (15, 'Geordie', 'Boother', '1971-07-05', 4),
    (16, 'Bert', 'Morris', '1998-04-15', 17),
    (17, 'Grayce', 'Lightman', '1971-06-02', 6),
    (18, 'Maryrose', 'Precious', '1985-11-06', 13),
    (19, 'Noemi', 'Peppin', '1986-07-24', 13),
    (20, 'Napoleon', 'Dulen', '2013-10-30', 3),
    (21, 'Annis', 'Hucklesby', '1977-07-10', 2),
    (22, 'Silvio', 'Reaveley', '1994-04-20', 17),
    (23, 'Clemmy', 'Ducrow', '1986-07-16', 16),
    (24, 'Kearney', 'Gore', '1972-10-08', 13),
    (25, 'Cris', 'Baxstair', '1972-05-23', 2),
    (26, 'Dina', 'Antwis', '1975-02-10', 4),
    (27, 'Caresse', 'Elvidge', '2001-10-09', 11),
    (28, 'Trudie', 'Carrack', '1978-12-21', 7),
    (29, 'Duncan', 'Hulance', '1953-11-17', 10),
    (30, 'Stewart', 'Sallinger', '1988-08-19', 4),
    (31, 'Carolan', 'Frangleton', '1985-10-30', 6),
    (32, 'Carol', 'Peterken', '2009-12-23', 19),
    (33, 'Brittni', 'Laetham', '1962-03-15', 3),
    (34, 'Elspeth', 'Popelay', '1997-08-30', 15),
    (35, 'Davidde', 'Delgaty', '1994-03-29', 4),
    (36, 'Haydon', 'Lammin', '2007-12-20', 16),
    (37, 'Blinny', 'Wilmut', '1983-03-04', 9),
    (38, 'Yulma', 'Norvell', '2002-10-02', 20),
    (39, 'Wilone', 'Zima', '2012-12-30', 17),
    (40, 'Daryn', 'Fleckness', '1999-07-04', 14),
    (41, 'Francklin', 'Labdon', '1987-08-17', 6),
    (42, 'Hillary', 'Look', '1974-10-21', 9),
    (43, 'Genevra', 'Stede', '1991-03-29', 5),
    (44, 'Keven', 'Gerin', '1960-12-06', 3),
    (45, 'Cob', 'McFee', '1954-10-20', 1),
    (46, 'Arnie', 'Bottell', '1987-03-10', 18),
    (47, 'Ailee', 'Hawney', '2014-11-18', 10),
    (48, 'Hillard', 'Colpus', '1976-12-01', 7),
    (49, 'Carlynn', 'Chappel', '1953-11-26', 19),
    (50, 'Isahella', 'Urch', '1974-06-16', 12),
    (51, 'Lorelei', 'McGow', '2004-09-11', 20),
    (52, 'Woodrow', 'Faulkner', '1954-09-09', 13),
    (53, 'Phillida', 'Reaman', '1961-10-02', 7),
    (54, 'Otis', 'Kirkwood', '1992-11-25', 11),
    (55, 'Hyacinthe', 'Sacher', '1980-10-28', 3),
    (56, 'Clayborn', 'Garbar', '1973-07-06', 13),
    (57, 'Lauretta', 'Earney', '2012-12-15', 3),
    (58, 'Bernhard', 'Matz', '1952-05-16', 20),
    (59, 'Eden', 'Westnedge', '2010-06-22', 1),
    (60, 'Janean', 'Zorzin', '1951-03-05', 4),
    (61, 'Aloin', 'Aasaf', '1983-04-22', 10),
    (62, 'Korey', 'Barnet', '1956-03-23', 19),
    (63, 'Bendite', 'Stoffer', '1964-09-20', 20),
    (64, 'Peder', 'Huffey', '1956-09-11', 13),
    (65, 'Mufi', 'Levi', '2010-02-26', 3),
    (66, 'Feodora', 'Given', '1954-12-22', 2),
    (67, 'Bobbie', 'Paterno', '1981-09-29', 9),
    (68, 'Rainer', 'Usher', '1955-06-05', 13),
    (69, 'Enoch', 'Sulland', '1979-05-20', 8),
    (70, 'Crystal', 'Egentan', '2010-08-19', 10),
    (71, 'Marcille', 'Barlee', '1971-05-28', 2),
    (72, 'Jasper', 'Golland', '2007-05-06', 14),
    (73, 'Winnie', 'Davydochkin', '1971-03-09', 15),
    (74, 'Ezequiel', 'Fazakerley', '1956-05-16', 16),
    (75, 'Delora', 'Kalkofen', '1999-01-21', 5),
    (76, 'Adelaida', 'Cornehl', '2009-08-11', 15),
    (77, 'Godwin', 'Filintsev', '2002-12-01', 8),
    (78, 'Rickard', 'St Ledger', '1978-11-17', 19),
    (79, 'Brady', 'Corker', '1954-06-01', 10),
    (80, 'Tannie', 'Woolward', '2010-04-05', 10),
    (81, 'Tailor', 'De Dantesie', '1956-11-13', 13),
    (82, 'Ricoriki', 'Outridge', '1952-04-26', 20),
    (83, 'Jacqueline', 'Staves', '1967-01-09', 10),
    (84, 'Stanwood', 'Nurny', '2002-12-04', 9),
    (85, 'Artus', 'Bernade', '1958-03-06', 4),
    (86, 'Collete', 'Santo', '1952-04-12', 7),
    (87, 'North', 'Mariel', '1989-02-11', 18),
    (88, 'Granger', 'Toby', '2014-11-14', 5),
    (89, 'Sharyl', 'Bealing', '1977-03-09', 2),
    (90, 'Si', 'Moxon', '1955-05-24', 4),
    (91, 'Luisa', 'Baildon', '1994-01-13', 4),
    (92, 'Neel', 'Cromarty', '2006-01-15', 19),
    (93, 'Tan', 'Farans', '2008-06-13', 16),
    (94, 'Cammi', 'Fick', '1961-03-21', 10),
    (95, 'Jewelle', 'Kisbey', '2015-11-22', 3),
    (96, 'Rolando', 'Haggis', '1960-04-19', 15),
    (97, 'Ericka', 'Cobbing', '2003-12-02', 5),
    (98, 'Kirbie', 'Baleine', '1997-09-16', 1),
    (99, 'Aime', 'Whittall', '1983-08-07', 20),
    (100, 'Sallyanne', 'Audrey', '1987-12-16', 17);


INSERT INTO Director
    (dir_id,first_name,last_name,DOB,fav_genre,cur_project,admin_id)
values
    (1, 'Lemar', 'Ixer', '1943-09-12', 'Action|Comedy|Horror|Thriller', 'Snakes on a Plane', 4),
    (2, 'Charlotte', 'Carnall', '1990-03-10', 'Documentary', 'ReGeneration', 16),
    (3, 'Wright', 'Gawen', '1948-10-01', 'Documentary', 'Cartoonist: Jeff Smith, BONE and the Changing Face of Comics, The', 3),
    (4, 'Tasha', 'Delve', '1957-11-21', 'Animation|Comedy|Musical', 'Eight Crazy Nights (Adam Sandler''s Eight Crazy Nights)', 13),
    (5, 'Melvin', 'Heliar', '1987-09-16', 'Comedy', 'Blackadder''s Christmas Carol', 16),
    (6, 'Herby', 'Le Surf', '1969-05-05', 'Comedy|Drama', 'Crimes of the Heart', 12),
    (7, 'Cahra', 'Rankling', '1975-03-29', 'Western', 'Navajo Joe', 7),
    (8, 'Broddie', 'Dimitrie', '1947-04-03', 'Comedy', 'Fly Away (Bis zum Horizont, dann links!)', 2),
    (9, 'Nicola', 'Faulkener', '1999-01-21', 'Documentary', 'Kimjongilia', 9),
    (10, 'Nestor', 'MacSkeagan', '1959-12-27', 'Drama', 'Unvanquished, The (Aparajito)', 4),
    (11, 'Abel', 'Strettell', '1958-08-05', 'Comedy', 'Love Punch, The', 9),
    (12, 'Jdavie', 'Elacoate', '1968-05-09', 'Crime|Drama|Thriller', 'Bordertown', 16),
    (13, 'Jenna', 'Layhe', '1979-03-18', 'Comedy|Romance', 'Exit Smiling', 11),
    (14, 'Nicolette', 'Ridulfo', '1988-05-20', 'Comedy|Romance', 'Prince & Me II: The Royal Wedding, The', 9),
    (15, 'Levin', 'Costelloe', '1951-08-07', 'Action|Sci-Fi|Thriller', 'Virtuosity', 5),
    (16, 'Ximenes', 'Medford', '1940-01-28', 'Drama', 'Hideous Kinky', 16),
    (17, 'Agnese', 'Studders', '1962-08-13', 'Horror', 'Luther the Geek', 6),
    (18, 'Skipton', 'Eckley', '1947-09-22', 'Action|Crime|Drama|Horror|Thriller', 'Possessed (Besat)', 4),
    (19, 'Britt', 'Blaszczynski', '1983-03-16', 'Action', 'Desert Heat (Inferno)', 17),
    (20, 'Quinton', 'Payton', '1945-09-23', 'Comedy', 'Iron Ladies, The (Satree lek)', 15),
    (21, 'Aloin', 'Keoghan', '1982-10-18', 'Animation', 'Mail Early for Xmas', 20),
    (22, 'Ileana', 'Tschersich', '1993-10-11', 'Documentary', 'Valentine Road', 19),
    (23, 'Rogers', 'Hebbard', '1958-07-15', 'Animation|War', 'When the Wind Blows', 9),
    (24, 'Chelsie', 'Haughian', '1979-04-08', 'Drama', 'Foxfire', 2),
    (25, 'Allyn', 'Siddon', '1986-07-05', 'Action|Crime|Sci-Fi|IMAX', 'RoboCop', 5),
    (26, 'Enoch', 'Lace', '1970-12-27', 'Adventure|Drama|Fantasy|Romance|IMAX', 'Twilight Saga: Breaking Dawn - Part 2, The', 15),
    (27, 'Chaunce', 'Parramore', '1971-02-11', 'Adventure|Children|Comedy', 'Around the World in 80 Days', 2),
    (28, 'Hewitt', 'Bummfrey', '1979-04-09', 'Comedy', 'The Fuller Brush Girl', 18),
    (29, 'Keefer', 'Pleasance', '1988-12-17', 'Drama|Mystery|Sci-Fi', 'Stalker', 2),
    (30, 'Sanderson', 'Anglim', '1974-12-02', 'Action|Sci-Fi', 'Godzilla vs. Megalon (Gojira tai Megaro)', 19),
    (31, 'Lidia', 'Connell', '1960-03-25', 'Action|Comedy', 'Man of the House', 18),
    (32, 'Rachele', 'Hurford', '1959-07-14', 'Documentary|Musical', 'Young at Heart (a.k.a. Young@Heart)', 2),
    (33, 'Starla', 'Plumridge', '1960-04-22', 'Drama', 'Pumpkin Eater, The', 16),
    (34, 'Britte', 'Gussin', '1954-03-05', 'Action|Crime|Drama|Mystery|Thriller', 'Double, The', 20),
    (35, 'Winna', 'Winspurr', '1946-06-25', 'Drama', 'Felicity', 13),
    (36, 'Shelby', 'Gwyn', '1981-04-19', 'Action|Sci-Fi', 'Space Amoeba (Yog: Monster from Space)', 17),
    (37, 'Isis', 'Raubenheim', '1980-10-11', 'Western', 'American Bandits: Frank and Jesse James', 10),
    (38, 'Tera', 'Sego', '1950-03-25', 'Action|Adventure|Sci-Fi', 'Hulk', 3),
    (39, 'Leonanie', 'Edgars', '1958-07-04', 'Documentary', 'Home Movie', 11),
    (40, 'Cary', 'Collough', '1983-08-07', 'Mystery', 'The Sign of Four: Sherlock Holmes'' Greatest Case', 1);



INSERT INTO Project
    (p_id, title, type, cast, country, genre, status, duration, dir_id, proj_release_date)
values
    (1, 'U.S. Marshals', 'Movie', 159, 'Nicaragua', 'Action|Crime|Thriller', false, 432, 7, '2023-08-08'),
    (2, 'Eternal Sunshine of the Spotless Mind', 'Movie', 175, 'Poland', 'Drama|Romance|Sci-Fi', false, 255, 28, '2024-11-25'),
    (3, 'Ernest Goes to Jail', 'Movie', 185, 'Mongolia', 'Comedy', false, 142, 39, '2023-05-18'),
    (4, 'The Chatterley Affair', 'TV Show', 94, 'China', 'Drama|Romance', false, 391, 28, '2025-07-01'),
    (5, 'Outsiders (Ceddo)', 'Movie', 62, 'Bangladesh', 'Drama', false, 184, 20, '2023-09-23'),
    (6, 'Snows of Kilimanjaro, The', 'Movie', 95, 'Poland', 'Adventure', false, 308, 25, '2023-02-28'),
    (7, 'Backtrack (Catchfire)', 'TV Show', 85, 'Senegal', 'Action|Drama|Thriller', true, 281, 34, '2023-10-25'),
    (8, 'Future, The', 'Movie', 186, 'Ireland', 'Drama', false, 186, 37, '2025-05-12'),
    (9, 'The Miracle of Our Lady of Fatima', 'TV Show', 112, 'China', 'Drama', true, 223, 13, '2024-07-06'),
    (10, 'ATF ', 'TV Show', 148, 'Kosovo', 'Drama|Thriller', false, 214, 15, '2023-12-01'),
    (11, 'American Winter', 'Movie', 87, 'Indonesia', 'Documentary|Drama', false, 464, 17, '2025-07-21'),
    (12, 'Fun with Dick and Jane', 'Movie', 67, 'Sweden', 'Comedy', true, 319, 27, '2023-12-08'),
    (13, 'Slams, The', 'TV Show', 53, 'Ukraine', 'Action|Drama', false, 226, 27, '2023-01-06'),
    (14, 'Immortel (ad vitam) (Immortal)', 'Movie', 164, 'Poland', 'Action|Adventure|Animation|Fantasy|Sci-Fi', true, 250, 6, '2025-06-08'),
    (15, 'Happy Campers', 'Movie', 134, 'Pakistan', 'Comedy', false, 178, 9, '2025-11-10'),
    (16, 'My Way', 'TV Show', 56, 'Myanmar', 'Drama', false, 173, 40, '2023-05-21'),
    (17, 'Guru', 'Movie', 147, 'China', 'Drama|Romance', false, 199, 17, '2023-08-07'),
    (18, 'Carnosaur 2', 'TV Show', 141, 'China', 'Horror|Sci-Fi', false, 307, 7, '2024-10-15'),
    (19, 'King and the Mockingbird, The (Le roi et l''oiseau)', 'TV Show', 104, 'Portugal', 'Animation|Children|Fantasy', true, 429, 32, '2024-05-30'),
    (20, 'Dolphin Tale 2', 'TV Show', 21, 'Luxembourg', 'Children|Drama', false, 270, 31, '2024-12-03'),
    (21, 'Her Alibi', 'Movie', 76, 'Thailand', 'Comedy|Romance', true, 442, 31, '2023-03-06'),
    (22, 'Four Lions', 'TV Show', 178, 'China', 'Comedy|Drama', false, 428, 20, '2025-06-20'),
    (23, 'Secret Window', 'Movie', 186, 'Czech Republic', 'Mystery|Thriller', true, 170, 18, '2024-02-21'),
    (24, 'Hey Ram', 'TV Show', 200, 'Guatemala', 'Drama', true, 438, 33, '2025-08-02'),
    (25, 'Masterminds', 'Movie', 175, 'Russia', 'Action|Comedy|Thriller', true, 157, 3, '2024-06-17'),
    (26, 'Incident at Oglala', 'TV Show', 189, 'China', 'Documentary', true, 151, 3, '2025-10-17'),
    (27, 'Cheap Thrills', 'Movie', 35, 'United States', 'Comedy|Thriller', false, 383, 36, '2024-07-15'),
    (28, 'Mad Love (Juana la Loca)', 'TV Show', 198, 'Indonesia', 'Drama', true, 150, 24, '2025-01-11'),
    (29, 'Cosmopolis', 'Movie', 98, 'Slovenia', 'Drama', false, 204, 20, '2025-04-01'),
    (30, 'Changing Lanes', 'TV Show', 151, 'Cameroon', 'Drama|Thriller', true, 497, 30, '2024-05-15'),
    (31, 'That Old Feeling', 'TV Show', 46, 'Iran', 'Comedy|Romance', false, 489, 36, '2023-11-04'),
    (32, 'Woodsman, The', 'TV Show', 188, 'Iran', 'Drama', true, 388, 8, '2023-07-22'),
    (33, 'Mostly Martha (Bella Martha)', 'TV Show', 68, 'Russia', 'Comedy|Drama|Romance', true, 392, 31, '2024-03-05'),
    (34, 'Last Holiday', 'Movie', 161, 'Brazil', 'Comedy', true, 226, 5, '2023-10-26'),
    (35, 'Mother Küsters Goes to Heaven (Mutter Küsters'' Fahrt zum Himmel)', 'TV Show', 89, 'Thailand', 'Drama', false, 364, 20, '2023-12-17'),
    (36, 'Mascara', 'TV Show', 73, 'China', 'Drama', true, 496, 25, '2024-09-12'),
    (37, 'Charlie''s Angels', 'TV Show', 100, 'Japan', 'Action|Comedy', true, 427, 12, '2024-11-28'),
    (38, 'John Huston: The Man, the Movies, the Maverick', 'TV Show', 133, 'United States', 'Documentary', false, 354, 20, '2024-06-24'),
    (39, 'Casualties of War', 'Movie', 122, 'Thailand', 'Drama|War', true, 167, 5, '2024-10-03'),
    (40, 'Handle with Care (a.k.a. Citizen''s Band)', 'Movie', 176, 'Greece', 'Comedy', false, 350, 32, '2023-05-05'),
    (41, 'Listen to Your Heart', 'TV Show', 130, 'Mauritania', 'Drama|Musical|Romance', true, 307, 32, '2024-08-13'),
    (42, 'Chasing Liberty', 'Movie', 71, 'Indonesia', 'Comedy|Romance', false, 141, 33, '2023-06-18'),
    (43, 'Bird of Prey', 'TV Show', 33, 'Panama', 'Action', true, 194, 12, '2023-08-25'),
    (44, 'I Am Jesus', 'Movie', 175, 'Russia', 'Documentary', true, 421, 35, '2023-08-14'),
    (45, 'Soccer Days', 'TV Show', 108, 'Ukraine', 'Comedy', false, 280, 13, '2024-11-11'),
    (46, 'Timeline', 'TV Show', 77, 'Norway', 'Action|Adventure|Sci-Fi', true, 283, 8, '2024-01-22'),
    (47, 'FC Venus', 'Movie', 41, 'Japan', 'Comedy|Romance', true, 318, 26, '2024-06-27'),
    (48, 'Light Sleeper', 'Movie', 182, 'Cameroon', 'Crime|Drama', true, 405, 17, '2024-03-13'),
    (49, 'Regeneration', 'TV Show', 120, 'Brazil', 'Drama|War', true, 196, 5, '2025-12-02'),
    (50, 'All Fall Down', 'Movie', 173, 'Russia', 'Drama', true, 287, 15, '2024-11-02'),
    (51, 'Bishop Murder Case, The', 'Movie', 42, 'Portugal', 'Mystery', false, 415, 18, '2023-09-20'),
    (52, 'Boys Don''t Cry (Chlopaki nie placza)', 'TV Show', 120, 'Botswana', 'Comedy', true, 150, 12, '2023-06-09'),
    (53, 'Larks on a String (Skrivánci na niti)', 'Movie', 128, 'Philippines', 'Comedy|Drama|Romance', false, 277, 10, '2025-02-05'),
    (54, 'Nora', 'Movie', 39, 'Brazil', 'Drama', true, 237, 7, '2025-02-28'),
    (55, 'Death in the Garden (Mort en ce jardin, La)', 'TV Show', 92, 'Norway', 'Drama', false, 292, 31, '2024-12-08'),
    (56, 'White Nights', 'Movie', 192, 'Indonesia', 'Drama', false, 325, 18, '2024-07-20'),
    (57, 'Bring It On: Fight to the Finish', 'Movie', 155, 'Ethiopia', 'Comedy', false, 386, 10, '2025-12-04'),
    (58, 'Yertle the Turtle and Other Stories', 'TV Show', 120, 'Czech Republic', 'Animation|Children', false, 130, 12, '2025-01-23'),
    (59, 'Dreamlife of Angels, The (Vie rêvée des anges, La)', 'TV Show', 41, 'South Africa', 'Drama', false, 210, 2, '2024-09-30'),
    (60, 'Film ist. 7-12', 'Movie', 89, 'Bolivia', 'Documentary', true, 176, 36, '2024-01-29'),
    (61, 'Hitler''s Madman', 'TV Show', 44, 'Cameroon', 'Drama|War', true, 212, 23, '2025-05-26'),
    (62, 'Young Goethe in Love', 'TV Show', 37, 'Colombia', 'Drama|Romance', false, 478, 24, '2025-12-13'),
    (63, 'Pekka ja Pätkä Suezilla', 'TV Show', 189, 'Poland', 'Comedy', true, 182, 21, '2024-07-06'),
    (64, 'Turtle''s Tale 2: Sammy''s Escape from Paradise, A (Sammy''s avonturen 2) (Sammy''s Adventures 2)', 'Movie', 154, 'China', 'Adventure|Animation|Children', true, 278, 9, '2025-03-22'),
    (65, 'The Cat''s Out', 'Movie', 39, 'Mexico', 'Animation', true, 201, 36, '2025-10-13'),
    (66, 'Sound of Insects, The', 'Movie', 107, 'Indonesia', 'Adventure|Documentary|Drama|Mystery|Thriller', true, 438, 15, '2024-06-05'),
    (67, 'Warsaw Bridge (Pont de Varsòvia)', 'Movie', 24, 'United Kingdom', '(no genres listed)', true, 230, 10, '2024-12-02'),
    (68, 'Land Girls, The', 'TV Show', 133, 'Brazil', 'Drama|War', false, 429, 4, '2025-01-04'),
    (69, 'Forget Baghdad: Jews and Arabs - The Iraqi Connection', 'Movie', 96, 'France', 'Documentary', false, 397, 38, '2024-06-29'),
    (70, 'When Jews Were Funny', 'TV Show', 152, 'China', 'Documentary', false, 182, 36, '2023-04-16'),
    (71, 'Craig''s Wife', 'TV Show', 26, 'China', 'Drama', true, 276, 31, '2024-07-30'),
    (72, '700 Sundays', 'Movie', 30, 'China', 'Comedy', false, 454, 5, '2023-12-23'),
    (73, 'Tunes of Glory', 'Movie', 24, 'China', 'Drama', true, 444, 1, '2025-09-20'),
    (74, 'Once Upon a Time in China II (Wong Fei-hung Ji Yi: Naam yi dong ji keung)', 'TV Show', 162, 'Indonesia', 'Action|Romance', true, 287, 19, '2023-05-08'),
    (75, '7 Plus Seven', 'Movie', 95, 'China', 'Documentary', true, 332, 28, '2025-09-18'),
    (76, 'Fantasia', 'Movie', 59, 'Indonesia', 'Animation|Children|Fantasy|Musical', false, 439, 15, '2024-07-11'),
    (77, 'Violet & Daisy', 'Movie', 102, 'Peru', 'Action|Drama', true, 236, 14, '2024-06-11'),
    (78, 'Rabbit', 'TV Show', 95, 'Thailand', 'Animation|Horror', false, 343, 26, '2025-09-13'),
    (79, 'Kambakkht Ishq (Incredible Love)', 'Movie', 140, 'China', 'Action|Comedy|Musical', true, 110, 23, '2025-01-21'),
    (80, 'Wonderland', 'Movie', 199, 'Netherlands', 'Drama', true, 130, 23, '2025-09-05'),
    (81, 'Inuyasha the Movie: The Castle Beyond the Looking Glass', 'TV Show', 197, 'Russia', 'Action|Animation|Comedy|Romance', true, 132, 9, '2023-08-12'),
    (82, 'Son of the Bride (Hijo de la novia, El)', 'TV Show', 128, 'Russia', 'Comedy|Drama', false, 211, 9, '2023-04-30'),
    (83, 'Sun Don''t Shine', 'Movie', 27, 'China', 'Crime|Drama|Mystery', true, 225, 13, '2023-08-01'),
    (84, 'Electric Dreams', 'Movie', 121, 'China', 'Comedy|Drama|Romance|Sci-Fi', false, 237, 12, '2024-01-18'),
    (85, 'Bullfighter and the Lady', 'Movie', 114, 'United States', 'Action|Drama|Romance', false, 433, 2, '2023-03-07'),
    (86, 'Renaissance Man', 'Movie', 86, 'Russia', 'Comedy|Drama', false, 300, 14, '2024-02-13'),
    (87, 'Jazz Singer, The', 'TV Show', 145, 'Canada', 'Musical', true, 363, 18, '2023-01-19'),
    (88, 'Hanging Garden, The', 'TV Show', 66, 'Yemen', 'Drama|Romance', false, 434, 9, '2023-10-08'),
    (89, 'Asterix in Britain (Astérix chez les Bretons)', 'TV Show', 59, 'Poland', 'Adventure|Animation|Children|Comedy', true, 459, 22, '2024-10-11'),
    (90, 'Beauty #2', 'TV Show', 92, 'United States', 'Drama', true, 343, 5, '2023-09-16'),
    (91, 'Appaloosa', 'Movie', 108, 'Peru', 'Western', false, 433, 24, '2024-08-29'),
    (92, 'Trancers II', 'Movie', 157, 'Russia', 'Action|Sci-Fi', true, 328, 14, '2023-08-02'),
    (93, 'Aashiqui 2', 'TV Show', 31, 'Mali', 'Drama|Musical|Romance', true, 390, 12, '2025-08-04'),
    (94, 'Caught', 'Movie', 179, 'Mexico', 'Drama|Thriller', true, 231, 13, '2023-07-22'),
    (95, 'Velvet Goldmine', 'TV Show', 108, 'South Africa', 'Drama', false, 360, 8, '2023-09-30'),
    (96, 'Jackpot 2', 'TV Show', 195, 'Morocco', 'Sci-Fi', false, 356, 16, '2023-05-28'),
    (97, 'Of Snails and Men (Despre oameni si melci)', 'TV Show', 143, 'Denmark', 'Comedy', false, 500, 31, '2023-03-24'),
    (98, 'Back in the Day', 'TV Show', 177, 'Canada', 'Comedy', true, 218, 33, '2023-04-05'),
    (99, '9 Star Hotel (Malon 9 Kochavim)', 'Movie', 182, 'Serbia', 'Documentary', true, 359, 30, '2025-05-07'),
    (100, 'Lady Killer', 'TV Show', 111, 'Philippines', 'Drama|Romance|War', false, 489, 30, '2024-11-15');


INSERT INTO Role
    (role_id,projectid,role_type,char_name,description,age_range,gender)
values 
    (1, 70, 'extra', 'Cordie Wroughton', 'strong', '18-25', 'Female'),
    (2, 26, 'extra', 'Garek Butterfield', 'happy', '7-12', 'Male'),
    (3, 35, 'protagonist', 'Adolphe Needs', 'strong', '65+', 'Male'),
    (4, 28, 'extra', 'Vassili Chudleigh', 'proud', '7-12', 'Bigender'),
    (5, 13, 'protagonist', 'Rubia Durrington', 'proud', '30-45', 'Female'),
    (6, 18, 'extra', 'Birk Domb', 'sad', '7-12', 'Male'),
    (7, 22, 'supporting role', 'Chiquita Bromfield', 'depressed', '7-12', 'Female'),
    (8, 38, 'supporting role', 'Consuelo Crighton', 'proud', '18-25', 'Female'),
    (9, 86, 'villian', 'Selle Scoullar', 'sad', '7-12', 'Female'),
    (10, 88, 'villian', 'Paten Towne', 'confident', '30-45', 'Agender'),
    (11, 37, 'supporting role', 'Sib Klementz', 'confident', '65+', 'Female'),
    (12, 99, 'villian', 'Chelsey Mees', 'confident', '7-12', 'Female'),
    (13, 95, 'supporting role', 'Haslett Lamball', 'strong', '18-25', 'Male'),
    (14, 79, 'villian', 'Gay Gueny', 'strong', '7-12', 'Male'),
    (15, 9, 'protagonist', 'Larine Meritt', 'depressed', '30-45', 'Female'),
    (16, 87, 'protagonist', 'Garrik Stairmond', 'strong', '18-25', 'Male'),
    (17, 54, 'supporting role', 'Wynny Heymes', 'happy', '30-45', 'Female'),
    (18, 69, 'protagonist', 'Deedee Tofanelli', 'depressed', '18-25', 'Genderfluid'),
    (19, 16, 'protagonist', 'Viole Rentelll', 'confident', '18-25', 'Female'),
    (20, 93, 'extra', 'Mariellen Cruickshanks', 'depressed', '30-45', 'Female'),
    (21, 22, 'villian', 'Binnie Lowle', 'confident', '7-12', 'Female'),
    (22, 61, 'villian', 'Saudra Blasi', 'sad', '65+', 'Female'),
    (23, 69, 'extra', 'Rabi Dalyiel', 'happy', '18-25', 'Male'),
    (24, 62, 'supporting role', 'Siffre Mayne', 'confident', '65+', 'Male'),
    (25, 19, 'protagonist', 'Helga Ludlom', 'strong', '65+', 'Female'),
    (26, 31, 'protagonist', 'Crawford Gerge', 'strong', '30-45', 'Male'),
    (27, 31, 'supporting role', 'Glenine Bugdell', 'strong', '65+', 'Female'),
    (28, 61, 'protagonist', 'Osborne Yerson', 'depressed', '65+', 'Male'),
    (29, 15, 'supporting role', 'Leah Van der Hoven', 'depressed', '30-45', 'Female'),
    (30, 67, 'villian', 'Garrik Sever', 'sad', '65+', 'Male'),
    (31, 18, 'protagonist', 'Genna Lumox', 'strong', '65+', 'Female'),
    (32, 41, 'villian', 'Tull McVittie', 'strong', '18-25', 'Male'),
    (33, 23, 'supporting role', 'Carleton Prickett', 'happy', '7-12', 'Genderqueer'),
    (34, 14, 'protagonist', 'Eloisa Van Velde', 'strong', '7-12', 'Female'),
    (35, 39, 'villian', 'Fred Liddall', 'confident', '7-12', 'Male'),
    (36, 41, 'supporting role', 'Sylvan Hacker', 'confident', '30-45', 'Agender'),
    (37, 20, 'extra', 'Drew Keir', 'confident', '30-45', 'Male'),
    (38, 80, 'protagonist', 'Cordey Relton', 'strong', '65+', 'Female'),
    (39, 47, 'extra', 'Niles Muncie', 'strong', '18-25', 'Male'),
    (40, 4, 'villian', 'Ladonna Mapham', 'proud', '65+', 'Female'),
    (41, 24, 'protagonist', 'Peder Cloy', 'strong', '7-12', 'Male'),
    (42, 20, 'villian', 'Henri Smaling', 'strong', '18-25', 'Male'),
    (43, 49, 'protagonist', 'Marin Sergeant', 'sad', '30-45', 'Female'),
    (44, 22, 'extra', 'Gunter Pracy', 'sad', '18-25', 'Male'),
    (45, 42, 'supporting role', 'Kendrick Danne', 'proud', '18-25', 'Male'),
    (46, 91, 'villian', 'Farr Hallex', 'sad', '7-12', 'Male'),
    (47, 94, 'protagonist', 'Benny Usmar', 'strong', '7-12', 'Female'),
    (48, 72, 'villian', 'Lindy Herreran', 'sad', '7-12', 'Female'),
    (49, 21, 'extra', 'Giffer Ewens', 'depressed', '7-12', 'Male'),
    (50, 34, 'protagonist', 'Ashia Marston', 'confident', '65+', 'Female'),
    (51, 84, 'protagonist', 'Borden Erwin', 'proud', '18-25', 'Male'),
    (52, 47, 'protagonist', 'Dorella Petrak', 'confident', '30-45', 'Female'),
    (53, 24, 'supporting role', 'Lorrie Lubeck', 'strong', '65+', 'Female'),
    (54, 70, 'extra', 'Reece Marshallsay', 'proud', '30-45', 'Male'),
    (55, 6, 'villian', 'Dory Mollene', 'happy', '18-25', 'Female'),
    (56, 40, 'protagonist', 'Pennie Keerl', 'strong', '30-45', 'Male'),
    (57, 18, 'supporting role', 'Mortie Oluwatoyin', 'sad', '65+', 'Male'),
    (58, 99, 'extra', 'Emlen Scrowston', 'strong', '30-45', 'Male'),
    (59, 88, 'villian', 'Rosene Gingles', 'strong', '7-12', 'Female'),
    (60, 48, 'villian', 'Jim Chasemore', 'happy', '18-25', 'Male'),
    (61, 69, 'protagonist', 'Keely Plumtree', 'depressed', '7-12', 'Polygender'),
    (62, 93, 'protagonist', 'Griffith McGaughie', 'proud', '30-45', 'Male'),
    (63, 79, 'protagonist', 'Mallissa Pavier', 'sad', '18-25', 'Genderfluid'),
    (64, 65, 'villian', 'Parsifal Skyrme', 'happy', '7-12', 'Male'),
    (65, 33, 'protagonist', 'Annamaria Telfer', 'depressed', '65+', 'Female'),
    (66, 78, 'supporting role', 'Trisha Cantu', 'happy', '30-45', 'Female'),
    (67, 21, 'supporting role', 'Earle Spinley', 'strong', '65+', 'Male'),
    (68, 59, 'extra', 'Allis Gornar', 'proud', '7-12', 'Female'),
    (69, 4, 'villian', 'Daisi Switsur', 'happy', '7-12', 'Female'),
    (70, 6, 'supporting role', 'Anya Lytle', 'depressed', '30-45', 'Female'),
    (71, 52, 'supporting role', 'Portie Niaves', 'strong', '30-45', 'Male'),
    (72, 23, 'villian', 'Solly Petrak', 'depressed', '65+', 'Male'),
    (73, 26, 'protagonist', 'Von Oakshott', 'depressed', '18-25', 'Male'),
    (74, 76, 'supporting role', 'Bowie Martt', 'proud', '30-45', 'Male'),
    (75, 61, 'protagonist', 'Alfreda Attoc', 'confident', '30-45', 'Female');

INSERT INTO Reviews
    (description,rating,actor_id,dir_id)
values
    ('Useful', 3, 10, 1),
    ('Solid', 2, 58, 40),
    ('Tried their best', 5, 86, 32),
    ('Tried their best', 1, 93, 18),
    ('Tried their best', 4, 43, 38),
    ('Tried their best', 5, 12, 12),
    ('Useful', 5, 39, 19),
    ('Hardworker', 2, 16, 4),
    ('Solid', 3, 7, 28),
    ('Hardworker', 1, 73, 38),
    ('Solid', 5, 73, 29),
    ('Solid', 4, 7, 20),
    ('Solid', 2, 71, 27),
    ('Helpful', 2, 96, 5),
    ('Helpful', 4, 34, 7),
    ('Helpful', 2, 25, 4),
    ('Useful', 4, 70, 40),
    ('Hardworker', 5, 60, 24),
    ('Useful', 4, 82, 30),
    ('Useful', 4, 99, 11),
    ('Tried their best', 5, 56, 24),
    ('Tried their best', 5, 93, 6),
    ('Helpful', 3, 42, 25),
    ('Tried their best', 4, 97, 13),
    ('Solid', 2, 11, 8),
    ('Useful', 4, 58, 5),
    ('Useful', 2, 64, 18),
    ('Solid', 5, 9, 9),
    ('Tried their best', 2, 29, 12),
    ('Tried their best', 1, 14, 19),
    ('Helpful', 4, 73, 21),
    ('Hardworker', 1, 59, 35),
    ('Helpful', 4, 25, 19),
    ('Helpful', 4, 44, 34),
    ('Hardworker', 2, 3, 29),
    ('Tried their best', 5, 38, 20),
    ('Solid', 2, 85, 1),
    ('Helpful', 4, 36, 26),
    ('Helpful', 2, 35, 4),
    ('Helpful', 4, 59, 22),
    ('Hardworker', 1, 95, 40),
    ('Useful', 1, 51, 30),
    ('Hardworker', 4, 41, 28),
    ('Useful', 1, 16, 3),
    ('Hardworker', 3, 69, 28),
    ('Helpful', 2, 59, 33),
    ('Solid', 1, 15, 10),
    ('Useful', 3, 69, 26),
    ('Helpful', 5, 70, 12),
    ('Useful', 4, 89, 13),
    ('Solid', 3, 82, 22),
    ('Solid', 3, 76, 3),
    ('Hardworker', 1, 54, 33),
    ('Useful', 2, 32, 9),
    ('Helpful', 1, 83, 28),
    ('Hardworker', 4, 85, 33),
    ('Solid', 2, 14, 39),
    ('Solid', 2, 85, 32),
    ('Hardworker', 5, 72, 28),
    ('Hardworker', 2, 64, 11),
    ('Useful', 5, 66, 28),
    ('Hardworker', 4, 92, 29),
    ('Solid', 3, 32, 22),
    ('Hardworker', 1, 38, 18),
    ('Solid', 3, 14, 13),
    ('Helpful', 2, 76, 8),
    ('Solid', 1, 51, 38),
    ('Solid', 5, 16, 25),
    ('Helpful', 1, 16, 28),
    ('Helpful', 1, 71, 23),
    ('Solid', 4, 16, 16),
    ('Tried their best', 3, 29, 7),
    ('Hardworker', 5, 89, 30),
    ('Helpful', 1, 65, 23),
    ('Useful', 2, 71, 12),
    ('Helpful', 4, 33, 11),
    ('Tried their best', 2, 73, 20),
    ('Useful', 2, 89, 12),
    ('Solid', 4, 91, 21),
    ('Tried their best', 4, 90, 9),
    ('Helpful', 4, 47, 1),
    ('Tried their best', 4, 65, 33),
    ('Hardworker', 4, 1, 13),
    ('Solid', 3, 46, 3),
    ('Hardworker', 3, 53, 38),
    ('Solid', 3, 75, 14),
    ('Solid', 2, 44, 21),
    ('Tried their best', 2, 54, 10),
    ('Hardworker', 4, 77, 28),
    ('Hardworker', 1, 100, 2),
    ('Tried their best', 1, 49, 35),
    ('Solid', 5, 90, 11),
    ('Solid', 4, 73, 16),
    ('Useful', 5, 91, 31),
    ('Helpful', 4, 4, 4),
    ('Hardworker', 1, 94, 14),
    ('Useful', 4, 83, 39),
    ('Hardworker', 2, 28, 7),
    ('Hardworker', 1, 17, 20),
    ('Helpful', 5, 35, 25);

-- INSERT INTO Application
--     (projectid, role_id, actor_id, resume, status, submit_time)
-- values
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (76, 3, 5, 'EgetElit.mp3', false, '2022-04-15 05:40:55');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (19, 17, 95, 'Posuere.tiff', true, '2022-06-12 11:05:17');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (87, 50, 7, 'SuspendissePotenti.avi', false, '2022-03-13 13:02:44');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (94, 38, 57, 'Sit.pdf', true, '2022-04-03 09:04:45');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (79, 67, 38, 'Quis.pdf', false, '2022-03-20 02:47:08');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (29, 20, 51, 'Non.jpeg', true, '2022-10-07 04:12:27');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (3, 52, 71, 'FusceConsequatNulla.tiff', true, '2022-08-19 09:18:32');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (81, 68, 16, 'PellentesqueEgetNunc.xls', true, '2022-11-26 11:20:13');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (11, 64, 40, 'LuctusEt.ppt', true, '2022-01-03 06:04:08');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (81, 69, 16, 'PretiumIaculisDiam.txt', true, '2022-03-21 02:29:31');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (7, 33, 29, 'OrciVehiculaCondimentum.mp3', true, '2022-09-23 08:12:51');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (55, 42, 60, 'Id.jpeg', false, '2022-08-27 02:40:49');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (3, 21, 69, 'SociisNatoque.jpeg', false, '2021-12-10 18:58:57');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (1, 21, 92, 'UtMaurisEget.ppt', false, '2022-12-06 01:46:52');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (87, 30, 81, 'AccumsanOdioCurabitur.avi', false, '2022-07-05 14:25:58');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (41, 40, 75, 'TellusNulla.xls', false, '2022-07-11 07:10:27');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (83, 2, 1, 'CommodoVulputateJusto.xls', true, '2022-04-04 22:28:20');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (30, 22, 49, 'VulputateLuctusCum.txt', false, '2022-05-25 00:21:31');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (34, 74, 3, 'NullaSed.pdf', true, '2022-08-01 16:22:09');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (72, 9, 97, 'TortorDuisMattis.mp3', true, '2022-04-27 15:53:43');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (28, 70, 41, 'Ultrices.xls', true, '2022-08-08 07:19:43');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (2, 14, 84, 'Posuere.mp3', true, '2022-01-11 08:22:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (17, 28, 96, 'CubiliaCuraeDonec.tiff', true, '2022-11-06 21:16:44');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (5, 10, 4, 'LuctusEtUltrices.xls', false, '2022-06-25 08:07:36');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (57, 37, 66, 'EstLaciniaNisi.ppt', true, '2022-04-22 06:08:43');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (91, 9, 37, 'TristiqueInTempus.jpeg', false, '2022-09-04 14:57:16');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (57, 16, 74, 'JustoInHac.png', false, '2022-10-14 22:49:52');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (97, 66, 80, 'QuamA.xls', true, '2022-10-25 02:47:24');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (21, 50, 32, 'InQuamFringilla.tiff', false, '2022-01-04 04:54:11');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (19, 14, 33, 'Nulla.avi', false, '2022-02-15 13:03:45');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (63, 13, 86, 'LiberoUt.gif', true, '2022-10-29 02:46:25');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (92, 45, 56, 'SodalesSed.png', false, '2022-10-02 13:19:16');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (18, 30, 31, 'Dis.ppt', false, '2022-10-29 23:30:13');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (98, 19, 13, 'MaurisLaciniaSapien.avi', false, '2022-10-12 02:25:55');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (15, 18, 36, 'SedVestibulum.xls', false, '2022-09-23 20:58:19');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (61, 33, 93, 'A.ppt', true, '2022-11-28 05:15:35');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (70, 15, 75, 'Non.ppt', true, '2022-10-31 11:41:21');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (40, 44, 68, 'InPurusEu.xls', true, '2022-10-10 05:48:33');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (93, 11, 99, 'Tortor.mp3', true, '2022-01-25 05:26:31');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (3, 67, 15, 'CursusVestibulum.mp3', true, '2022-07-06 04:36:10');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (72, 11, 66, 'Integer.gif', false, '2022-10-29 06:12:25');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (68, 36, 39, 'Justo.avi', false, '2022-09-20 10:42:59');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (89, 13, 37, 'Eu.avi', true, '2022-11-15 14:32:50');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (32, 49, 19, 'SedAnte.ppt', true, '2022-12-07 07:54:54');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (38, 45, 7, 'IpsumAcTellus.mp3', false, '2022-04-25 21:45:12');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (93, 20, 55, 'CommodoVulputate.xls', true, '2022-01-14 20:37:51');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (38, 47, 28, 'SitAmet.ppt', true, '2022-01-22 11:41:17');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (72, 52, 91, 'Orci.xls', true, '2022-07-15 23:09:34');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (78, 62, 80, 'TemporTurpisNec.xls', true, '2022-05-16 06:21:14');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (38, 19, 75, 'Velit.ppt', true, '2022-07-07 13:18:12');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (39, 56, 84, 'Congue.ppt', false, '2022-09-17 01:35:06');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (38, 33, 91, 'MassaId.pdf', false, '2021-12-26 11:55:20');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (24, 56, 82, 'At.xls', true, '2022-10-30 22:47:23');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (75, 67, 3, 'Facilisi.mp3', false, '2022-06-08 13:15:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (6, 52, 99, 'LuctusCum.jpeg', true, '2022-11-10 21:03:11');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (6, 46, 5, 'Orci.jpeg', true, '2022-08-14 14:18:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (33, 25, 50, 'CongueEtiam.avi', true, '2021-12-12 23:27:09');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (10, 13, 78, 'MassaId.mov', true, '2022-06-17 00:52:27');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (32, 20, 63, 'DolorSitAmet.tiff', true, '2022-07-10 04:03:12');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (22, 21, 85, 'PedePosuereNonummy.mp3', false, '2022-02-19 21:08:04');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (69, 21, 20, 'SuspendissePotentiNullam.ppt', true, '2022-03-05 02:05:57');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (54, 18, 19, 'VelSemSed.mp3', true, '2022-11-16 16:38:05');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (31, 20, 79, 'EratCurabiturGravida.xls', true, '2022-07-22 06:34:24');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (59, 7, 39, 'EstPhasellus.mp3', true, '2021-12-29 07:04:42');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (46, 13, 62, 'OrnareImperdietSapien.xls', true, '2022-07-03 19:17:07');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (52, 12, 75, 'Tortor.jpeg', true, '2022-02-15 12:00:07');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (35, 61, 43, 'Justo.mpeg', false, '2022-02-20 17:14:05');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (64, 29, 16, 'Ut.avi', false, '2022-01-10 02:28:16');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (36, 25, 86, 'NullaFacilisi.ppt', false, '2022-08-19 08:15:54');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (67, 50, 63, 'Nunc.mp3', false, '2022-01-07 15:08:46');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (94, 31, 11, 'NullaAc.mpeg', true, '2022-11-30 06:43:36');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (29, 24, 85, 'Dapibus.doc', false, '2022-06-28 02:58:25');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (95, 17, 47, 'VitaeNisl.gif', false, '2022-07-23 12:30:57');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (61, 67, 69, 'Venenatis.gif', false, '2022-08-12 11:21:18');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (33, 36, 23, 'Pellentesque.ppt', false, '2022-09-15 18:11:38');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (45, 34, 28, 'PrimisIn.ppt', false, '2022-05-23 20:31:25');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (80, 70, 70, 'LacusMorbi.xls', true, '2022-02-15 17:23:04');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (84, 9, 62, 'Vestibulum.txt', true, '2021-12-19 13:57:43');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (28, 52, 32, 'InAnte.xls', false, '2022-10-04 06:00:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (6, 7, 27, 'LaciniaSapien.jpeg', false, '2022-07-29 00:57:30');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (80, 7, 5, 'IdOrnareImperdiet.mp3', false, '2022-11-09 11:40:03');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (24, 38, 85, 'Suscipit.tiff', false, '2022-07-30 12:37:55');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (23, 40, 12, 'QuamPharetra.xls', true, '2022-04-29 10:22:12');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (92, 65, 97, 'AmetEros.xls', true, '2022-05-31 06:25:27');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (41, 2, 74, 'Leo.mp3', false, '2022-05-04 16:42:14');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (7, 21, 82, 'Ornare.doc', true, '2021-12-22 04:18:06');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (35, 14, 29, 'At.ppt', false, '2022-02-25 15:17:53');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (32, 62, 21, 'In.avi', true, '2022-05-13 04:20:07');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (57, 62, 7, 'Ultrices.avi', false, '2022-11-18 12:07:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (96, 53, 4, 'VestibulumQuam.avi', true, '2022-05-17 12:39:29');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (50, 42, 58, 'LigulaSitAmet.xls', true, '2022-10-31 07:29:22');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (11, 26, 82, 'QuamSuspendisse.jpeg', true, '2022-09-24 00:59:44');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (74, 23, 47, 'TurpisAPede.avi', true, '2022-01-22 21:26:48');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (27, 31, 14, 'SemFusceConsequat.mov', true, '2022-10-31 05:52:47');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (68, 33, 7, 'LuctusUltricies.pdf', true, '2022-07-17 05:00:05');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (52, 60, 21, 'MattisOdioDonec.xls', true, '2022-01-23 14:03:08');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (59, 21, 82, 'SagittisDui.xls', true, '2022-03-14 19:07:02');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (87, 68, 16, 'JustoMaecenas.avi', false, '2022-08-15 00:01:06');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (16, 56, 47, 'ParturientMontes.tiff', true, '2022-09-03 06:30:40');
insert into Application (projectid, role_id, actor_id, resume, status, submit_time) values (56, 65, 99, 'NonLigula.jpeg', false, '2022-05-02 15:06:11');