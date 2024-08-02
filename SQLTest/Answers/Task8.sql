--Task 8
--Referring to the attached ERD, return all Packs in the SX_Pack table with an  sPackDisplayName starting with 'SILDENAFIL tablets’.  
--Using the iPackPrice and fPackSize columns, include a calculation of the price per tablet, 
--and a column which ranks the returned records based on the price per tablet in descending order.  
--Only return the top 5 most expensive packs.  Note: there should be no gaps in the ranking.


WITH PackDetails AS (
    SELECT 
        p.iID AS PackID,
        p.sPackDisplayName,
        p.iPackPrice,
        p.fPackSize,
        CASE 
            WHEN p.fPackSize > 0 THEN p.iPackPrice / p.fPackSize
            ELSE NULL
        END AS PricePerTablet
    FROM 
        dbo.SX_Pack AS p
    WHERE 
        p.sPackDisplayName LIKE 'SILDENAFIL tablets%'
),
RankedPacks AS (
    SELECT 
        PackID,
        sPackDisplayName,
        iPackPrice,
        fPackSize,
        PricePerTablet,
        ROW_NUMBER() OVER (ORDER BY PricePerTablet DESC) AS Rank
    FROM 
        PackDetails
)
SELECT 
    PackID,
    sPackDisplayName,
    iPackPrice,
    fPackSize,
    PricePerTablet,
    Rank
FROM 
    RankedPacks
WHERE 
    Rank <= 5
ORDER BY 
    Rank;
