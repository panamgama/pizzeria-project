-- Creating 'Inventory Data' view
-- Shows current stock remanining of each ingredient

CREATE VIEW [dbo].[Inventory Data]
AS
SELECT
	dbo.ingredients.name AS ingredient,
	dbo.ingredients.purch_unit AS [units purchased in],
	dbo.ingredients.recipe_unit AS [units used in recipes],
	CONVERT(decimal, inv_in.quantity) / dbo.ingredients.purch_unit AS [total in],
	CONVERT(decimal, inv_out.quantity) / dbo.ingredients.purch_unit AS [total out],
	CONVERT(decimal, inv_in.quantity - inv_out.quantity) / dbo.ingredients.purch_unit AS [current stock],
	dbo.WAC_ing.WAC_per_recipe_unit AS [WAC/ recipe unit],
	dbo.WAC_ing.WAC_per_purch_unit AS [WAC/ purchase unit]
FROM (SELECT
	ing_id,
	SUM(quantity_recipe_unit) AS quantity
FROM dbo.[Inventory In]
GROUP BY ing_id) AS inv_in
INNER JOIN (SELECT
	ing_id,
	SUM(quantity_out) AS quantity
FROM dbo.[Inventory Out]
GROUP BY ing_id) AS inv_out
	ON inv_in.ing_id = inv_out.ing_id
INNER JOIN dbo.ingredients
	ON inv_in.ing_id = dbo.ingredients.ing_id
INNER JOIN dbo.WAC_ing
	ON inv_in.ing_id = dbo.WAC_ing.ing_id