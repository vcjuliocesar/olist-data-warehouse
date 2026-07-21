SELECT 'customers' AS entity,
(SELECT COUNT(*) FROM staging.stg_customers) AS staging_count,
(SELECT COUNT(*) FROM intermediate.int_customers) AS intermediate_count,
(SELECT COUNT(*) FROM marts.dim_customers) AS mart_count,
(SELECT COUNT(*) FROM staging.stg_customers) 
	- (SELECT COUNT(*) FROM intermediate.int_customers) AS diff_staging_vs_intermediate,
(SELECT COUNT(*) FROM intermediate.int_customers)
	- (SELECT COUNT(*) FROM marts.dim_customers) AS diff_intermediate_vs_dim,
(
	(SELECT COUNT(*) FROM staging.stg_customers) 
	<>
	(SELECT COUNT(*) FROM intermediate.int_customers)
	OR
	(SELECT COUNT(*) FROM intermediate.int_customers)
	<>
	(SELECT COUNT(*) FROM marts.dim_customers)
) AS has_mismatch


UNION ALL

SELECT 
'products',
(SELECT COUNT(*) FROM staging.stg_products),
(SELECT COUNT(*) FROM intermediate.int_products),
(SELECT COUNT(*) FROM marts.dim_products),
(SELECT COUNT(*) FROM staging.stg_products)
	- (SELECT COUNT(*) FROM intermediate.int_products),
(SELECT COUNT(*) FROM intermediate.int_products)
	- (SELECT COUNT(*) FROM marts.dim_products),
(
	(SELECT COUNT(*) FROM staging.stg_products)
	<>
	(SELECT COUNT(*) FROM intermediate.int_products)
	OR
	(SELECT COUNT(*) FROM intermediate.int_products)
	<>
	(SELECT COUNT(*) FROM marts.dim_products)
)

UNION ALL

SELECT 
'sellers',
(SELECT COUNT(*) FROM staging.stg_sellers),
(SELECT COUNT(*) FROM intermediate.int_sellers),
(SELECT COUNT(*) FROM marts.dim_sellers),
(SELECT COUNT(*) FROM staging.stg_sellers)
	- (SELECT COUNT(*) FROM intermediate.int_sellers),
(SELECT COUNT(*) FROM intermediate.int_sellers)
	- (SELECT COUNT(*) FROM marts.dim_sellers),
(
	(SELECT COUNT(*) FROM staging.stg_sellers)
	<>
	(SELECT COUNT(*) FROM intermediate.int_sellers)
	OR
	(SELECT COUNT(*) FROM intermediate.int_sellers)
	<>
	(SELECT COUNT(*) FROM marts.dim_sellers)
)
