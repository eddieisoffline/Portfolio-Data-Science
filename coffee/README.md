---
title: "Coffee Sales Performance Dashboard"
slug: "coffee-sales-dashboard"
summary: "Dashboard interactivo para analizar ventas de una cadena de cafeterías en Nueva York con forecast de series temporales."
tools: ["Python", "Prophet", "PostgreSQL", "Supabase", "Looker Studio"]
repo_url: "https://github.com/eddieisoffline/Portfolio-Data-Science/tree/master/coffee"
demo_url: "https://lookerstudio.google.com/reporting/81573f48-4547-4c3a-9543-16c0e4954da9"
cover_image: "https://github.com/eddieisoffline/Portfolio-Data-Science/blob/main/coffee/dashboard/page_1.png"
featured: true
date: "2025-09-13"
---

## Problema

### Español

Una cadena de cafeterías en Nueva York necesitaba una forma clara de monitorear su desempeño comercial, comparar resultados entre tiendas y categorías, y anticipar ventas futuras a partir de datos históricos. La información transaccional existía, pero requería limpieza, modelado y visualización para convertirse en indicadores accionables.

### English

A coffee chain in New York needed a clear way to monitor business performance, compare results across stores and categories, and anticipate future sales from historical data. Transactional data was available, but it required cleaning, modeling, and visualization to become actionable indicators.

## Metodología

### Español

Se procesaron datos transaccionales de ventas con Python para limpiar, agregar y preparar métricas clave como ventas totales, ticket promedio y número de tickets. Después, se construyeron modelos de series temporales con Prophet para generar forecasts de ventas y se almacenaron los resultados en PostgreSQL mediante Supabase, creando vistas para unir ventas reales y predicciones. Finalmente, se diseñó un dashboard interactivo en Looker Studio con vistas ejecutivas, comparativos por tienda, análisis de productos y métricas de precisión como MAPE.

### English

Transactional sales data was processed with Python to clean, aggregate, and prepare key metrics such as total sales, average ticket, and ticket count. Time series models were then built with Prophet to generate sales forecasts, and the results were stored in PostgreSQL through Supabase, using views to combine actual sales and predictions. Finally, an interactive Looker Studio dashboard was designed with executive views, store comparisons, product analysis, and accuracy metrics such as MAPE.

## Resultados

### Español

El proyecto entrega una visualización clara del desempeño actual y del forecast futuro de ventas, permitiendo comparar tiendas como Astoria, Hell's Kitchen y Lower Manhattan. El dashboard facilita la lectura de tendencias, la evaluación de precisión del modelo y el análisis del comportamiento de clientes mediante ticket promedio, detalle de productos y tablas exportables.

### English

The project delivers a clear visualization of current performance and future sales forecasts, enabling comparisons between stores such as Astoria, Hell's Kitchen, and Lower Manhattan. The dashboard makes it easier to read trends, evaluate model accuracy, and analyze customer behavior through average ticket, product detail, and exportable tables.
