Select *
From PortfolioProject1.dbo.HousingData

-- Standardise date format

Select SaleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject1.dbo.HousingData

Update HousingData
SET SaleDate = CONVERT(Date,SaleDate)

ALter table HousingData
Add SaleDateConverted Date;

Update HousingData
SET SaleDateConverted = CONVERT(Date,SaleDate)

-- Populate Property Address

Select *
From PortfolioProject1.dbo.HousingData
--where PropertyAddress is null 
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject1.dbo.HousingData a 
JOIN PortfolioProject1.dbo.HousingData b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null



update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject1.dbo.HousingData a 
JOIN PortfolioProject1.dbo.HousingData b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- Separating the address column
Select PropertyAddress
From PortfolioProject1.dbo.HousingData

select
SUBSTRING (PropertyAddress, 1,CHARINDEX(',', PropertyAddress)- 1) as Address
, SUBSTRING (PropertyAddress,CHARINDEX(',', PropertyAddress)+ 1,LEN(PropertyAddress)) as Address

From PortfolioProject1.dbo.HousingData

ALter table HousingData
Add PropertySplitAddress Nvarchar(255);

Update HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1 )

ALter table HousingData
Add PropertySplitCity Nvarchar(255);

Update HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress))


Select *
From PortfolioProject1.dbo.HousingData

-- Separating the Owner address column

Select
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From PortfolioProject1.dbo.HousingData

ALter table HousingData
Add OwnerSplitAddress Nvarchar(255);

Update HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALter table HousingData
Add OwnerSplitCity Nvarchar(255);

Update HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALter table HousingData
Add OwnerSplitState Nvarchar(255);

Update HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

Select * 
From HousingData

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject1.dbo.HousingData
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
          WHEN SoldAsVacant= 'N' THEN 'No'
		  ELSE SoldAsVacant
		  END
From PortfolioProject1.dbo.HousingData

Update HousingData
Set SoldAsVacant = CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
          WHEN SoldAsVacant= 'N' THEN 'No'
		  ELSE SoldAsVacant
		  END

Select SoldAsVacant
From PortfolioProject1.dbo.HousingData


-- Removing duplicate values

WITH RowNumCTE AS(
Select *,
         ROW_NUMBER() OVER(
		 PARTITION BY ParcelID,
		              PropertyAddress,
					  SalePrice,
					  SaleDate,
					  LegalReference
					  ORDER BY
					  UniqueID
					  ) row_num
From PortfolioProject1.dbo.HousingData
--Order by ParcelID
)


-- Deleting unused columns

Select *
From PortfolioProject1.dbo.HousingData

AlTER TABLE PortfolioProject1.dbo.HousingData
DROP COLUMN OwnerAddress,TaxDistrict, PropertyAddress

AlTER TABLE PortfolioProject1.dbo.HousingData
DROP COLUMN SaleDate