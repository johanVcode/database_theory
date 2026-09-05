-- Uppgift 3 a) hur många böcker finns det totalt?

SELECT 
    COUNT(exemplar_id) -- Books i have physically in the library and not just registered.
FROM exemplar;

-- Uppgift 3 b) lista alla låntagare

SELECT DISTINCT 
    mb.first_name, 
    mb.last_name
FROM 
    member mb
JOIN 
    loan ln ON mb.medlemskaps_id = ln.medlemskaps_id;

-- Uppgift 3 c) lista alla unika böcker

SELECT DISTINCT
    title,
    author,
    isbn
FROM book;

-- Uppgift 3 d) bonus: lista alla böcker som är utlånade

SELECT DISTINCT 
    bk.title
FROM 
    loan_item li
JOIN exemplar ex ON li.exemplar_id = ex.exemplar_id
JOIN book bk ON bk.book_id = ex.book_id
WHERE 
    li.return_date IS NULL;
