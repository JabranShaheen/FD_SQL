--Task 1
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles] return 
--the title(s) of the book(s) published by Stearns MacFeather. 
--Order your results by the ytd_sales in descending order.

SELECT 
	t.title

FROM 
	[dbo].[authors] a
	INNER JOIN [dbo].[titleauthor] ta ON a.au_id = ta.au_id
	INNER JOIN [dbo].[titles] t ON ta.title_id = t.title_id

WHERE 
	a.au_lname = 'MacFeather' AND 
	a.au_fname = 'Stearns'

ORDER BY 
	t.ytd_sales DESC;
