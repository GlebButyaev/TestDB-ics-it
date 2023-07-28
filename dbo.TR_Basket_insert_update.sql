CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    -- Обновление DiscountValue для ID_SKU, добавленных 2 и более раза
    UPDATE b
    SET DiscountValue = CASE
                          WHEN SKUCount > 1 THEN Value * 0.05
                          ELSE 0
                       END
    FROM dbo.Basket b
    JOIN (SELECT ID_SKU, COUNT(*) AS SKUCount
          FROM dbo.Basket
          GROUP BY ID_SKU) AS SKUCounts
    ON b.ID_SKU = SKUCounts.ID_SKU
    WHERE b.ID IN (SELECT ID FROM inserted);
END;