SELECT *
FROM dbo.users
WHERE dbo.users.email = 'user3@example.com';

SELECT *
FROM dbo.posts
WHERE dbo.posts.user_id = 3;
