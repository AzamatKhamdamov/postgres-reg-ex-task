-- Exercise1
-- Extracting records from Suppliers table which contains nonstandart latin symbols in Homepage column

SELECT * 
FROM northwind.suppliers
WHERE Homepage ~ '[^[:ascii:]]';
--this ascii contains all standart latin symbols (A-Z),(a-z),(numbers),(?.:;)like this
--therefore i used this regex.
