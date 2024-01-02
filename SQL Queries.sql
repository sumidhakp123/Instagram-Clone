use ig_clone;
-- q1 
 /* We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- q2 
/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
SELECT date_format(created_at,'%W') AS 'day of the week', COUNT(*) AS 'total registration'
FROM users
GROUP BY 1
ORDER BY 2 DESC;

/*Another method*/
SELECT DAYNAME(created_at) AS day, COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

-- q3 
/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- q4 
/*We are running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
SELECT users.username, photos.id, photos.image_url, COUNT(*) AS Total_Likes
FROM likes
JOIN photos ON photos.id = likes.photo_id
JOIN users ON users.id = likes.user_id
GROUP BY photos.id
ORDER BY Total_Likes DESC
LIMIT 1;

/* Another Method */
SELECT  username, photos.id, photos.image_url,  COUNT(*) AS total
FROM photos
INNER JOIN likes
ON likes.photo_id = photos.id
INNER JOIN users
ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- q5 
/* Our Investors want to know...
How many times does the average user post?
/*total number of photos/total number of users */
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2);

-- q6
/* User ranking by postings higher to lower */
SELECT users.username,COUNT(photos.image_url)
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;

-- q7
/* Total Posts by users. */
SELECT SUM(user_posts.total_posts_per_user)
FROM (SELECT users.username,COUNT(photos.image_url) AS total_posts_per_user
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id) AS user_posts;

-- q8
/* Total numbers of users who have posted at least one time */
SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id;

-- q9
/* A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags? */
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC;

-- q10
/* We have a small problem with bots on our site...
Find users who have liked every single photo on the site */
SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

-- q11
/* We also have a problem with celebrities
Find users who have never commented on a photo */
SELECT distinct username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NULL;

-- q12
-- /* Find the count of users who have never commented on photo */  
SELECT COUNT(*) FROM
(SELECT username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NULL) AS total_number_of_users_without_comments;

-- q13
/* Find users who have ever commented on a photo */
SELECT username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NOT NULL;


SELECT COUNT(*) FROM
(SELECT username,comment_text
	FROM users
	LEFT JOIN comments ON users.id = comments.user_id
	GROUP BY users.id
	HAVING comment_text IS NOT NULL) AS total_number_users_with_comments;

-- q14
/* Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented on a photo or have commented on photos before */
    
    WITH UsersWithoutComments AS (
    SELECT username
    FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    GROUP BY users.id
    HAVING COUNT(comment_text) = 0
),
UsersWithComments AS (
    SELECT username
    FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    GROUP BY users.id
    HAVING COUNT(comment_text) > 0
)
SELECT
    COUNT(*) AS 'Number Of Users who never commented',
    (COUNT(*) / (SELECT COUNT(*) FROM users)) * 100 AS '%',
    (SELECT COUNT(*) FROM UsersWithComments) AS 'Number of Users who commented on photos',
    (SELECT COUNT(*) / (SELECT COUNT(*) FROM users)) * 100 AS '%'
FROM UsersWithoutComments;
