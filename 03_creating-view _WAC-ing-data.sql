-- Create 'WAC_ing' view
-- WAC stands for Weighted Average Cost of inventory.
-- Since many different purchases at different price points occur,
-- a standard method should be followed for the inventory valuation purposes

CREATE VIEW [dbo].[WAC_ing]
AS
SELECT
	dbo.products.ing_id,
	SUM(dbo.purchases.quantity * dbo.purchases.unit_price) AS total_cost,
	SUM(CONVERT(int, dbo.purchases.quantity / dbo.ingredients.recipe_unit * dbo.ingredients.purch_unit)) AS total_qty_recipe_unit,
	SUM(dbo.purchases.quantity * dbo.purchases.unit_price) / SUM(CONVERT(int, dbo.purchases.quantity / dbo.ingredients.recipe_unit * dbo.ingredients.purch_unit)) AS WAC_per_recipe_unit,
	SUM(dbo.purchases.quantity)
	AS total_qty_purch_unit,
	SUM(dbo.purchases.quantity * dbo.purchases.unit_price) / SUM(dbo.purchases.quantity) AS WAC_per_purch_unit
FROM dbo.products
INNER JOIN dbo.purchases
	ON dbo.products.prod_id = dbo.purchases.prod_id
INNER JOIN dbo.ingredients
	ON dbo.products.ing_id = dbo.ingredients.ing_id
GROUP BY dbo.products.ing_id