--Task 2
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles]  
--return the book title and author of the best selling psychology book of 1991.  
--Your “Author” column should concatenate the First Name + Last Name of the author. E.g.  “John Smith”


SELECT 
	TOP 1
	t.title AS BookTitle,
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author

FROM 
	[dbo].[titles] t
	INNER JOIN [dbo].[titleauthor] ta 
		ON t.title_id = ta.title_id
	INNER JOIN [dbo].[authors] a 
		ON ta.au_id = a.au_id

WHERE 
	t.type = 'Psychology'
	AND YEAR(t.pubdate) = 1991

ORDER BY 
	t.ytd_sales DESC;