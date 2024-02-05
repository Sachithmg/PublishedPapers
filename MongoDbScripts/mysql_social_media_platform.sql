SELECT 'Check for DB exist, if so, drop the database' AS 'Promot for stage';
DROP DATABASE IF EXISTS social_media_platform_dts2113;

SELECT 'Create database \'social_media_platform_dts2113\'' AS 'Promot for stage';
CREATE DATABASE social_media_platform_dts2113; 

USE social_media_platform_dts2113;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

SELECT 'Create table locations' AS 'Promot for stage';
CREATE TABLE locations (
  locationID INT NOT NULL AUTO_INCREMENT, 
  city VARCHAR(50) NOT NULL, 
  state VARCHAR(50) NOT NULL, 
  country VARCHAR(50) NOT NULL,
  PRIMARY KEY (locationID)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert records into locations table' AS 'Promot for stage';
INSERT INTO locations (city, state, country) VALUES ('Kandy', 'Central Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Colombo', 'Western Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Galle', 'Southern Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Nuwara Eliya', 'Central Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Trincomalee', 'Eastern Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Anuradhapura', 'North Central Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Jaffna', 'Northern Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Bentota', 'Southern Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Dambulla', 'Central Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Hikkaduwa', 'Southern Province', 'Sri Lanka');
INSERT INTO locations (city, state, country) VALUES ('Gampaha', 'Western Province', 'Sri Lanka');


SELECT 'Out locations table' AS 'Promot for stage';
SELECT * FROM LOCATIONS;

SELECT 'Create users table' AS 'Promot for stage';
CREATE TABLE users (
  userID INT NOT NULL AUTO_INCREMENT, 
  first_name VARCHAR(50) NOT NULL, 
  middle_name VARCHAR(50) DEFAULT NULL, 
  last_name VARCHAR(100) NOT NULL, 
  email VARCHAR(50) NOT NULL, 
  dob DATE NOT NULL, 
  gender CHAR(1) NOT NULL, 
  password VARCHAR(50) NOT NULL, 
  home_town_locationID INTEGER(11) NOT NULL, 
  lives_locationID INTEGER(11) NOT NULL, 
  PRIMARY KEY (userID),
  UNIQUE (email),
  KEY FK_home_town_location (home_town_locationID),
  KEY FK_lives_location (lives_locationID),
  CONSTRAINT FK_home_town_location FOREIGN KEY (home_town_locationID) REFERENCES locations (locationID) ON DELETE RESTRICT ON UPDATE CASCADE, 
  CONSTRAINT FK_lives_location FOREIGN KEY (lives_locationID) REFERENCES locations (locationID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert 10 records users table, location table is refered to pick location ID based on City' AS 'Promot for stage';
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('John', 'A.', 'Doe', 'johndoe@socialmedia.com', '2000-05-15', 'M', 'password1', (SELECT locationID FROM locations WHERE city = 'Kandy'), (SELECT locationID FROM locations WHERE city = 'Colombo'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Jane', NULL, 'Smith', 'janesmith@socialmedia.com', '1988-09-21', 'F', 'password2', (SELECT locationID FROM locations WHERE city = 'Colombo'), (SELECT locationID FROM locations WHERE city = 'Kandy'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('David', 'C.', 'Johnson', 'davidjohnson@socialmedia.com', '1992-02-08', 'M', 'password3', (SELECT locationID FROM locations WHERE city = 'Galle'), (SELECT locationID FROM locations WHERE city = 'Galle'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Sarah', 'E.', 'Wilson', 'sarahwilson@socialmedia.com', '1995-11-30', 'F', 'password4', (SELECT locationID FROM locations WHERE city = 'Nuwara Eliya'), (SELECT locationID FROM locations WHERE city = 'Nuwara Eliya'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Michael', 'R.', 'Brown', 'michaelbrown@socialmedia.com', '1987-07-18', 'M', 'password5', (SELECT locationID FROM locations WHERE city = 'Trincomalee'), (SELECT locationID FROM locations WHERE city = 'Anuradhapura'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Emily', 'M.', 'Taylor', 'emilytaylor@socialmedia.com', '1991-04-03', 'F', 'password6', (SELECT locationID FROM locations WHERE city = 'Jaffna'), (SELECT locationID FROM locations WHERE city = 'Bentota'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Daniel', 'J.', 'Anderson', 'danielanderson@socialmedia.com', '1989-12-12', 'M', 'password7', (SELECT locationID FROM locations WHERE city = 'Bentota'), (SELECT locationID FROM locations WHERE city = 'Jaffna'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Olivia', 'K.', 'Miller', 'oliviamiller@socialmedia.com', '1993-06-25', 'F', 'password8', (SELECT locationID FROM locations WHERE city = 'Dambulla'), (SELECT locationID FROM locations WHERE city = 'Dambulla'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Thomas', 'L.', 'Davis', 'thomasdavis@socialmedia.com', '1994-09-10', 'M', 'password9', (SELECT locationID FROM locations WHERE city = 'Colombo'), (SELECT locationID FROM locations WHERE city = 'Kandy'));
INSERT INTO users (first_name, middle_name, last_name, email, dob, gender, password, home_town_locationID, lives_locationID)
VALUES ('Sophia', 'N.', 'Wilson', 'sophiawilson@socialmedia.com', '2005-03-27', 'F', 'password10', (SELECT locationID FROM locations WHERE city = 'Kandy'), (SELECT locationID FROM locations WHERE city = 'Colombo'));

SELECT 'Out users table' AS 'Promot for stage';
SELECT * FROM users;

SELECT 'Create friends table' AS 'Promot for stage';
CREATE TABLE friends (
  userID1 INT NOT NULL, 
  userID2 INT NOT NULL, 
  date DATE NOT NULL, 
  PRIMARY KEY (userID1, userID2)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Alter friends table for foreign keys' AS 'Promot for stage';
ALTER TABLE friends ADD FOREIGN KEY (userID1) REFERENCES users (userID)  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE friends ADD FOREIGN KEY (userID2) REFERENCES users (userID)  ON DELETE CASCADE ON UPDATE CASCADE;

SELECT 'Insert records to friends table' AS 'Promot for stage';
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'), (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com'), (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'), (SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'), (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'), (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'), (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com'), (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'), CURDATE());
INSERT INTO friends (userID1, userID2, date)
VALUES ((SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com'), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), CURDATE());

SELECT 'Out friends table' AS 'Promot for stage';
SELECT * FROM friends;

SELECT 'Create albums table' AS 'Promot for stage';
CREATE TABLE albums (
  albumID INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL, 
  date DATE NOT NULL, 
  userID INT NOT NULL, 
  PRIMARY KEY (albumID),
  UNIQUE (name, userID),
  KEY FK_album_user (userID),
  CONSTRAINT FK_album_user FOREIGN KEY (userID) REFERENCES users (userID)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert records to albums table' AS 'Promot for stage';
INSERT INTO albums (name, date, userID)
VALUES ('Summer Vacation', CURDATE(), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('New Year 2023', CURDATE(), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Family Reunion', CURDATE(), (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Hiking Adventures', CURDATE(), (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Beach Party', CURDATE(), (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Road Trip Memories', CURDATE(), (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('City Exploration', CURDATE(), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Friends', CURDATE(), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Nature Photography', CURDATE(), (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Festival Highlights', CURDATE(), (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Artistic Creations', CURDATE(), (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'));
INSERT INTO albums (name, date, userID)
VALUES ('Wedding Memories', CURDATE(), (SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com'));

SELECT 'Out albums table' AS 'Promot for stage';
SELECT * FROM albums;

SELECT 'Create photos table' AS 'Promot for stage';
CREATE TABLE photos (
  photoID INT NOT NULL AUTO_INCREMENT, 
  caption VARCHAR(50) DEFAULT NULL, 
  data LONGBLOB DEFAULT NULL, 
  locationID INT DEFAULT NULL, 
  albumID INT NOT NULL, 
  PRIMARY KEY (photoID), 
  KEY FK_photo_location (locationID),
  KEY FK_photo_album (albumID),
  CONSTRAINT FK_photo_location FOREIGN KEY (locationID) REFERENCES locations (locationID) ON DELETE SET NULL ON UPDATE CASCADE, 
  CONSTRAINT FK_photo_album FOREIGN KEY (albumID) REFERENCES albums (albumID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert records to photos table' AS 'Promot for stage';
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Summer Vacation Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Kandy'), 
(SELECT albumID FROM albums WHERE name = 'Summer Vacation' and userID = (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('New Year 2023 Photo', NULL, NULL, 
(SELECT albumID FROM albums WHERE name = 'New Year 2023' and userID = (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Family Reunion Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Colombo'), 
(SELECT albumID FROM albums WHERE name = 'Family Reunion' and userID = (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Hiking Adventures Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Galle'), 
(SELECT albumID FROM albums WHERE name = 'Hiking Adventures' and userID = (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Beach Party Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Nuwara Eliya'), 
(SELECT albumID FROM albums WHERE name = 'Beach Party' and userID = (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Road Trip Memories Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Trincomalee'), 
(SELECT albumID FROM albums WHERE name = 'Road Trip Memories' and userID = (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('City Exploration Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Gampaha'), 
(SELECT albumID FROM albums WHERE name = 'City Exploration' and userID = (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Friends Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Jaffna'), 
(SELECT albumID FROM albums WHERE name = 'Friends' and userID = (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Nature Photography Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Bentota'), 
(SELECT albumID FROM albums WHERE name = 'Nature Photography' and userID = (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com')) );
INSERT INTO photos (caption, data, locationID, albumID)
VALUES ('Festival Highlights Photo', NULL, (SELECT locationID FROM locations WHERE city = 'Dambulla'), 
(SELECT albumID FROM albums WHERE name = 'Festival Highlights' and userID = (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com')) );


SELECT 'Out photos table' AS 'Promot for stage';
SELECT * FROM photos;

SELECT 'Create videos table' AS 'Promot for stage';
CREATE TABLE videos (
  videoID INT NOT NULL AUTO_INCREMENT, 
  caption VARCHAR(50) DEFAULT NULL, 
  data LONGBLOB DEFAULT NULL, 
  locationID INT DEFAULT NULL, 
  albumID INT NOT NULL, 
  PRIMARY KEY (videoID), 
  KEY FK_video_location (locationID),
  KEY FK_video_album (albumID),
  CONSTRAINT FK_video_location FOREIGN KEY (locationID) REFERENCES locations (locationID) ON DELETE SET NULL ON UPDATE CASCADE, 
  CONSTRAINT FK_video_album FOREIGN KEY (albumID) REFERENCES albums (albumID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert records to videos table' AS 'Promot for stage';
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Artistic Creations Video', NULL, (SELECT locationID FROM locations WHERE city = 'Colombo'), 
(SELECT albumID FROM albums WHERE name = 'Artistic Creations' and userID = (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Wedding Memories Video', NULL, NULL, 
(SELECT albumID FROM albums WHERE name = 'Wedding Memories' and userID = (SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Family Reunion Video', NULL, (SELECT locationID FROM locations WHERE city = 'Colombo'), 
(SELECT albumID FROM albums WHERE name = 'Family Reunion' and userID = (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Hiking Adventures Video', NULL, (SELECT locationID FROM locations WHERE city = 'Galle'), 
(SELECT albumID FROM albums WHERE name = 'Hiking Adventures' and userID = (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Beach Party Video', NULL, (SELECT locationID FROM locations WHERE city = 'Nuwara Eliya'), 
(SELECT albumID FROM albums WHERE name = 'Beach Party' and userID = (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Road Trip Memories Video', NULL, (SELECT locationID FROM locations WHERE city = 'Trincomalee'), 
(SELECT albumID FROM albums WHERE name = 'Road Trip Memories' and userID = (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('City Exploration Video', NULL, (SELECT locationID FROM locations WHERE city = 'Gampaha'), 
(SELECT albumID FROM albums WHERE name = 'City Exploration' and userID = (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Friends Video', NULL, (SELECT locationID FROM locations WHERE city = 'Jaffna'), 
(SELECT albumID FROM albums WHERE name = 'Friends' and userID = (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Nature Photography Video', NULL, (SELECT locationID FROM locations WHERE city = 'Bentota'), 
(SELECT albumID FROM albums WHERE name = 'Nature Photography' and userID = (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com')) );
INSERT INTO videos (caption, data, locationID, albumID)
VALUES ('Festival Highlights Video', NULL, (SELECT locationID FROM locations WHERE city = 'Dambulla'), 
(SELECT albumID FROM albums WHERE name = 'Festival Highlights' and userID = (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com')) );

SELECT 'Out videos table' AS 'Promot for stage';
SELECT * FROM videos;

SELECT 'Create posts table' AS 'Promot for stage';
CREATE TABLE posts (
  postID INT NOT NULL AUTO_INCREMENT, 
  topic VARCHAR(100) DEFAULT NULL, 
  creation_date DATE NOT NULL, 
  creation_userID INT NOT NULL, 
  albumID INT DEFAULT NULL, 
  PRIMARY KEY (postID),  
  KEY FK_post_user (creation_userID),
  KEY FK_post_album (albumID),
  CONSTRAINT FK_post_user FOREIGN KEY (creation_userID) REFERENCES users (userID)  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_post_album FOREIGN KEY (albumID) REFERENCES albums (albumID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT 'Insert records to Posts table' AS 'Promot for stage';
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Amazing sunset', CURDATE(), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Summer Vacation' ));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Family gathering', CURDATE(), (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Family Reunion'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Exploring nature', CURDATE(), (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Hiking Adventures'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Fun at the beach', CURDATE(), (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Beach Party'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Road trip memories', CURDATE(), (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Road Trip Memories'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('City skyline', CURDATE(), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'City Exploration'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Artistic expressions', CURDATE(), (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Nature Photography'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Festival moments', CURDATE(), (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Festival Highlights'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Creative artwork', CURDATE(), (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Artistic Creations'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Wedding bliss', CURDATE(), (SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Wedding Memories'));
INSERT INTO posts (topic, creation_date, creation_userID, albumID)
VALUES ('Wedding', CURDATE(), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), (SELECT albumID FROM albums WHERE name = 'Wedding Memories' ));

SELECT 'Out Posts table' AS 'Promot for stage';
SELECT * FROM posts;

SELECT 'Create comments table' AS 'Promot for stage';
CREATE TABLE comments (
  postID INT NOT NULL, 
  userID INT NOT NULL, 
  date DATE NOT NULL, 
  text VARCHAR(1000) DEFAULT NULL,
  PRIMARY KEY (postID, userID), 
  KEY FK_comment_post (postID),
  KEY FK_comment_user (userID),
  CONSTRAINT FK_comment_post FOREIGN KEY (postID) REFERENCES posts (postID)  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_comment_user FOREIGN KEY (userID) REFERENCES users (userID)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 'Insert records to comments table' AS 'Promot for stage';
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Amazing sunset'), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), CURDATE(), 'Beautiful photo!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Amazing sunset'), (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'), CURDATE(), 'I wish I could be there!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Family gathering'), (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'), CURDATE(), 'Great to see everyone together!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Family gathering'), (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'), CURDATE(), 'Such a lovely family photo!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Exploring nature'), (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'), CURDATE(), 'What a breathtaking view!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Exploring nature'), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'), CURDATE(), 'Nature at its finest!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Fun at the beach'), (SELECT userID FROM users WHERE email = 'danielanderson@socialmedia.com'), CURDATE(), 'Wish I could join you guys!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Fun at the beach'), (SELECT userID FROM users WHERE email = 'oliviamiller@socialmedia.com'), CURDATE(), 'Looks like a great time!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Road trip memories'), (SELECT userID FROM users WHERE email = 'thomasdavis@socialmedia.com'), CURDATE(), 'Such fond memories!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Road trip memories'), (SELECT userID FROM users WHERE email = 'sophiawilson@socialmedia.com'), CURDATE(), 'Road trips are the best!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'City skyline'), (SELECT userID FROM users WHERE email = 'johndoe@socialmedia.com'), CURDATE(), 'What a stunning cityscape!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'City skyline'), (SELECT userID FROM users WHERE email = 'janesmith@socialmedia.com'), CURDATE(), 'I love the city lights!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Artistic expressions'), (SELECT userID FROM users WHERE email = 'davidjohnson@socialmedia.com'), CURDATE(), 'Beautiful artwork!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Artistic expressions'), (SELECT userID FROM users WHERE email = 'sarahwilson@socialmedia.com'), CURDATE(), 'You\'re so talented!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Festival moments'), (SELECT userID FROM users WHERE email = 'michaelbrown@socialmedia.com'), CURDATE(), 'I miss those festive vibes!');
INSERT INTO comments (postID, userID, date, text)
VALUES ((SELECT postID FROM posts WHERE topic = 'Festival moments'), (SELECT userID FROM users WHERE email = 'emilytaylor@socialmedia.com'), CURDATE(), 'Such a fun event!');

SELECT 'Out comments table' AS 'Promot for stage';
SELECT * FROM comments;

SELECT '1. Find location-based photos and videos posted' AS 'Promot for stage';
SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(  SELECT l.city, l.state, l.country, p.caption, 'Photo' as  media_type, p.albumID
   FROM locations l
   JOIN photos p ON l.locationID = p.locationID
   UNION 
   SELECT l.city, l.state, l.country, v.caption, 'Video' as  media_type, v.albumID
   FROM locations l
   JOIN videos v ON l.locationID = v.locationID) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city = 'Kandy';

SELECT '2. Find location-based photos and videos posted. City starting with \'C\' with LIKE pattern match' AS 'Promot for stage';
SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(  SELECT l.city, l.state, l.country, p.caption, 'Photo' as  media_type, p.albumID
   FROM locations l
   JOIN photos p ON l.locationID = p.locationID
   UNION 
   SELECT l.city, l.state, l.country, v.caption, 'Video' as  media_type, v.albumID
   FROM locations l
   JOIN videos v ON l.locationID = v.locationID) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city LIKE 'C%';

SELECT '3. Find location-based photos and videos posted. City starting with \'C\' with REGEXP pattern match' AS 'Promot for stage';
SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(   SELECT l.city, l.state, l.country, p.caption, 'Photo' AS media_type, p.albumID
    FROM locations l
    JOIN photos p ON l.locationID = p.locationID
    UNION 
    SELECT l.city, l.state, l.country, v.caption, 'Video' AS media_type, v.albumID
    FROM locations l
    JOIN videos v ON l.locationID = v.locationID
) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city REGEXP '^C';

SELECT '4. Find location-based photos and videos posted. City starting with \'B\'  and \'G\' having 7 letters with REGEXP pattern match' AS 'Promot for stage';
SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(SELECT l.city, l.state, l.country, p.caption, 'Photo' as  media_type, p.albumID
FROM locations l
JOIN photos p ON l.locationID = p.locationID
union 
SELECT l.city, l.state, l.country, v.caption, 'Video' as  media_type, v.albumID
FROM locations l
JOIN videos v ON l.locationID = v.locationID) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city LIKE '_______' AND  tab1.city REGEXP '^(B|G)';

SELECT '5. Find location-based photos and videos posted. City having \'B\'  and \'G\' letters anywhere with REGEXP pattern match' AS 'Promot for stage';
SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, a.name AS album_name, u.first_name, u.last_name
FROM
(
    SELECT l.city, l.state, l.country, p.caption, 'Photo' AS media_type, p.albumID
    FROM locations l
    JOIN photos p ON l.locationID = p.locationID
    UNION 
    SELECT l.city, l.state, l.country, v.caption, 'Video' AS media_type, v.albumID
    FROM locations l
    JOIN videos v ON l.locationID = v.locationID
) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city REGEXP '.*[BG].*';

SELECT '6. No of comments per album' AS 'Promot for stage';
SELECT a.albumID, a.name AS album_name, COUNT(c.postID) AS num_comments
FROM albums a
LEFT JOIN posts p ON a.albumID = p.albumID
LEFT JOIN comments c ON p.postID = c.postID
GROUP BY a.albumID, a.name;

SELECT '7. Album only having video' AS 'Promot for stage';
SELECT u.first_name, u.last_name, a.name AS album_name, v.caption AS video_caption
FROM albums a
JOIN users u ON a.userID = u.userID
JOIN videos v ON a.albumID = v.albumID
WHERE NOT EXISTS (
    SELECT 1
    FROM photos p
    WHERE p.albumID = a.albumID
);

SELECT '8. Albums commented by others not by owner' AS 'Promot for stage';
SELECT u.first_name, u.last_name, a.name AS album_name, p.topic AS post_topic, c.text AS comment_text, uc.first_name AS commented_user_first_name, uc.last_name AS commented_user_last_name
FROM albums a
JOIN users u ON a.userID = u.userID
JOIN posts p ON a.albumID = p.albumID
JOIN comments c ON p.postID = c.postID
JOIN users uc ON c.userID = uc.userID
WHERE uc.userID <> u.userID;
 
SELECT '9. Find the comments made by specific user\’s friends' AS 'Promot for stage';
SELECT c.text AS comment_text, u.first_name, u.last_name
FROM comments c
JOIN users u ON c.userID = u.userID
WHERE c.userID IN (
    SELECT f.userID2
    FROM friends f
    JOIN users u ON f.userID1 = u.userID
    WHERE u.email = 'emilytaylor@socialmedia.com'
);

SELECT '10. Specific user\'s friend list and comments that they have made on all albums' AS 'Promot for stage';
SELECT f.userID2 AS friend_userID, u.first_name, u.last_name, c.text AS comment_text, a.name AS album_name
FROM friends f
JOIN users u ON f.userID2 = u.userID
JOIN comments c ON u.userID = c.userID
JOIN posts p ON c.postID = p.postID
JOIN albums a ON p.albumID = a.albumID
JOIN users ua ON a.userID = ua.userID
WHERE ua.email = 'emilytaylor@socialmedia.com';

SELECT '11. Check email address is following following right patter with \'@\' and \'.\'' AS 'Promot for stage';
UPDATE users
SET email = 'michaelbrown@socialmediacom'
WHERE email = 'michaelbrown@socialmedia.com';

SELECT *
FROM users
WHERE NOT(email REGEXP '^[^@]+@[^@]+\\.[^@]+$');

SELECT '12. Constrain validation. Location Gampaha is referred in photos and videos and cascade constrain. 
But not in users where it has restricted. Therefore Location Gampaha should be allowed to delete 
and entries in Photos and Video should be removed. ' AS 'Promot for stage';

SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(  SELECT l.city, l.state, l.country, p.caption, 'Photo' as  media_type, p.albumID
   FROM locations l
   JOIN photos p ON l.locationID = p.locationID
   UNION 
   SELECT l.city, l.state, l.country, v.caption, 'Video' as  media_type, v.albumID
   FROM locations l
   JOIN videos v ON l.locationID = v.locationID) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city = 'Gampaha';

SELECT *
FROM users
WHERE home_town_locationID IN (
    SELECT locationID
    FROM locations
    WHERE city = 'Gampaha'
);

DELETE FROM locations WHERE city = 'Gampaha';

SELECT tab1.city, tab1.state, tab1.country, tab1.caption, tab1.media_type, 
a.name AS album_name, u.first_name, u.last_name
FROM
(  SELECT l.city, l.state, l.country, p.caption, 'Photo' as  media_type, p.albumID
   FROM locations l
   JOIN photos p ON l.locationID = p.locationID
   UNION 
   SELECT l.city, l.state, l.country, v.caption, 'Video' as  media_type, v.albumID
   FROM locations l
   JOIN videos v ON l.locationID = v.locationID) tab1
JOIN albums a ON tab1.albumID = a.albumID
JOIN users u ON a.userID = u.userID
WHERE tab1.city = 'Gampaha';

SELECT '13. Constrain validation. Location Colombo is used with restricted constrained in Users table hence should not allow to delete ' AS 'Promot for stage';
SELECT *
FROM users
WHERE home_town_locationID IN (
    SELECT locationID
    FROM locations
    WHERE city = 'Colombo'
);

DELETE FROM locations WHERE city = 'Colombo';

SELECT '14. Find the most active user (based on the number of posts) in each city' AS 'Promot for stage';
SELECT all_counts.city, all_counts.first_name, all_counts.last_name, all_counts.post_count
FROM (
    SELECT l.city, MAX(post_count) AS max_post_count
    FROM locations l
    JOIN users u ON l.locationID = u.home_town_locationID
    JOIN (
        SELECT p.creation_userID, COUNT(p.postID) AS post_count
        FROM posts p
        GROUP BY p.creation_userID
    ) AS pc ON u.userID = pc.creation_userID
    GROUP BY l.city
) AS max_counts
JOIN (
    SELECT l.city, u.first_name, u.last_name, COUNT(p.postID) AS post_count
    FROM locations l
    JOIN users u ON l.locationID = u.home_town_locationID
    JOIN posts p ON u.userID = p.creation_userID
    GROUP BY l.city, u.userID
) AS all_counts ON max_counts.city = all_counts.city AND max_counts.max_post_count = all_counts.post_count;

SELECT '15. Find the number of distinct users who have posted either a photo or a video' AS 'Promot for stage';
SELECT COUNT(DISTINCT u.userID) AS distinct_users
FROM users u
JOIN albums a ON u.userID = a.userID
JOIN (
    SELECT albumID
    FROM photos
    UNION
    SELECT albumID
    FROM videos
) AS av ON a.albumID = av.albumID;

SELECT '16. Find the users who have both created an album and posted a comment' AS 'Promot for stage';
SELECT u.first_name, u.last_name
FROM users u
JOIN albums a ON u.userID = a.userID
JOIN posts p ON a.albumID = p.albumID
JOIN comments c ON p.postID = c.postID
WHERE u.userID = c.userID;


SELECT '17. Find the average number of comments per post' AS 'Promot for stage';
SELECT AVG(comment_count) AS average_comments
FROM (
    SELECT p.postID, COUNT(c.postID) AS comment_count
    FROM posts p
    LEFT JOIN comments c ON p.postID = c.postID
    GROUP BY p.postID
) AS subquery;

SELECT '18. Find the users who have commented on their own posts' AS 'Promot for stage';
SELECT u.first_name, u.last_name
FROM users u
JOIN posts p ON u.userID = p.creation_userID
JOIN comments c ON p.postID = c.postID
WHERE u.userID = c.userID;

SELECT '19. Find the most common city where users have their home town' AS 'Promot for stage';
SELECT l.city, COUNT(u.userID) AS user_count
FROM users u
JOIN locations l ON u.home_town_locationID = l.locationID
GROUP BY l.city
ORDER BY user_count DESC
LIMIT 1;

SELECT '20. Find the users who have posted the most number of photos' AS 'Promot for stage';
SELECT u.first_name, u.last_name, COUNT(ph.photoID) AS photo_count
FROM users u
JOIN albums a ON u.userID = a.userID
JOIN photos ph ON a.albumID = ph.albumID
GROUP BY u.userID
ORDER BY photo_count DESC
LIMIT 1;

SELECT '21. Find the users who have not posted any photos or videos' AS 'Promot for stage';
SELECT u.first_name, u.last_name
FROM users u
LEFT JOIN posts p ON u.userID = p.creation_userID
LEFT JOIN albums a ON p.albumID = a.albumID
LEFT JOIN photos ph ON a.albumID = ph.albumID
LEFT JOIN videos v ON a.albumID = v.albumID
WHERE ph.photoID IS NULL AND v.videoID IS NULL;

