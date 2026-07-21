WITH conteo_staging AS (
    SELECT COUNT(*) AS total_stg_customers
    FROM staging.stg_customers
),
conteo_intermediate AS (
    SELECT COUNT(*) AS total_int_customers
    FROM intermediate.int_customers
),
conteo_dim AS (
    SELECT COUNT(*) AS total_dim_customers
    FROM marts.dim_customers
)
SELECT
    s.total_stg_customers,
    i.total_int_customers,
    d.total_dim_customers,
    s.total_stg_customers - i.total_int_customers AS diff_staging_vs_intermediate,
    i.total_int_customers - d.total_dim_customers AS diff_intermediate_vs_dim,
    (
        s.total_stg_customers <> i.total_int_customers
        OR i.total_int_customers <> d.total_dim_customers
    ) AS has_mismatch
FROM conteo_staging s
CROSS JOIN conteo_intermediate i
CROSS JOIN conteo_dim d;