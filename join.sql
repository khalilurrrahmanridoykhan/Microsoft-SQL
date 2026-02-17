
--  INNER JOIN (or just JOIN)
-- What it does: Returns only the rows where there is a match in both tables. Non-matching rows are excluded.
-- Use case: When you want data that exists in both tables (e.g., users who have posts).
SELECT u.username, p.title, p.content
FROM dbo.users u INNER JOIN dbo.posts p ON u.id = p.user_id
WHERE u.email = 'user3@example.com';

-- LEFT JOIN (or LEFT OUTER JOIN)
-- What it does: Returns all rows from the left table (first table), and matching rows from the right table. If no match, NULLs are returned for the right table's columns.
-- Use case: When you want all records from the left table, even if they don't have matches on the right (e.g., all users, including those without posts).

SELECT u.username, p.title
from dbo.users u LEFT JOIN dbo.posts p ON u.id = p.user_id;


-- RIGHT JOIN (or RIGHT OUTER JOIN)
-- What it does: Returns all rows from the right table (second table), and matching rows from the left table. If no match, NULLs are returned for the left table's columns.
-- Use case: When you want all records from the right table, even if they don't have matches on the left (e.g., all posts, including those without users).  
SELECT u.username, p.title
FROM dbo.users u RIGHT JOIN dbo.posts p ON u.id = p.user_id;