<div align="center">
  <img src="https://github.com/sumidhakp123/Instagram-Clone/assets/69155879/23519098-3600-4da5-ab56-282126afb43a" width="50%" alt="InstagramClone.png">
</div>

# Instagram-Clone
 


Created an Instagram Database in which 7 Tables were integrated through primary and foreign keys. 
After database creation several tricky challenges were performed to through SQL queries.
7 tables are
- Comments
- Follows
- Likes
- Photo tags
- Photos
- Tags
- Users

### ER Diagram of Instagram-Clone

<div align="center">
  <img src="https://github.com/sumidhakp123/Instagram-Clone/assets/69155879/67c69e54-87fd-49ee-b624-6eaa0c1deda2" width="75%" alt="ER Diagram.png">
</div>

# KPIs
- 1. We want to reward our users who have been around the longest.  
-- Find the 5 oldest users.
- 2. What day of the week do most users register on?
-- We need to figure out when to schedule an ad campgain
- 3. We want to target our inactive users with an email campaign.
-- Find the users who have never posted a photo
- 4.-- q4 
/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/

-- q5 
/*Our Investors want to know...
How many times does the average user post?
/*total number of photos/total number of users*/
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2);

-- q6
/* User ranking by postings higher to lower*/
SELECT users.username,COUNT(photos.image_url)
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;

-- q7
/*Total Posts by users (longer versionof SELECT COUNT(*)FROM photos) */
SELECT SUM(user_posts.total_posts_per_user)
FROM (SELECT users.username,COUNT(photos.image_url) AS total_posts_per_user
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id) AS user_posts;

-- q8
/*total numbers of users who have posted at least one time */

-- q9
/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC;

-- q10
/*We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

-- q11
/*We also have a problem with celebrities
Find users who have never commented on a photo*/

-- q12
-- /* Find the count of users who have never commented on phto */  

-- q13
/*Find users who have ever commented on a photo*/

--q14 Find the count of users who have commented on a photo

-- q15
/*Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented on a photo or have commented on photos before*/
