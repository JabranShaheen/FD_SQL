--Task 10
--Using the attached ERD, 
--write a query which returns the Generic iPrescribableProductID, The Generic sProductDisplayName, the Brand/Branded Generic iPrescribableProductID,  the Brand/Branded Generic sProductDisplayName,
--and the number of packs attached to that Brand/Branded Generic, 
--where the Generic has the word SILDENAFIL as part of its  sProductDisplayName. 

--(hint: iRelationshipTypeID  = 2)

--Column1 iPrescribableProductID (Generic)
--Column2 sProductDisplayName (Generic)
--Column3 iPrescribableProductID (Brand/Branded Generic)
--Column4 sProductDisplayName (Brand/Branded Generic)
--Column 5 CountofPacks 


WITH GenericProducts AS (
    SELECT
        p.iID AS GenericPPID,
        p.sProductDisplayName AS Generic_DisplayName
    FROM
        dbo.SX_PrescribableProduct AS p
    WHERE
        p.sProductDisplayName LIKE '%SILDENAFIL%'
),
BrandProducts AS (
    SELECT
        g.GenericPPID,
        g.Generic_DisplayName,
        b.iID AS BrandPPID,
        b.sProductDisplayName AS Brand_DisplayName,
        COUNT(pk.iID) AS CountOfPacks
    FROM
        GenericProducts AS g
    INNER JOIN
        dbo.SX_PrescribableProductRelationship AS r
        ON g.GenericPPID = r.iPrescribableProductFromID
    INNER JOIN
        dbo.SX_PrescribableProduct AS b
        ON r.iPrescribableProductToID = b.iID
    INNER JOIN
        dbo.SX_linkPack AS lp
        ON b.iID = lp.iPrescribableProductID
    INNER JOIN
        dbo.SX_Pack AS pk
        ON lp.iDispensiblePackID = pk.iID
    WHERE
        r.iRelationshipTypeID = 2
    GROUP BY
        g.GenericPPID,
        g.Generic_DisplayName,
        b.iID,
        b.sProductDisplayName
)
SELECT
    GenericPPID,
    Generic_DisplayName,
    BrandPPID,
    Brand_DisplayName,
    CountOfPacks
FROM
    BrandProducts
ORDER BY
    GenericPPID, BrandPPID;
