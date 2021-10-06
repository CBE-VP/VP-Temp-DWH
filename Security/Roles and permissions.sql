/*Add a user to a role*/

ALTER ROLE db_datareader ADD MEMBER AllAmericas 
GRANT SELECT ON SCHEMA :: Security TO AllAmericas WITH GRANT OPTION;
ALTER ROLE AllAmericas ADD MEMBER [dsm@visiopharm.com]


/* View roles of each user */

SELECT * -- r.name role_principal_name, m.name AS member_principal_name
FROM sys.database_role_members rm 
JOIN sys.database_principals r 
    ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m 
    ON rm.member_principal_id = m.principal_id
    WHERE 


/* Grant permissions to role*/
ALTER ROLE db_datareader ADD MEMBER AllAmericas


/* Create inline table-valued function*/

CREATE FUNCTION security.fn_SalesAllAmericas(@territory as VARCHAR, @Role as VARCHAR)
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS fn_SalesAllAmericas_Access
    WHERE @territory IN ('West Coast','East Coast','Americas')
    AND @Role IN 
    AND 



CREATE FUNCTION security.fn_SalesSecurity(@UserName AS sysname)
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS fn_SalesSecurity_Result
    -- Logic for filter predicate
    WHERE @UserName = USER_NAME() 


/* Apply the function on the relevant table */ 

ALTER SECURITY POLICY UserFilter
ADD FILTER PREDICATE security.fn_SalesSecurity(fullname) 
ON dbo.systemuser
WITH (STATE = ON);
GO

/* Test the RLS implementation */

EXECUTE AS USER = 'dsm@visiopharm.com';
SELECT top 100 * FROM v_Velocinator_v6
REVERT;


select top 100 * from GlobalOptionSetMetadata

select top 10 * from [dbo].[systemuser]
where fullname = 'Danny Smith'



/* Create table for user-attribute mapping for RLS */ 

CREATE TABLE RLSMapTable (
[WindowsLiveID] VARCHAR(155),
[Territory] VARCHAR(50),
[OpportunitySegment] VARCHAR(50)
)


