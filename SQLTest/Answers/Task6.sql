--Task 6
--Using [dbo].[authors], [dbo].[titleauthor] and [dbo].[titles] 
--list the author’s names, the number of titles published by that author, the average price of those titles and the most recent publish date (pubdate). 
--Order by the average price in descending order.


SELECT 
    a.au_lname + ', ' + a.au_fname AS AuthorName,
    COUNT(t.title_id) AS NumberOfTitles,
    AVG(t.price) AS AveragePrice,
    MAX(t.pubdate) AS MostRecentPublishDate

FROM 
    dbo.authors AS a
	INNER JOIN 
    dbo.titleauthor AS ta ON a.au_id = ta.au_id
	INNER JOIN 
    dbo.titles AS t ON ta.title_id = t.title_id

GROUP BY 
    a.au_lname, a.au_fname

ORDER BY 
    AveragePrice DESC;
