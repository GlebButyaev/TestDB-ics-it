CREATE FUNCTION dbo.udf_GetSKUPrice (@ID_SKU INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @ProductCost DECIMAL(18, 2);

    SELECT @ProductCost = SUM(Value) / NULLIF(SUM(Quantity), 0)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    RETURN @ProductCost;
END;