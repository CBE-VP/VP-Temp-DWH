

-- Delete job
EXEC jobs.sp_delete_job @job_name='AgentJob_CompanyType_DeltaLoad'
GO
EXEC jobs.sp_add_job @job_name='AgentJob_CompanyType_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_CompanyType_DeltaLoad',
@command=N'
INSERT INTO vp_companytype_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[vp_parentcompanytypeid]
      ,[vp_parentcompanytypeid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[createdbyyominame]
      ,[organizationidname]
      ,[vp_name]
      ,[createdonbehalfbyyominame]
      ,[modifiedonbehalfbyyominame]
      ,[modifiedbyyominame]
      ,[createdbyname]
      ,[versionnumber]
      ,[vp_parentcompanytypeidname]
      ,[timezoneruleversionnumber]
      ,[vp_companytypeid]
      ,[importsequencenumber]
      ,[modifiedonbehalfbyname]
      ,[modifiedbyname]
      ,[modifiedon]
      ,[overriddencreatedon]
      ,[utcconversiontimezonecode]
      ,[createdonbehalfbyname]
      ,[createdon]
        , CAST(GETDATE() as date) [LoadDate]
FROM vp_companytype
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'
/* Schedule job execution*/   
EXEC jobs.sp_update_job
@job_name='AgentJob_CompanyType_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 20:00'