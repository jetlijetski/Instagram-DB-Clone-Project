--This file will be covering the schema on each of our tables in the Instagram Clone project

# USERS TABLE

# ID|PK
# username
# created_at

# Why would we not make username the primary key? After all it is unique. This is because we are going to have a FOREIGN KEY somewhere referencing username, an individuals username
# would be long and make it cumbersome to reference in our queries. It is best practice to make the primary key a unique user ID. We can however make sure that the individuals username
# IS unique by using the UNIQUE key word and NOT NULL because to be a user, one must have a username.

CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);



# PHOTOS TABLE

# ID|PK
# image_url <--- Only storing the image URL which will be a string.
# user_id|FK
# created_at

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);



# COMMENTS TABLE

# ID|PK
# comment_text
# user_id|FK
# photo_id|FK
# created_at

# We need to make sure that both user_id and photo_id are NOT NULL. We cannot have a comment or photo that is an orphan.

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);



# LIKES TABLE

# user_id|FK
# photo_id|FK
# created_at

# We do not need an ID for this table because we are not going to be referrring to Likes anywhere else.

# By making a unique combination of user_id and photo_id as a Primary Key, we can group them together we can ensure
# that there is only one like per user.

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);


# FOLLOWS TABLE

# Both the follower_id and followee_id are foreign keys referencing the users(id) primary key in the USERS table. This
# will fufill the asymmetrical follow constraint style Instagram implements. 
# We also need to implement another unique combination Primary Key because a user should not be able to follow another
# user more than once.


# follower_id|FK
# followee_id|FK
# created_at

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);


# HASHTAGS TABLE

# This will require us to use our Photos table, in combination with a Tags table and a union table called Photo_Tags.
# This Photo_Tags table will be an instance of a hashtag being applied to a photo and the schema itself will only be
# made of a column for photo_id and a column for tag_id.  

# From a performance perspective this is the best method for situations
# that include common hastags, or strings that are used often.


CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

# Including a PRIMARY KEY(photo_id, tag_id) for our photo_tags table ensures that we cannot include multiple identical tags
# for the same photo.