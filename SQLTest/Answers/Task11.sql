--Task 11
--The load_log table is populated by a series of Stored Procedures. These stored procedures are run one after the other. 
--Each Stored Procedure will run for its entirety before the next starts. The table contains the following Columns:
--Column name	Description
--Description	Description of the process
--time_stamp	Finish Time
--Status	Outcome of the process
--Write a query to return the duration of each process (excluding the first), returning the following columns:
--Description
--Duration in seconds

WITH ProcessDurations AS 
(
    SELECT
        l1.Description AS CurrentDescription,
        l1.time_stamp AS CurrentTimeStamp,
        l2.time_stamp AS PreviousTimeStamp,
        DATEDIFF(SECOND, l2.time_stamp, l1.time_stamp) AS DurationInSeconds
    FROM
        dbo.load_log AS l1
    INNER JOIN
        dbo.load_log AS l2
        ON l1.time_stamp > l2.time_stamp
        AND l1.time_stamp = 
        (
            SELECT 
                MIN(l3.time_stamp)
            FROM 
                dbo.load_log AS l3
            WHERE 
                l3.time_stamp > l2.time_stamp
        )
)
SELECT
    CurrentDescription AS Description,
    DurationInSeconds AS Duration
FROM
    ProcessDurations
ORDER BY
    CurrentTimeStamp;
