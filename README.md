# Instagram-DB-Clone-Project
For this project, I wanted to replicate the basics of how Instagram stores data in database tables. While I won't be covering every possible table that Instagram uses, I wanted to create a replication of its core principles in order to practice data manipulation and analytics. We will need to include:
	
	
	1. A Table to Store Information On Our Users
	• Keep in mind that we don't need to store everything, just the main components of a User's information.
	
	2. A Table for Photos Users Post
	• Because this is simply a clone to practice the fundamentals of working with large datasets in multiple tables, we need not be concerned with the LITERAL images themselves.
	
	3. Likes for a Given Photo. 
	• Keep in mind that any individual can only "like" a picture a single time.
	
	4. Hashtags 
	• For this we only need to be concerned with Hashtags a given User includes with the post of his/her picture and not those that could be included in comments.

	5. Comment Information
	• Information on User comments on pictures of other Users (Excluding Hashtags).

	6. Relationships Between Users
	• This is should be a one-way relationship because you can follow a User without them following you back. 
	• Followers/Followees
	• Contrast this with the symmetrical agreement on Facebook in which both Users must agree to a friend request.
