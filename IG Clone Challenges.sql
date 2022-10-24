-- Solving real world problems using our mock data

# Challenge 1: Suppose we want to reward our users who have been around for a long time, identify the 5 oldest users on Instagram.

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;


# Challenge 2: We are trying to solicit new users to sign up to Instagram by launching an advertisement campaign. What day of the week
# do most users register on?

# Cannot group by created at because not everyone registered at the same exact time. We need to group by specifically the day. To accomplish 
# this we can pass in our created_at data in the DAYNAME() function. From executing this query, we can see that Thursday and Sunday have the 
# most with 16 new users registered on each day. 

SELECT
  DAYNAME(created_at) AS day,
  COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;


# Challenge 3: We want to target our inactive users with an email campaign. Find users who haven't ever posted a photo.

# We want to perform a JOIN between the Users and Photos tables however specifically a LEFT JOIN. 

# If we were to only perform an INNER JOIN, we would only produce users who HAD posted photos and the users who have not would be excluded as 
# they would contain NULL values. By using a LEFT JOIN we can specifically identify where the tables are non-overlapping.

SELECT
  username,
  image_url
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;


# Challenge 4: What is the single most liked photo in our database and the user who posted it?

# What we need to accomplish this task is to perform two inner joins using the photos, likes, and users tables. We can group together
# the photos.id in order to COUNT(*) the number of likes for each photo.

# We can see by running this query that the user Zack_Kemmer93 had the most at 48 total likes for one picture.


SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


# Challenge 5: How many times does the average user post?

# To accomplish this we need to take the total number of posts and divide it by the total number of users. For this example we will
# solve by using sub-queries.

# After performing this query we can see that the average amount of posts per user is 2.57

SELECT
(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;


# Challenge 6: A brand wants to know which hashtags to us in a post. What are the top 5 most commonly used hashtags?

# We can utilize a single JOIN to connect hashtags (the name of a tag) with photo_tags (Every time a tag is used and applied to a photo).
# We can group all the photo tags together, count them and find their associated name.

# This query produces the top 5 tags being: smile, beach, party, fun, and lol

SELECT
  tags.tag_name,
  COUNT(*) AS total
FROM photo_tags
JOIN tags
  ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC LIMIT 5;


# Challenge 7: Our Instagram app is having problems with bots, write a query to identify users who have liked every single photo
# in our database.

# Our methodology for this challenge is to INNER JOIN the likes table to the users table. We can then group those user_id's from 
# the likes table in order to count them as the ALIAS num_likes. 

# Now even though we know there are a total of 257 pictures in our photos table, we cannot just compare WHERE users have liked
# 257 photos, as realistically this number would be constantly changing.

# This is why we are using the HAVING clause along with a subquery that counts the total number of photos in the photos table.
# This HAVING clause allows us to constantly know who has liked EVERY photo, no matter how many photos reside in our table.


SELECT
  username,
  user_id,
  COUNT(*) AS num_likes
FROM users
INNER JOIN likes
  ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos); 