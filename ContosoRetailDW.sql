
/***********Task7:Selling Product under each subcategory category and Quarter and yearly based on the Country**********/
/***********Creator: Megan**************************************/
USE [ContosoRetailDW]
GO


IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_ProductTopSellCategoryYear]'))
DROP VIEW [dbo].[V_ProductTopSellCategoryYear] 
GO

/*********Object: view [dbo].[V_ProductTopSellCategoryYear] ********/

Create view [dbo].[V_ProductTopSellCategoryYear]
AS

Select DimProduct.ProductName,Sum(FactSales.SalesAmount) as SumRevenue,
Sum(FactSales.SalesQuantity-FactSales.ReturnQuantity-FactSales.DiscountQuantity) as SumQuantity,
DimProductSubCategory.ProductSubCategoryName As Subcategory,
DimProductCategory.ProductCategoryKey AS CategoryKey,
DimProductCategory.ProductCategoryName as Category,
DimDate.FiscalQuarterLabel AS FiscalQuarter,DimDate.FiscalYear AS FiscalYear,
DimGeography.RegionCountryName

 from FactSales inner Join DimProduct on FactSales.ProductKey=DimProduct.ProductKey
inner join DimProductSubcategory on DimProduct.ProductSubcategoryKey=DimProductSubcategory.ProductSubcategoryKey
 inner join DimProductCategory on DimProductSubcategory.ProductSubcategoryKey=DimProductCategory.ProductCategoryKey
 Inner join DimDate on FactSales.DateKey=DimDate.DateKey 
 Inner join DimStore on FactSales.Storekey=DimStore.StoreKey 
 Inner join DimGeography on DimStore.GeographyKey=DimGeography.GeographyKey
 

group by DimProduct.ProductName,DimProductSubCategory.ProductSubcategoryName,DimProductCategory.ProductCategoryName,
DimProductCategory.ProductCategoryKey,DimDate.FiscalQuarterLabel,DimDate.FiscalYear,DimGeography.RegionCountryName
GO

