-- Exercise 3.Creating a function that devide postalcode to 3types('Local','National','Internation')
-- if postalcode is full digits - 'Local'
-- if postalcode is digital with '-' - 'National'
-- otherwise 'International' if it is not null

CREATE OR REPLACE FUNCTION classify_customer_by_postal_code(postal_code VARCHAR)
RETURNS varchar 
LANGUAGE plpgsql
AS
$$
BEGIN
	-- IF postalcode is null or empty,we call it as error and "Unknown"
	IF postal_code IS NULL OR postal_code = '' THEN
        RETURN 'Unknown';
    END IF;
	IF postal_code ~ '^[\d]{4,6}$' THEN
        RETURN 'Local';
	END IF;
	IF postal_code ~ '^[\d]{3,5}-[\d]{2,4}$' THEN
        RETURN 'National';
	END IF;
	RETURN 'International';
    
END;
$$
-- TESTING
-- SELECT 
--     customerid,
--     companyname,
--     postalcode,
--     classify_customer_by_postal_code(postalcode) AS classification
-- FROM northwind.customers
-- LIMIT 10;
