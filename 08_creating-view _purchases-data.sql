-- Creating 'Purchases Data' view
-- Contains information about all stock purchases

CREATE VIEW [dbo].[Purchases Data]
AS
SELECT
  dbo.ingredients.name AS ingredient,
  dbo.products.name AS product,
  dbo.purchase_vendors.date,
  dbo.purchases.unit_price AS [unit price],
  dbo.purchases.quantity
FROM dbo.ingredients
INNER JOIN dbo.products
  ON dbo.ingredients.ing_id = dbo.products.ing_id
INNER JOIN dbo.purchases
  ON dbo.products.prod_id = dbo.purchases.prod_id
INNER JOIN dbo.purchase_vendors
  ON dbo.purchases.purch_id = dbo.purchase_vendors.purch_id