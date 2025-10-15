-- Exercise 4.Creating a trigger to validate name of product
-- That mean our trigger needs to validate productname before insertation
CREATE OR REPLACE FUNCTION validate_name_of_product()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS
$$
BEGIN 
	-- Checking if the first character is uppercase
	IF NEW.productname !~ '^[A-Z]' THEN
        RAISE EXCEPTION 'Invalid Product Name: first letter must be uppercase.';
    END IF;
	
	-- Checking if product name has at least 5 characters
	IF LENGTH(NEW.productname) < 5 THEN
        RAISE EXCEPTION 'Invalid Product Name: must be at least 5 characters long.';
    END IF;
	-- If both checks pass, allow the insertion
    RETURN NEW;
-- If anyproblem happen,it shows this.
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Invalid Product Name: first letter must be uppercase and it must be at least 5characters long.';
END;
$$;

-- Create the trigger
DROP TRIGGER IF EXISTS trigger_validation ON northwind.products;
CREATE TRIGGER trigger_validation

    BEFORE INSERT OR UPDATE ON northwind.products
    FOR EACH ROW
    EXECUTE FUNCTION validate_name_of_product();

-- Testing
-- INSERT INTO northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel) VALUES (39, 'Football Ball', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25);
-- INSERT INTO northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel) VALUES (40, 'Ball', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25);
