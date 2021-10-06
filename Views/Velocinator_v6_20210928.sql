SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Velocinator_v6] AS 

WITH CTE_ResidualExcelInput as (
-- SELECT DISTINCT because DSM ran full loads every time he extracted data, i.e. the exact same record exists multiple times

SELECT  
CONCAT([Do_Not_Modify_Opportunity],[Modified_On]) as IDKey
FROM [file_imports].[CRM_Archive_CBE] 
WHERE DATEPART(ww,modified_on) > 39 AND DATEPART(year,modified_on) > 2019

EXCEPT 

SELECT 
CONCAT(id,CAST(modifiedon as date)) as IDKey
FROM opportunity_archive
)

,CTE_FilterOnMostRecentExportDate as (
-- MAX(Data): Used for cases of multiple records on same modified_on date. Then we choose the record of the most recent export date.
-- Put in a separate CTE to not affect the previous CTE as it will then return too many records resulting in identical start dates later in tehe query
SELECT  
CONCAT([Do_Not_Modify_Opportunity],[Modified_On]) as IDKey,
MAX(Data) OVER (PARTITION BY Do_Not_Modify_Opportunity, do_not_modify_modified_on) as MostRecentExportOrLoad
FROM [file_imports].[CRM_Archive_CBE] cbe
JOIN CTE_ResidualExcelInput cte on CONCAT(Do_Not_Modify_Opportunity,Do_Not_Modify_Modified_On) = cte.IDKey
 
)

,CTE_Area AS(
SELECT
op.Id AS opportunityid, 
su.fullname as Owner, 
ter.[Name] as Territory,
CASE 
	WHEN ter.[name] IN ('Nordics','United Kingdom','Europe North','Europe South','DACH','Europe') 
	THEN 'EU'
	WHEN ter.[name] IN ('West coast','East coast','Americas')
	THEN 'US'
	--ELSE 'APAC'
	END AS 'Area'
FROM opportunity_archive op 
LEFT JOIN systemuser su on op.ownerid = su.Id 
LEFT JOIN territory ter on su.territoryid = ter.id
)

,CTE_Logic AS(
SELECT  
op.id as OpportunityID,
op.vp_opportunityidnumber as OpportunityIDNumber,
CAST(op.createdon as date) as [Created Date],
CAST(op.modifiedon as date) as [Modified Date],
CASE 
    WHEN vp_close_date IS NULL 
    THEN CAST(estimatedclosedate as date)
    WHEN estimatedclosedate IS NULL 
    THEN CAST(actualclosedate as date)
    ELSE CAST(vp_close_date as date)
    END AS [Closed Date],
LoadDate,
sys.fullname as Owner, 
cte.Area, 
cte.Territory,
/*CASE 
	WHEN sys.fullname = 'Dan Hoerich' AND CTE.Area = 'East Coast'
	THEN 'Americas East'
	WHEN sys.fullname = 'Dan Hoerich' AND CTE.Area = 'West Coast'
	THEN 'Americas West'
	ELSE CONCAT(gosm2.LocalizedLabel,' ',CTE.Area)
	END AS Team, */
CASE 
	WHEN gosm2.LocalizedLabel = 'Translational'
	THEN CONCAT('Clinical ',Area)
  	WHEN gosm2.LocalizedLabel IS NULL 
    THEN Area   
    ELSE CONCAT(gosm2.LocalizedLabel,' ',CTE.Area)
	END AS Pod, 
gosm.LocalizedLabel as [Order Type],
gosm1.LocalizedLabel as [Sales Type],
gosm2.LocalizedLabel as [Opportunity Segment],
gosm3.LocalizedLabel as [Origin Of Opportunity],
gosm4.LocalizedLabel as [Funnel Status],
osm2.LocalizedLabel as [Forecast Category],
stmd.LocalizedLabel as Status,
op.name as Topic,
vp_grossprofit_base as [GrossProfit (Base)],
vp_bonusvalue_base as [BonusValue (Base)],
CASE
	WHEN gosm4.LocalizedLabel = '1-Qualified Suspect'
	THEN 0
	WHEN gosm4.LocalizedLabel = '2-Qualified Sponsor'
	THEN 10
	WHEN gosm4.LocalizedLabel = '3-Qualified Power Sponsor'
	THEN 30
	WHEN gosm4.LocalizedLabel = '4-Decision Due'
	THEN 60
	WHEN gosm4.LocalizedLabel = '5-Pending Sale'
	THEN 90
	WHEN gosm4.LocalizedLabel = '6-Won'
	THEN 0
	END AS [Velocinator Score],
'App' as Source 
FROM opportunity_archive op
LEFT JOIN OptionSetMetadata osm2 on osm2.[Option] = op.msdyn_forecastcategory and osm2.optionsetname = 'msdyn_forecastcategory'
LEFT JOIN StateMetadata stmd on op.statecode = stmd.State and stmd.EntityName = 'opportunity'
LEFT JOIN GlobalOptionSetMetadata gosm on op.vp_ordertype = gosm.[Option] and gosm.OptionSetName = 'vp_ordertype' 
LEFT JOIN GlobalOptionSetMetadata gosm1 on op.vp_ordertype = gosm1.[Option] and gosm1.OptionSetName = 'vp_salestype' 
LEFT JOIN GlobalOptionSetMetadata gosm2 on op.vp_opportunitysegment = gosm2.[Option] and gosm2.OptionSetName = 'vp_opportunitysegment' 
LEFT JOIN GlobalOptionSetMetadata gosm3 on op.vp_originofopportunity = gosm3.[Option] and gosm3.OptionSetName = 'vp_originofopportunity' 
LEFT JOIN GlobalOptionSetMetadata gosm4 on op.vp_funnelstatus = gosm4.[Option] and gosm4.OptionSetName = 'vp_funnelstatus' 
LEFT JOIN systemuser sys on op.ownerid = sys.id
LEFT JOIN CTE_Area cte on op.opportunityid = cte.opportunityid

 
UNION 


SELECT DISTINCT
Do_Not_Modify_Opportunity as OpportunityID,
'None' as OpportunityIDNumber,
Created_On as [Created Date],
Modified_on as [Modified Date],
Actual_Close_Date as [Closed Date],
MAX(Data) OVER (PARTITION BY Do_Not_Modify_Opportunity, Modified_on) as LoadDate,
Owner, 
Area, 
Territory,
--Team,
Pod, 
[Order_type] as [Order type],
[Sales_type] as [Sales type],
[Opportunity_segment] as [Opportunity segment],
[Origin_of_Opportunity] as [Origin of Opportunity],
[Funnel_Status] as [Funnel Status],
[Forecast_Category] as [Forecast Category],
[Status],
[Topic],
[Gross_Profit_Base] as [GrossProfit (Base)],
[Bonus_Value_Base] as [BonusValue (Base)],
[Velocinator_Score] as [Velocinator Score],
'Excel' as Source 
FROM file_imports.CRM_Archive_CBE cbe
JOIN [CTE_FilterOnMostRecentExportDate] ctef on CONCAT(Do_Not_Modify_Opportunity,Do_Not_Modify_Modified_On) = ctef.IDKey AND cbe.data = ctef.MostRecentExportOrLoad
)


,CTE_Dates as (
-- PARTITION by 'Team' left our for now because the team exists only in Excel
SELECT DISTINCT 
OpportunityID,
MIN([Modified Date]) OVER (PARTITION BY OpportunityID,Area,owner,pod, [Order type],[sales type],[opportunity segment],[origin of opportunity],[Funnel status],[Forecast category], Status,[Closed Date],[GrossProfit (Base)],[BonusValue (Base)], [Velocinator score]) as [Start Date]
FROM CTE_Logic

)


,CTE_EndDate AS (
SELECT DISTINCT 
/* Choose only distinct rows based on the first modified date on otherwise identical view rows*/
ctef.OpportunityID,
OpportunityIDNumber,
[start date],
LEAD([start Date]) OVER (PARTITION BY ctef.OpportunityID ORDER BY [Start date]) AS [End Date],
RANK() OVER (PARTITION BY ctef.OpportunityID ORDER BY [Modified Date]) AS ModifiedDateRank,
[Created Date],
[Closed Date],
LoadDate,
Owner,
Area,
Territory,
Pod,
--Team, 
[Order Type],
[Sales Type],
[Opportunity Segment],
[Origin Of Opportunity],
[Funnel Status],
[Forecast Category],
Status,
Topic,
[GrossProfit (Base)],
[BonusValue (Base)],
[Velocinator Score],
Source 
FROM CTE_Logic ctef
JOIN CTE_Dates cted on ctef.OpportunityID = cted.OpportunityID AND ctef.[Modified Date] = cted.[Start Date]
--WHERE  [Owner] IS NOT NULL 
)

/*Below CASE WHEN's are implemented to avoid summation problems in DAX measures */

SELECT 
OpportunityID,
OpportunityIDNumber,
CASE
    WHEN [ModifiedDateRank] = 1 
    THEN [Created Date]
    ELSE [Start Date] 
    END AS [Start Date],
[LoadDate],
CASE 
    WHEN [End Date] IS NOT NULL 
    THEN DATEADD(d,-1,[End Date])
    ELSE CAST(GETDATE() AS Date)
    END AS [End Date],
[Created Date],
[Closed Date],
Owner,
Area,
Territory,
--Team,
Pod,
CASE 
    WHEN [Order Type] IS NULL
    THEN 'No order type'
    ELSE [Order Type]
    END AS [Order Type],
CASE 
    WHEN [Sales Type] IS NULL
    THEN 'No sales type'
    ELSE [Sales Type]
    END AS [Sales Type],
CASE 
    WHEN [Opportunity Segment] IS NULL
    THEN 'No opportunity segment'
    ELSE [Opportunity Segment]
    END AS [Opportunity Segment],
CASE 
    WHEN [Origin of Opportunity] IS NULL
    THEN 'No origin of opportunity'
    ELSE [Origin of Opportunity]
    END AS [Origin of Opportunity],
CASE 
    WHEN [Funnel Status] IS NULL
    THEN 'No funnel status'
    ELSE [Funnel Status]
    END AS [Funnel Status],
CASE 
    WHEN [Forecast Category] IS NULL
    THEN 'No forecast category'
    ELSE [Forecast Category]
    END AS [Forecast Category],
Status,
Topic,
[GrossProfit (Base)],
[BonusValue (Base)],
[Velocinator Score],
Source 
FROM CTE_EndDate
--WHERE [Closed Date] >= '2020-10-01' OR [Closed Date] IS NULL 

GO
