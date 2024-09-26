CREATE TABLE dbo.SKU (
    ID INT IDENTITY,
    Code AS 's' + CAST(ID AS VARCHAR(10)) UNIQUE,
    Name NVARCHAR(255)
);

-- 2.2 dbo.Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName VARCHAR(255),
    BudgetValue DECIMAL(10, 2)
);

-- 2.3 dbo.Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT NOT NULL,
    ID_Family INT NOT NULL,
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(10, 2) CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue DECIMAL(10, 2),
    FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU (ID),
    FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID)
);

