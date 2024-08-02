--Task 7
--Referring to the attached ERD, 
--return a list of Prescribable Products 
--where the sProductDisplayName begins with ‘BECLOMETASONE’, and the Product has an iMarketStatusID of 1, 
--but one or more of the associated Packs has a different iMarketStatusID.


SELECT 
    p.iID AS PrescribableProductID,
    p.sProductDisplayName,
    p.iMarketStatusID AS ProductMarketStatusID

FROM 
    dbo.SX_PrescribableProduct AS p
	INNER JOIN 
    dbo.SX_linkPack AS lp ON p.iPrescribableProductID = lp.iPrescribableProductID
	INNER JOIN 
    dbo.SX_Pack AS pk ON lp.iDispensiblePackID = pk.iID

WHERE 
    p.sProductDisplayName LIKE 'BECLOMETASONE%' 
    AND p.iMarketStatusID = 1
    AND EXISTS 
	(
        SELECT 1
        FROM 
			dbo.SX_Pack AS pk
        WHERE 
			pk.iDispensiblePackID = lp.iDispensiblePackID
			AND pk.iMarketStatusID <> p.iMarketStatusID
    );
