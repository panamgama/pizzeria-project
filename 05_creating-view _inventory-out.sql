-- Creating Inventory Out view
-- Ingredients are used when orders are fulfilled
-- order_items and recipe tables, solely focusing on ingredients

CREATE VIEW [dbo].[Inventory Out]
AS
SELECT
	dbo.order_items.order_id,
	dbo.recipes.ing_id,
	dbo.recipes.quantity * dbo.order_items.quantity AS quantity_out
FROM dbo.order_items
INNER JOIN dbo.recipes
	ON dbo.order_items.item_id = dbo.recipes.item_id