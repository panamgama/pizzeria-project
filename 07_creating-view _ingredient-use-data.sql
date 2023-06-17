-- Creating 'Ingredient Use Data' view
-- Contains rotation id, date, order id, item,category, ingredient and total quantity columns

CREATE VIEW [dbo].[Ingredient Use Data]
AS
SELECT	dbo.order_customers.rota_id AS [rotation id], 
		dbo.rotations.date, 
		dbo.order_customers.order_id AS [order id], 
		{ fn CONCAT({ fn CONCAT(dbo.items.name, ' - ') }, dbo.sizes.name) } AS item, 
        { fn CONCAT(UPPER(LEFT(dbo.categories.name, 1)), RIGHT(dbo.categories.name, LEN(dbo.categories.name) - 1)) } AS category,
		dbo.ingredients.name AS ingredient,
		dbo.order_items.quantity * dbo.recipes.quantity AS [total quantity]
FROM	dbo.order_customers
			INNER JOIN dbo.order_items 
				ON dbo.order_customers.order_id = dbo.order_items.order_id 
			INNER JOIN dbo.recipes 
				ON dbo.order_items.item_id = dbo.recipes.item_id
			INNER JOIN dbo.items 
				ON dbo.order_items.item_id = dbo.items.item_id AND dbo.recipes.item_id = dbo.items.item_id
			INNER JOIN dbo.categories 
				ON dbo.items.cat_id = dbo.categories.cat_id 
			INNER JOIN dbo.sizes 
				ON dbo.items.size_id = dbo.sizes.size_id
			INNER JOIN dbo.ingredients
				ON dbo.recipes.ing_id = dbo.ingredients.ing_id 
			INNER JOIN dbo.WAC_ing 
				ON dbo.ingredients.ing_id = dbo.WAC_ing.ing_id
			INNER JOIN dbo.rotations 
				ON dbo.order_customers.rota_id = dbo.rotations.rota_id