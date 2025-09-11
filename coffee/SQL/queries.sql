UPDATE coffe_sales
SET store_location = 'Hells Kitchen'
WHERE store_location = 'Hell''s Kitchen';


DROP VIEW IF EXISTS public.sales_vs_forecast;
DROP VIEW IF EXISTS public.forecast_clean;
DROP VIEW IF EXISTS public.fact_sales_by_store_day;


CREATE OR REPLACE VIEW public.fact_sales_by_store_day AS
WITH base AS (
  SELECT
    LOWER(REGEXP_REPLACE(COALESCE(store_location, ''), '[^a-z0-9]+', '', 'g')) AS cleaned,
    DATE_TRUNC('day', transaction_timestamp)::date AS ddate,
    SUM(unit_price * COALESCE(transaction_qty, 1)) AS sales_day,
    SUM(COALESCE(transaction_qty, 1))              AS units_day,
    COUNT(DISTINCT transaction_id)                  AS tx_day
  FROM public.coffe_sales
  GROUP BY 1,2
)
SELECT
  cleaned,
  CASE
    WHEN cleaned LIKE '%ellitchen%'     THEN 'Hells Kitchen'
    WHEN cleaned LIKE '%oweranhattan%'  THEN 'Lower Manhattan'
    WHEN cleaned LIKE '%storia%'        THEN 'Astoria'
    WHEN cleaned LIKE '%ellsitchen%'    THEN 'Hells Kitchen'
    ELSE 'Other'
  END AS store_location_canon,
  ddate,
  sales_day,
  units_day,
  tx_day
FROM base;

CREATE OR REPLACE VIEW public.forecast_clean AS
WITH forecast_base AS (
  SELECT
    LOWER(REGEXP_REPLACE(COALESCE("Location", ''), '[^a-z0-9]+', '', 'g')) AS cleaned,
    ds::date               AS ddate,
    yhat::double precision AS forecast_sales
  FROM public.forescast
),
max_real AS (
  SELECT cleaned, MAX(ddate) AS max_ddate
  FROM public.fact_sales_by_store_day
  GROUP BY cleaned
)
SELECT
  fb.cleaned,
  CASE
    WHEN fb.cleaned LIKE '%ellitchen%'     THEN 'Hells Kitchen'
    WHEN fb.cleaned LIKE '%oweranhattan%'  THEN 'Lower Manhattan'
    WHEN fb.cleaned LIKE '%storia%'        THEN 'Astoria'
    WHEN fb.cleaned LIKE '%ellsitchen%'    THEN 'Hells Kitchen'
    ELSE 'Other'
  END AS store_location_canon,
  fb.ddate,
  fb.forecast_sales
FROM forecast_base fb
LEFT JOIN max_real mr
  ON mr.cleaned = fb.cleaned;

CREATE OR REPLACE VIEW public.sales_vs_forecast AS
SELECT
  COALESCE(a.cleaned, f.cleaned)                          AS cleaned,
  COALESCE(a.store_location_canon, f.store_location_canon) AS store_location,
  COALESCE(a.ddate, f.ddate)                              AS ddate,
  a.sales_day,
  f.forecast_sales
FROM public.fact_sales_by_store_day a
FULL OUTER JOIN public.forecast_clean f
  ON a.cleaned = f.cleaned
 AND a.ddate   = f.ddate;
