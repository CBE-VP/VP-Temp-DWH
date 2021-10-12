-- Delete job
EXEC jobs.sp_delete_job @job_name='AgentJob_Territory_DeltaLoad'
GO
EXEC jobs.sp_add_job @job_name='AgentJob_Territory_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Territory_DeltaLoad',
@command=N'
INSERT INTO territory_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[parentterritoryid]
      ,[parentterritoryid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[managerid]
      ,[managerid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[transactioncurrencyidname]
      ,[timezoneruleversionnumber]
      ,[modifiedonbehalfbyyominame]
      ,[description]
      ,[versionnumber]
      ,[parentterritoryidname]
      ,[entityimage_timestamp]
      ,[modifiedonbehalfbyname]
      ,[manageridyominame]
      ,[organizationidname]
      ,[overriddencreatedon]
      ,[createdonbehalfbyname]
      ,[modifiedbyname]
      ,[entityimage_url]
      ,[modifiedon]
      ,[createdbyname]
      ,[utcconversiontimezonecode]
      ,[modifiedbyyominame]
      ,[name]
      ,[createdonbehalfbyyominame]
      ,[territoryid]
      ,[createdon]
      ,[exchangerate]
      ,[importsequencenumber]
      ,[entityimageid]
      ,[manageridname]
      ,[createdbyyominame]
        , CAST(GETDATE() as date) [LoadDate]
FROM territory
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'
/* Schedule job execution*/   
EXEC jobs.sp_update_job
@job_name='AgentJob_Territory_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 20:00'