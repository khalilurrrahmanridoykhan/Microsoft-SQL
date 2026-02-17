SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM dbo.users)
BEGIN
    INSERT INTO dbo.users (username, email, password)
    VALUES
        ('user1', 'user1@example.com', 'Pass@123'),
        ('user2', 'user2@example.com', 'Pass@123'),
        ('user3', 'user3@example.com', 'Pass@123'),
        ('user4', 'user4@example.com', 'Pass@123'),
        ('user5', 'user5@example.com', 'Pass@123'),
        ('user6', 'user6@example.com', 'Pass@123'),
        ('user7', 'user7@example.com', 'Pass@123'),
        ('user8', 'user8@example.com', 'Pass@123'),
        ('user9', 'user9@example.com', 'Pass@123'),
        ('user10', 'user10@example.com', 'Pass@123'),
        ('user11', 'user11@example.com', 'Pass@123'),
        ('user12', 'user12@example.com', 'Pass@123'),
        ('user13', 'user13@example.com', 'Pass@123'),
        ('user14', 'user14@example.com', 'Pass@123'),
        ('user15', 'user15@example.com', 'Pass@123');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.posts)
BEGIN
    ;WITH u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.posts (user_id, title, content)
    SELECT
        u.id,
        CONCAT('Welcome Post ', u.rn),
        CONCAT('This is demo content for post ', u.rn, '.')
    FROM u;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.comments)
BEGIN
    ;WITH p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    ),
    u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.comments (post_id, user_id, content)
    SELECT
        p.id,
        u.id,
        CONCAT('Comment ', p.rn, ' on post ', p.rn, '.')
    FROM p
    JOIN u ON u.rn = p.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.categories)
BEGIN
    INSERT INTO dbo.categories (name)
    VALUES
        ('Category 1'),
        ('Category 2'),
        ('Category 3'),
        ('Category 4'),
        ('Category 5'),
        ('Category 6'),
        ('Category 7'),
        ('Category 8'),
        ('Category 9'),
        ('Category 10'),
        ('Category 11'),
        ('Category 12'),
        ('Category 13'),
        ('Category 14'),
        ('Category 15');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.post_categories)
BEGIN
    ;WITH p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    ),
    c AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.categories
        ORDER BY id
    )
    INSERT INTO dbo.post_categories (post_id, category_id)
    SELECT
        p.id,
        c.id
    FROM p
    JOIN c ON c.rn = p.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.tags)
BEGIN
    INSERT INTO dbo.tags (name)
    VALUES
        ('Tag 1'),
        ('Tag 2'),
        ('Tag 3'),
        ('Tag 4'),
        ('Tag 5'),
        ('Tag 6'),
        ('Tag 7'),
        ('Tag 8'),
        ('Tag 9'),
        ('Tag 10'),
        ('Tag 11'),
        ('Tag 12'),
        ('Tag 13'),
        ('Tag 14'),
        ('Tag 15');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.post_tags)
BEGIN
    ;WITH p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    ),
    t AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.tags
        ORDER BY id
    )
    INSERT INTO dbo.post_tags (post_id, tag_id)
    SELECT
        p.id,
        t.id
    FROM p
    JOIN t ON t.rn = p.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.likes)
BEGIN
    ;WITH p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    ),
    u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id DESC) AS rn
        FROM dbo.users
        ORDER BY id DESC
    )
    INSERT INTO dbo.likes (post_id, user_id)
    SELECT
        p.id,
        u.id
    FROM p
    JOIN u ON u.rn = p.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.followers)
BEGIN
    ;WITH u1 AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    ),
    u2 AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id DESC) AS rn
        FROM dbo.users
        ORDER BY id DESC
    )
    INSERT INTO dbo.followers (follower_id, following_id)
    SELECT
        u1.id,
        u2.id
    FROM u1
    JOIN u2 ON u2.rn = u1.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.messages)
BEGIN
    ;WITH u1 AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    ),
    u2 AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id DESC) AS rn
        FROM dbo.users
        ORDER BY id DESC
    )
    INSERT INTO dbo.messages (sender_id, receiver_id, content)
    SELECT
        u1.id,
        u2.id,
        CONCAT('Message from user ', u1.id, ' to user ', u2.id, '.')
    FROM u1
    JOIN u2 ON u2.rn = u1.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.notifications)
BEGIN
    ;WITH u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.notifications (user_id, content, is_read)
    SELECT
        u.id,
        CONCAT('Notification ', u.rn),
        CASE WHEN u.rn % 2 = 0 THEN 1 ELSE 0 END
    FROM u;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.settings)
BEGIN
    ;WITH u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.settings (user_id, [key], value)
    SELECT
        u.id,
        CASE WHEN u.rn % 2 = 0 THEN 'language' ELSE 'theme' END,
        CASE
            WHEN u.rn % 2 = 0 THEN 'en'
            WHEN u.rn % 4 = 1 THEN 'light'
            ELSE 'dark'
        END
    FROM u;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.media)
BEGIN
    ;WITH p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    )
    INSERT INTO dbo.media (post_id, url, [type])
    SELECT
        p.id,
        CONCAT('https://example.com/media/', p.rn, '.jpg'),
        'image'
    FROM p;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.events)
BEGIN
    INSERT INTO dbo.events (name, description, location, start_time, end_time)
    VALUES
        ('Event 1', 'Description for event 1.', 'Location 1', '2025-01-01T10:00:00', '2025-01-01T12:00:00'),
        ('Event 2', 'Description for event 2.', 'Location 2', '2025-01-02T10:00:00', '2025-01-02T12:00:00'),
        ('Event 3', 'Description for event 3.', 'Location 3', '2025-01-03T10:00:00', '2025-01-03T12:00:00'),
        ('Event 4', 'Description for event 4.', 'Location 4', '2025-01-04T10:00:00', '2025-01-04T12:00:00'),
        ('Event 5', 'Description for event 5.', 'Location 5', '2025-01-05T10:00:00', '2025-01-05T12:00:00'),
        ('Event 6', 'Description for event 6.', 'Location 6', '2025-01-06T10:00:00', '2025-01-06T12:00:00'),
        ('Event 7', 'Description for event 7.', 'Location 7', '2025-01-07T10:00:00', '2025-01-07T12:00:00'),
        ('Event 8', 'Description for event 8.', 'Location 8', '2025-01-08T10:00:00', '2025-01-08T12:00:00'),
        ('Event 9', 'Description for event 9.', 'Location 9', '2025-01-09T10:00:00', '2025-01-09T12:00:00'),
        ('Event 10', 'Description for event 10.', 'Location 10', '2025-01-10T10:00:00', '2025-01-10T12:00:00'),
        ('Event 11', 'Description for event 11.', 'Location 11', '2025-01-11T10:00:00', '2025-01-11T12:00:00'),
        ('Event 12', 'Description for event 12.', 'Location 12', '2025-01-12T10:00:00', '2025-01-12T12:00:00'),
        ('Event 13', 'Description for event 13.', 'Location 13', '2025-01-13T10:00:00', '2025-01-13T12:00:00'),
        ('Event 14', 'Description for event 14.', 'Location 14', '2025-01-14T10:00:00', '2025-01-14T12:00:00'),
        ('Event 15', 'Description for event 15.', 'Location 15', '2025-01-15T10:00:00', '2025-01-15T12:00:00');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.event_attendees)
BEGIN
    ;WITH e AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.events
        ORDER BY id
    ),
    u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.event_attendees (event_id, user_id)
    SELECT
        e.id,
        u.id
    FROM e
    JOIN u ON u.rn = e.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.groups)
BEGIN
    INSERT INTO dbo.groups (name, description)
    VALUES
        ('Group 1', 'Description for group 1.'),
        ('Group 2', 'Description for group 2.'),
        ('Group 3', 'Description for group 3.'),
        ('Group 4', 'Description for group 4.'),
        ('Group 5', 'Description for group 5.'),
        ('Group 6', 'Description for group 6.'),
        ('Group 7', 'Description for group 7.'),
        ('Group 8', 'Description for group 8.'),
        ('Group 9', 'Description for group 9.'),
        ('Group 10', 'Description for group 10.'),
        ('Group 11', 'Description for group 11.'),
        ('Group 12', 'Description for group 12.'),
        ('Group 13', 'Description for group 13.'),
        ('Group 14', 'Description for group 14.'),
        ('Group 15', 'Description for group 15.');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.group_members)
BEGIN
    ;WITH g AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.groups
        ORDER BY id
    ),
    u AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.users
        ORDER BY id
    )
    INSERT INTO dbo.group_members (group_id, user_id)
    SELECT
        g.id,
        u.id
    FROM g
    JOIN u ON u.rn = g.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.group_posts)
BEGIN
    ;WITH g AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.groups
        ORDER BY id
    ),
    p AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.posts
        ORDER BY id
    )
    INSERT INTO dbo.group_posts (group_id, post_id)
    SELECT
        g.id,
        p.id
    FROM g
    JOIN p ON p.rn = g.rn;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.group_events)
BEGIN
    ;WITH g AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.groups
        ORDER BY id
    ),
    e AS
    (
        SELECT TOP (15) id, ROW_NUMBER() OVER (ORDER BY id) AS rn
        FROM dbo.events
        ORDER BY id
    )
    INSERT INTO dbo.group_events (group_id, event_id)
    SELECT
        g.id,
        e.id
    FROM g
    JOIN e ON e.rn = g.rn;
END
GO
