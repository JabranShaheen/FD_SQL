--Task 4
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles] 
--return the names of authors who have co-authored a book. Your “Author” 
--column should concatenate the First Name + Last Name of the author.  
--Order by the authors surname in descending order.

WITH CoAuthoredBooks AS (
    SELECT 
        ta.title_id
    FROM 
        dbo.titleauthor AS ta
    GROUP BY 
        ta.title_id
    HAVING 
        COUNT(ta.au_id) > 1
),
AuthorDetails AS (
    SELECT DISTINCT
        CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
        a.au_lname
    FROM 
        dbo.authors AS a
    INNER JOIN 
        dbo.titleauthor AS ta ON a.au_id = ta.au_id
    INNER JOIN 
        CoAuthoredBooks AS cab ON ta.title_id = cab.title_id
    INNER JOIN
        dbo.titles AS t ON ta.title_id = t.title_id
)
SELECT 
    Author
FROM 
    AuthorDetails
ORDER BY 
    au_lname DESC;