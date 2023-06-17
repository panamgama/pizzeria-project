-- Creating Sales Data view
-- Contains summarized information of all sales orders generated in the pizzeria

CREATE VIEW [dbo].[Sales Data]
AS
SELECT
  dbo.order_customers.order_id AS [order ID],
  dbo.order_customers.rota_id,
  dbo.order_customers.created_at AS [created at],
  { FN CONCAT({ FN CONCAT(dbo.items.name, ' - ') }, dbo.sizes.name) } AS item,
  { FN CONCAT(UPPER(LEFT(dbo.categories.name, 1)), RIGHT(dbo.categories.name, LEN(dbo.categories.name) - 1)) } AS category,
  dbo.items.price,
  dbo.order_items.quantity,
  CASE
    WHEN delivery = 1 THEN 'Delivery'
    ELSE 'Pickup'
  END AS [delivery/ pickup],
  dbo.adds.add1 AS [address line],
  { FN CONCAT({ FN CONCAT(dbo.adds.suburb, ',  ') }, dbo.countries.name) } AS place
FROM dbo.order_customers
INNER JOIN dbo.order_items
  ON dbo.order_customers.order_id = dbo.order_items.order_id
INNER JOIN dbo.adds
  ON dbo.order_customers.add_id = dbo.adds.add_id
INNER JOIN dbo.items
  ON dbo.order_items.item_id = dbo.items.item_id
INNER JOIN dbo.categories
  ON dbo.items.cat_id = dbo.categories.cat_id
INNER JOIN dbo.sizes
  ON dbo.items.size_id = dbo.sizes.size_id
INNER JOIN dbo.countries
  ON dbo.adds.country_id = dbo.countries.country_id
INNER JOIN dbo.states
  ON dbo.adds.state_id = dbo.states.state_id
  AND dbo.countries.country_id = dbo.states.country_id