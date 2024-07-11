DELIMITER //

CREATE PROCEDURE AddBookWithAuthor(
    IN p_Title VARCHAR(100),
    IN p_Genre VARCHAR(50),
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_BirthYear INT
)
BEGIN
    DECLARE author_exists INT;
    DECLARE new_author_id INT;

    -- Check if the author already exists
    SELECT AuthorID INTO author_exists
    FROM Authors
    WHERE FirstName = p_FirstName AND LastName = p_LastName AND BirthYear = p_BirthYear
    LIMIT 1;

    -- If the author does not exist, insert the new author
    IF author_exists IS NULL THEN
        INSERT INTO Authors (FirstName, LastName, BirthYear) VALUES (p_FirstName, p_LastName, p_BirthYear);
        SET new_author_id = LAST_INSERT_ID();
    ELSE
        SET new_author_id = author_exists;
    END IF;

    -- Insert the new book
    INSERT INTO Books (Title, Genre, AuthorID) VALUES (p_Title, p_Genre, new_author_id);
END //

DELIMITER ;
