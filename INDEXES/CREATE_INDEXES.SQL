



--==========================================--
----------		NONCLUSTERED INDEX	----------
----------		SQL 2008 O MAYOR  -----------
--==========================================--
CREATE NONCLUSTERED  INDEX idx_nonclustered_product
ON Product (Id)
WITH ( DROP_EXISTING = ON);-->Esta line solo se ejecuta si el index existe  

--==========================================--
----------		CLUSTERED INDEX		----------
----------		SQL 2008 O MAYOR  -----------
--==========================================--
CREATE NONCLUSTERED  INDEX idx_clustered_OrderItem
ON OrderItem (Id)
WITH ( DROP_EXISTING = ON);-->Esta line solo se ejecuta si el index existe  

--==========================================--
----------		COLUMNSTORE INDEX  ----------
----------		SQL 2012 O MAYOR  -----------
--==========================================--
CREATE COLUMNSTORE  INDEX idx_columnstore_Supplier
ON [Supplier] (Id)
WITH ( DROP_EXISTING = ON);-->Esta line solo se ejecuta si el index existe    

