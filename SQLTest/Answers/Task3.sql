--Task 3
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles] 
--return the names of all authors who have authored more than 1 book. 
--Your “Author” column should concatenate the First Name + Last Name of the author. 
--Order the results by surname in ascending order.

SELECT 
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author

FROM 
    dbo.authors AS a
	INNER JOIN 
    dbo.titleauthor AS ta ON a.au_id = ta.au_id
	INNER JOIN 
    dbo.titles AS t ON ta.title_id = t.title_id

GROUP BY 
    a.au_id, a.au_fname, a.au_lname

HAVING 
    COUNT(t.title_id) > 1

ORDER BY 
    a.au_lname ASC

	