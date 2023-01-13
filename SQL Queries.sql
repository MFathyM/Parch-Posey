/* Query 1 */
SELECT MediaType.Name media_type, 
		COUNT(Artist.Name) no_of_artists
FROM Track
JOIN MediaType
ON Track.MediaTypeId = MediaType.MediaTypeId
JOIN Album
ON Track.AlbumId = Album.AlbumId
JOIN Artist
ON Album.ArtistId = Artist.ArtistId
GROUP BY 1;

/* Query 2 */
SELECT artist,
		AVG(total_invoice) avg_monthly_inv
FROM
(
SELECT Artist.Name artist,
		strftime('%Y-%m',Invoice.InvoiceDate) inv_date,
		SUM(Invoice.Total) total_invoice
FROM Track
JOIN Album
ON Track.AlbumId = Album.AlbumId
JOIN Artist
ON Album.ArtistId = Artist.ArtistId
JOIN InvoiceLine
ON InvoiceLine.TrackId = Track.TrackId
JOIN Invoice
ON InvoiceLine.InvoiceId = Invoice.InvoiceId
GROUP BY 1,2
) sub
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/* Query 3 */
SELECT Customer.Country country,
		Genre.GenreId genre_id 
FROM Track
JOIN Genre
ON Track.GenreId = Genre.GenreId
JOIN InvoiceLine
ON InvoiceLine.TrackId = Track.TrackId
JOIN Invoice
ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
WHERE Track.GenreId = (SELECT DISTINCT Genre.GenreId
					FROM Genre WHERE Genre.Name LIKE '%ROCK%');

/* Query 4 */
SELECT sales_rep, month, MAX(total_sales_usd) total_sales_usd
FROM(
SELECT sales_reps.name sales_rep,
		strftime('%m',orders.occurred_at) month,
		orders.total_amt_usd total_sales_usd
FROM sales_reps
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON orders.account_id = accounts.id
WHERE orders.occurred_at LIKE '%2015%'
GROUP BY 1,2
) sub
GROUP BY 2;
