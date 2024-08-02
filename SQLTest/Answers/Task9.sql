--Task 9
--The Interactions table contains a list of Drug families which interact with each other.  
--Write a query to return these interactions, omitting duplicate records; 
--eg The interaction between iGroupInteractionID1 4 and iGroupInteractionID2 5 would be considered a 
--duplicate record of the interaction between iGroupInteractionID1 5 and iGroupInteractionID2 4. 
--Your result set should therefore only contain one of these rows  (it doesn’t matter which one). 

WITH OrderedInteractions AS (
    SELECT 
        CASE 
            WHEN iGroupInteractionID1 < iGroupInteractionID2 THEN iGroupInteractionID1
            ELSE iGroupInteractionID2
        END AS FirstID,
        CASE 
            WHEN iGroupInteractionID1 < iGroupInteractionID2 THEN iGroupInteractionID2
            ELSE iGroupInteractionID1
        END AS SecondID
    FROM 
        dbo.Interactions
)
SELECT 
    FirstID,
    SecondID
FROM 
    OrderedInteractions
GROUP BY 
    FirstID,
    SecondID
ORDER BY 
    FirstID, 
    SecondID;
