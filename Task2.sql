-- Exercise 2: Formatting phone numbers into comman standart format using REGEXP_REPLACE() function
-- standart format (xxx) xxx-xxxx

SELECT 
	customerid,
	companyname,
	phone,
	
	-- This takes all digit from notformatted phone number
	-- REGEXP_REPLACE(phone, '\D', '', 'g'),

	-- If phone number is longer than limit(10) we take 10digits form right side(12345678912->2345678912)
	-- RIGHT(REGEXP_REPLACE(phone, '\D', '', 'g'), 10),

	--LPAD add zeros by itself,if it is under limit (123456789->0123456789) 
	-- LPAD(RIGHT(REGEXP_REPLACE(phone, '[\D]', '', 'g'), 10), 10, '0'),

	--Now Formatting
	FORMAT(
        '(%s) %s-%s',
        SUBSTRING(LPAD(RIGHT(REGEXP_REPLACE(phone, '[\D]', '', 'g'), 10), 10, '0') FROM 1 FOR 3),
        SUBSTRING(LPAD(RIGHT(REGEXP_REPLACE(phone, '[\D]', '', 'g'), 10), 10, '0') FROM 4 FOR 3),
        SUBSTRING(LPAD(RIGHT(REGEXP_REPLACE(phone, '[\D]', '', 'g'), 10), 10, '0') FROM 7 FOR 4)
    ) AS formatted_number
FROM northwind.customers;

