-- Demo Project: Benz Pizzeria
-- Creating tables as per the model:


SET XACT_ABORT ON

BEGIN TRANSACTION CREATE_TABLES

-- 1
CREATE TABLE [parties] (
    [party_id] int IDENTITY(1,1) NOT NULL ,
    [firstname] varchar(50)  NOT NULL ,
    [lastname] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_parties] PRIMARY KEY CLUSTERED (
        [party_id] ASC
    )
)

-- 2
CREATE TABLE [comms] (
    [comms_id] int IDENTITY(1,1) NOT NULL ,
    [phone] varchar(15)  NOT NULL ,
    [email] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_comms] PRIMARY KEY CLUSTERED (
        [comms_id] ASC
    )
)

-- 3
CREATE TABLE [countries] (
    [country_id] int IDENTITY(1,1) NOT NULL ,
    [name] varchar(15)  NOT NULL ,
    [code] varchar(5)  NOT NULL ,
    CONSTRAINT [PK_countries] PRIMARY KEY CLUSTERED (
        [country_id] ASC
    )
)

-- 4
CREATE TABLE [states] (
    [state_id] int IDENTITY(1,1) NOT NULL ,
    [name] varchar(15)  NOT NULL ,
    [country_id] int  NOT NULL ,
    CONSTRAINT [PK_states] PRIMARY KEY CLUSTERED (
        [state_id] ASC
    )
)

-- 5
CREATE TABLE [adds] (
    [add_id] int IDENTITY(1,1) NOT NULL ,
    [add1] varchar(200)  NOT NULL ,
    [add2] varchar(200)  NULL ,
    [suburb] varchar(50)  NOT NULL ,
    [state_id] int  NOT NULL ,
    [country_id] int  NOT NULL ,
    [zipcode] varchar(10)  NOT NULL ,
    CONSTRAINT [PK_adds] PRIMARY KEY CLUSTERED (
        [add_id] ASC
    )
)

-- 6
CREATE TABLE [categories] (
    [cat_id] int IDENTITY(1,1) NOT NULL ,
    [name] varchar(15)  NOT NULL ,
    CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED (
        [cat_id] ASC
    )
)

-- 7
CREATE TABLE [sizes] (
    [size_id] int IDENTITY(1,1) NOT NULL ,
    [name] varchar(15)  NOT NULL ,
    CONSTRAINT [PK_sizes] PRIMARY KEY CLUSTERED (
        [size_id] ASC
    )
)

-- 8
CREATE TABLE [items] (
    [item_id] int IDENTITY(1,1) NOT NULL ,
    [sku] varchar(10)  NOT NULL ,
    [name] varchar(50)  NOT NULL ,
    [cat_id] int  NOT NULL ,
    [size_id] int  NOT NULL ,
    [price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_items] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

-- 9
CREATE TABLE [staff] (
    [staff_id] int IDENTITY(1,1) NOT NULL ,
    [party_id] int  NOT NULL ,
    [comms_id] int  NOT NULL ,
    [add_id] int  NOT NULL ,
    [position] varchar(10)  NOT NULL ,
    [hourly_rate] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_staff] PRIMARY KEY CLUSTERED (
        [staff_id] ASC
    )
)

-- 10
CREATE TABLE [vendors] (
    [vend_id] int IDENTITY(1,1) NOT NULL ,
    [party_id] int  NOT NULL ,
    [comms_id] int  NOT NULL ,
    [add_id] int  NOT NULL ,
    CONSTRAINT [PK_vendors] PRIMARY KEY CLUSTERED (
        [vend_id] ASC
    )
)

-- 11
CREATE TABLE [manufacturers] (
    [manu_id] int IDENTITY(1,1) NOT NULL ,
    [party_id] int  NOT NULL ,
    [comms_id] int  NOT NULL ,
    [add_id] int  NOT NULL ,
    CONSTRAINT [PK_manufacturers] PRIMARY KEY CLUSTERED (
        [manu_id] ASC
    )
)

-- 12
CREATE TABLE [shifts] (
    [shift_id] int IDENTITY(1,1) NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL ,
    CONSTRAINT [PK_shifts] PRIMARY KEY CLUSTERED (
        [shift_id] ASC
    )
)

-- 13
CREATE TABLE [rotations] (
    [rota_id] int IDENTITY(1,1) NOT NULL ,
    [date] date  NOT NULL ,
    [shift_id] int  NOT NULL ,
    CONSTRAINT [PK_rotations] PRIMARY KEY CLUSTERED (
        [rota_id] ASC
    )
)

-- 14
CREATE TABLE [worklog] (
    [row_id] int IDENTITY(1,1) NOT NULL ,
    [rota_id] int  NOT NULL ,
    [staff_id] int  NOT NULL ,
    CONSTRAINT [PK_worklog] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

-- 15
CREATE TABLE [order_customers] (
    [order_id] int IDENTITY(1,1) NOT NULL ,
	[created_at] datetime NOT NULL,
    [rota_id] int  NOT NULL ,
    [party_id] int  NOT NULL ,
    [comms_id] int  NOT NULL ,
    [add_id] int  NULL ,
    [delivery] bit  NOT NULL ,
    CONSTRAINT [PK_order_customers] PRIMARY KEY CLUSTERED (
        [order_id] ASC
    )
)

-- 16
CREATE TABLE [purchase_vendors] (
    [purch_id] int IDENTITY(1,1) NOT NULL ,
    [vendor_id] int  NOT NULL ,
    [date] date  NOT NULL ,
    CONSTRAINT [PK_purchase_vendors] PRIMARY KEY CLUSTERED (
        [purch_id] ASC
    )
)

-- 17
CREATE TABLE [ingredients] (
    [ing_id] int IDENTITY(1,1) NOT NULL ,
    [name] varchar(50)  NOT NULL ,
	[purch_unit] int  NOT NULL ,
    [recipe_unit] int  NOT NULL ,
    [unit_dim] varchar(10)  NOT NULL ,
    CONSTRAINT [PK_ingredients] PRIMARY KEY CLUSTERED (
        [ing_id] ASC
    )
	-- Can actually bring in purchase and recipe units in this table, 
	-- since it would not change for a given ingredient.
)

-- 18
CREATE TABLE [order_items] (
	-- An order will have multiple items
    [row_id] int IDENTITY(1,1) NOT NULL ,
    [order_id] int  NOT NULL ,
    [item_id] int  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

-- 19
CREATE TABLE [recipes] (
    -- A recipe will have multiple ingredients
    [row_id] int IDENTITY(1,1) NOT NULL ,
    [item_id] int  NOT NULL ,
    [ing_id] int  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_recipes] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

-- 20
CREATE TABLE [products] (
    [prod_id] int IDENTITY(1,1) NOT NULL ,
    [ing_id] int  NOT NULL ,
    [name] varchar(100)  NOT NULL ,
    [manu_id] int  NOT NULL ,
    CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED (
        [prod_id] ASC
    )
)


-- 21
CREATE TABLE [purchases] (
    [row_id] int IDENTITY(1,1) NOT NULL ,
    [purch_id] int  NOT NULL ,
    [prod_id] int  NOT NULL ,
    [unit_price] decimal(5,2)  NOT NULL ,
    [quantity] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_purchases] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

ALTER TABLE [states] WITH CHECK ADD CONSTRAINT [FK_states_country_id] FOREIGN KEY([country_id])
REFERENCES [countries] ([country_id])

ALTER TABLE [states] CHECK CONSTRAINT [FK_states_country_id]

ALTER TABLE [adds] WITH CHECK ADD CONSTRAINT [FK_adds_state_id] FOREIGN KEY([state_id])
REFERENCES [states] ([state_id])

ALTER TABLE [adds] CHECK CONSTRAINT [FK_adds_state_id]

ALTER TABLE [adds] WITH CHECK ADD CONSTRAINT [FK_adds_country_id] FOREIGN KEY([country_id])
REFERENCES [countries] ([country_id])

ALTER TABLE [adds] CHECK CONSTRAINT [FK_adds_country_id]

ALTER TABLE [items] WITH CHECK ADD CONSTRAINT [FK_items_cat_id] FOREIGN KEY([cat_id])
REFERENCES [categories] ([cat_id])

ALTER TABLE [items] CHECK CONSTRAINT [FK_items_cat_id]

ALTER TABLE [items] WITH CHECK ADD CONSTRAINT [FK_items_size_id] FOREIGN KEY([size_id])
REFERENCES [sizes] ([size_id])

ALTER TABLE [items] CHECK CONSTRAINT [FK_items_size_id]

ALTER TABLE [staff] WITH CHECK ADD CONSTRAINT [FK_staff_party_id] FOREIGN KEY([party_id])
REFERENCES [parties] ([party_id])

ALTER TABLE [staff] CHECK CONSTRAINT [FK_staff_party_id]

ALTER TABLE [staff] WITH CHECK ADD CONSTRAINT [FK_staff_comms_id] FOREIGN KEY([comms_id])
REFERENCES [comms] ([comms_id])

ALTER TABLE [staff] CHECK CONSTRAINT [FK_staff_comms_id]

ALTER TABLE [staff] WITH CHECK ADD CONSTRAINT [FK_staff_add_id] FOREIGN KEY([add_id])
REFERENCES [adds] ([add_id])

ALTER TABLE [staff] CHECK CONSTRAINT [FK_staff_add_id]

ALTER TABLE [vendors] WITH CHECK ADD CONSTRAINT [FK_vendors_party_id] FOREIGN KEY([party_id])
REFERENCES [parties] ([party_id])

ALTER TABLE [vendors] CHECK CONSTRAINT [FK_vendors_party_id]

ALTER TABLE [vendors] WITH CHECK ADD CONSTRAINT [FK_vendors_comms_id] FOREIGN KEY([comms_id])
REFERENCES [comms] ([comms_id])

ALTER TABLE [vendors] CHECK CONSTRAINT [FK_vendors_comms_id]

ALTER TABLE [vendors] WITH CHECK ADD CONSTRAINT [FK_vendors_add_id] FOREIGN KEY([add_id])
REFERENCES [adds] ([add_id])

ALTER TABLE [vendors] CHECK CONSTRAINT [FK_vendors_add_id]

ALTER TABLE [manufacturers] WITH CHECK ADD CONSTRAINT [FK_manufacturers_party_id] FOREIGN KEY([party_id])
REFERENCES [parties] ([party_id])

ALTER TABLE [manufacturers] CHECK CONSTRAINT [FK_manufacturers_party_id]

ALTER TABLE [manufacturers] WITH CHECK ADD CONSTRAINT [FK_manufacturers_comms_id] FOREIGN KEY([comms_id])
REFERENCES [comms] ([comms_id])

ALTER TABLE [manufacturers] CHECK CONSTRAINT [FK_manufacturers_comms_id]

ALTER TABLE [manufacturers] WITH CHECK ADD CONSTRAINT [FK_manufacturers_add_id] FOREIGN KEY([add_id])
REFERENCES [adds] ([add_id])

ALTER TABLE [manufacturers] CHECK CONSTRAINT [FK_manufacturers_add_id]

ALTER TABLE [rotations] WITH CHECK ADD CONSTRAINT [FK_rotations_shift_id] FOREIGN KEY([shift_id])
REFERENCES [shifts] ([shift_id])

ALTER TABLE [rotations] CHECK CONSTRAINT [FK_rotations_shift_id]

ALTER TABLE [worklog] WITH CHECK ADD CONSTRAINT [FK_worklog_rota_id] FOREIGN KEY([rota_id])
REFERENCES [rotations] ([rota_id])

ALTER TABLE [worklog] CHECK CONSTRAINT [FK_worklog_rota_id]

ALTER TABLE [worklog] WITH CHECK ADD CONSTRAINT [FK_worklog_staff_id] FOREIGN KEY([staff_id])
REFERENCES [staff] ([staff_id])

ALTER TABLE [worklog] CHECK CONSTRAINT [FK_worklog_staff_id]

ALTER TABLE [order_customers] WITH CHECK ADD CONSTRAINT [FK_order_customers_rota_id] FOREIGN KEY([rota_id])
REFERENCES [rotations] ([rota_id])

ALTER TABLE [order_customers] CHECK CONSTRAINT [FK_order_customers_rota_id]

ALTER TABLE [order_customers] WITH CHECK ADD CONSTRAINT [FK_order_customers_party_id] FOREIGN KEY([party_id])
REFERENCES [parties] ([party_id])

ALTER TABLE [order_customers] CHECK CONSTRAINT [FK_order_customers_party_id]

ALTER TABLE [order_customers] WITH CHECK ADD CONSTRAINT [FK_order_customers_comms_id] FOREIGN KEY([comms_id])
REFERENCES [comms] ([comms_id])

ALTER TABLE [order_customers] CHECK CONSTRAINT [FK_order_customers_comms_id]

ALTER TABLE [order_customers] WITH CHECK ADD CONSTRAINT [FK_order_customers_add_id] FOREIGN KEY([add_id])
REFERENCES [adds] ([add_id])

ALTER TABLE [order_customers] CHECK CONSTRAINT [FK_order_customers_add_id]

ALTER TABLE [purchase_vendors] WITH CHECK ADD CONSTRAINT [FK_purchase_vendors_vendor_id] FOREIGN KEY([vendor_id])
REFERENCES [vendors] ([vend_id])

ALTER TABLE [purchase_vendors] CHECK CONSTRAINT [FK_purchase_vendors_vendor_id]

ALTER TABLE [order_items] WITH CHECK ADD CONSTRAINT [FK_order_items_order_id] FOREIGN KEY([order_id])
REFERENCES [order_customers] ([order_id])

ALTER TABLE [order_items] CHECK CONSTRAINT [FK_order_items_order_id]

ALTER TABLE [order_items] WITH CHECK ADD CONSTRAINT [FK_order_items_item_id] FOREIGN KEY([item_id])
REFERENCES [items] ([item_id])

ALTER TABLE [order_items] CHECK CONSTRAINT [FK_order_items_item_id]

ALTER TABLE [recipes] WITH CHECK ADD CONSTRAINT [FK_recipes_item_id] FOREIGN KEY([item_id])
REFERENCES [items] ([item_id])

ALTER TABLE [recipes] CHECK CONSTRAINT [FK_recipes_item_id]

ALTER TABLE [recipes] WITH CHECK ADD CONSTRAINT [FK_recipes_ing_id] FOREIGN KEY([ing_id])
REFERENCES [ingredients] ([ing_id])

ALTER TABLE [recipes] CHECK CONSTRAINT [FK_recipes_ing_id]

ALTER TABLE [products] WITH CHECK ADD CONSTRAINT [FK_products_ing_id] FOREIGN KEY([ing_id])
REFERENCES [ingredients] ([ing_id])

ALTER TABLE [products] CHECK CONSTRAINT [FK_products_ing_id]

ALTER TABLE [products] WITH CHECK ADD CONSTRAINT [FK_products_manu_id] FOREIGN KEY([manu_id])
REFERENCES [manufacturers] ([manu_id])

ALTER TABLE [products] CHECK CONSTRAINT [FK_products_manu_id]

ALTER TABLE [purchases] WITH CHECK ADD CONSTRAINT [FK_purchases_purch_id] FOREIGN KEY([purch_id])
REFERENCES [purchase_vendors] ([purch_id])

ALTER TABLE [purchases] CHECK CONSTRAINT [FK_purchases_purch_id]

ALTER TABLE [purchases] WITH CHECK ADD CONSTRAINT [FK_purchases_prod_id] FOREIGN KEY([prod_id])
REFERENCES [products] ([prod_id])

ALTER TABLE [purchases] CHECK CONSTRAINT [FK_purchases_prod_id]

COMMIT TRANSACTION CREATE_TABLES
