CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    -- Проверка на существование семьи с переданным SurName
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR ('Семьи с именем %s не существует.', 16, 1, @FamilySurName);
        RETURN;
    END

    -- Обновление BudgetValue в таблице dbo.Family
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - ISNULL((SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = f.ID), 0)
    FROM dbo.Family f
    WHERE SurName = @FamilySurName;
END;
