-- Creating Invenotory In view
-- Contains information about additions to the inventory through stock purchases

CREATE VIEW [dbo].[Inventory In]
AS
SELECT
	dbo.purchases.purch_id,
	dbo.ingredients.ing_id,
	CONVERT(int, dbo.purchases.quantity * dbo.ingredients.purch_unit / dbo.ingredients.recipe_unit) AS quantity_recipe_unit,
	dbo.purchases.unit_price AS unit_price_purch_unit
FROM dbo.products
INNER JOIN dbo.purchases
	ON dbo.products.prod_id = dbo.purchases.prod_id
INNER JOIN dbo.ingredients
	ON dbo.products.ing_id = dbo.ingredients.ing_id