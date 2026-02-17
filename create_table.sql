IF OBJECT_ID('dbo.users', 'U') IS NULL
BEGIN
    CREATE TABLE users
    (
        id INT IDENTITY PRIMARY KEY,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP
    );
END
GO

IF OBJECT_ID('dbo.posts', 'U') IS NULL
BEGIN
    CREATE TABLE posts
    (
        id INT IDENTITY PRIMARY KEY,
        user_id INT NOT NULL,
        title VARCHAR(255) NOT NULL,
        content VARCHAR(MAX) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.comments', 'U') IS NULL
BEGIN
    CREATE TABLE comments
    (
        id INT IDENTITY PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        content VARCHAR(MAX) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.categories', 'U') IS NULL
BEGIN
    CREATE TABLE categories
    (
        id INT IDENTITY PRIMARY KEY,
        name VARCHAR(255) NOT NULL UNIQUE
    );
END
GO

IF OBJECT_ID('dbo.post_categories', 'U') IS NULL
BEGIN
    CREATE TABLE post_categories
    (
        post_id INT NOT NULL,
        category_id INT NOT NULL,
        PRIMARY KEY (post_id, category_id),
        FOREIGN KEY (post_id) REFERENCES posts(id),
        FOREIGN KEY (category_id) REFERENCES categories(id)
    );
END
GO

IF OBJECT_ID('dbo.tags', 'U') IS NULL
BEGIN
    CREATE TABLE tags
    (
        id INT IDENTITY PRIMARY KEY,
        name VARCHAR(255) NOT NULL UNIQUE
    );
END
GO

IF OBJECT_ID('dbo.post_tags', 'U') IS NULL
BEGIN
    CREATE TABLE post_tags
    (
        post_id INT NOT NULL,
        tag_id INT NOT NULL,
        PRIMARY KEY (post_id, tag_id),
        FOREIGN KEY (post_id) REFERENCES posts(id),
        FOREIGN KEY (tag_id) REFERENCES tags(id)
    );
END
GO

IF OBJECT_ID('dbo.likes', 'U') IS NULL
BEGIN
    CREATE TABLE likes
    (
        id INT IDENTITY PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.followers', 'U') IS NULL
BEGIN
    CREATE TABLE followers
    (
        id INT IDENTITY PRIMARY KEY,
        follower_id INT NOT NULL,
        following_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (follower_id) REFERENCES users(id),
        FOREIGN KEY (following_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.messages', 'U') IS NULL
BEGIN
    CREATE TABLE messages
    (
        id INT IDENTITY PRIMARY KEY,
        sender_id INT NOT NULL,
        receiver_id INT NOT NULL,
        content VARCHAR(MAX) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (sender_id) REFERENCES users(id),
        FOREIGN KEY (receiver_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.notifications', 'U') IS NULL
BEGIN
    CREATE TABLE notifications
    (
        id INT IDENTITY PRIMARY KEY,
        user_id INT NOT NULL,
        content VARCHAR(MAX) NOT NULL,
        is_read BIT DEFAULT 0,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.settings', 'U') IS NULL
BEGIN
    CREATE TABLE settings
    (
        id INT IDENTITY PRIMARY KEY,
        user_id INT NOT NULL,
        [key] VARCHAR(255) NOT NULL,
        value VARCHAR(255) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.media', 'U') IS NULL
BEGIN
    CREATE TABLE media
    (
        id INT IDENTITY PRIMARY KEY,
        post_id INT NOT NULL,
        url VARCHAR(255) NOT NULL,
        [type] VARCHAR(50) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts(id)
    );
END
GO

IF OBJECT_ID('dbo.events', 'U') IS NULL
BEGIN
    CREATE TABLE events
    (
        id INT IDENTITY PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description VARCHAR(MAX) NOT NULL,
        location VARCHAR(255) NOT NULL,
        start_time DATETIME2 NOT NULL,
        end_time DATETIME2 NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP
    );
END
GO

IF OBJECT_ID('dbo.event_attendees', 'U') IS NULL
BEGIN
    CREATE TABLE event_attendees
    (
        id INT IDENTITY PRIMARY KEY,
        event_id INT NOT NULL,
        user_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (event_id) REFERENCES events(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.groups', 'U') IS NULL
BEGIN
    CREATE TABLE groups
    (
        id INT IDENTITY PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description VARCHAR(MAX) NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP
    );
END
GO

IF OBJECT_ID('dbo.group_members', 'U') IS NULL
BEGIN
    CREATE TABLE group_members
    (
        id INT IDENTITY PRIMARY KEY,
        group_id INT NOT NULL,
        user_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (group_id) REFERENCES groups(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
END
GO

IF OBJECT_ID('dbo.group_posts', 'U') IS NULL
BEGIN
    CREATE TABLE group_posts
    (
        id INT IDENTITY PRIMARY KEY,
        group_id INT NOT NULL,
        post_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (group_id) REFERENCES groups(id),
        FOREIGN KEY (post_id) REFERENCES posts(id)
    );
END
GO

IF OBJECT_ID('dbo.group_events', 'U') IS NULL
BEGIN
    CREATE TABLE group_events
    (
        id INT IDENTITY PRIMARY KEY,
        group_id INT NOT NULL,
        event_id INT NOT NULL,
        created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (group_id) REFERENCES groups(id),
        FOREIGN KEY (event_id) REFERENCES events(id)
    );
END
GO
