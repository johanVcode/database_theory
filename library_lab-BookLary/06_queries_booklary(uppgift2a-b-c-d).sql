-- Uppgift 3 a) hur många böcker finns det totalt?

SELECT 
    COUNT(exemplar_id) 
    -- Books the library owns and not only registered.
    -- skipped * because wanted to be more precise and skip the ones that might be loaned already.
FROM exemplar;

-- Uppgift 3 b) lista alla låntagare

SELECT DISTINCT 
    mb.first_name, 
    mb.last_name
FROM 
    member mb
JOIN 
    loan ln ON mb.medlemskaps_id = ln.medlemskaps_id; 
    -- need LOAN foreign key (medlemskaps_id) to compare it to MEMBER primary key (medlemskaps_id)
    -- since no loan can exist without a book/line, we use that to compare it to membership table

-- Uppgift 3 c) lista alla unika böcker

SELECT DISTINCT
    title,
    author,
    isbn
FROM book;

-- Uppgift 3 d) bonus: lista alla böcker som är utlånade

SELECT DISTINCT 
    bk.title --we list the title of the book
FROM 
    loan_item li -- From loan item's table since it connects everything 
JOIN exemplar ex ON li.exemplar_id = ex.exemplar_id -- exemplar's exemplar_id (PK) being compared to loan's exemplar_id (fk)
JOIN book bk ON bk.book_id = ex.book_id -- exemplar's book_id (pk) being compared to book's book_id (pk)
WHERE 
    li.return_date IS NULL; -- figures out whats is loaned out, since loaned items have no return date and will return as null

-- this will just return how many books and not list the ones with names
-- thought of this one myself but quickly realised that it wasnt doing what i was asked for

SELECT
    COUNT(*)
FROM
    loan_item
WHERE
    return_date IS NULL
