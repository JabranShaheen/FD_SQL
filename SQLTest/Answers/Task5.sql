--Task 5
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles] 
--return the name of each author, with the total number of titles published by each author, 
--grouped by year. Your “Author” column should concatenate the First Name + Last Name of the author. 
--Order by the number of titles authored in descending order.


SELECT 
    CONCAT(a.au_fname, ' ', a.au_lname) AS Author,
    YEAR(t.pubdate) AS PublicationYear,
    COUNT(t.title_id) AS NumberOfTitles

FROM 
	[dbo].[authors] a
		INNER JOIN [dbo].[titleauthor] ta 
			ON a.au_id = ta.au_id
		INNER JOIN [dbo].[titles] t 
			ON ta.title_id = t.title_id

GROUP BY 
	CONCAT(a.au_fname, ' ', a.au_lname), YEAR(t.pubdate)

ORDER BY 
	NumberOfTitles DESC;