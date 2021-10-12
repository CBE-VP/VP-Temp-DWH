
-- Delete job
EXEC jobs.sp_delete_job @job_name='AgentJob_opportunitysalesprocess_DeltaLoad'
GO
EXEC jobs.sp_add_job @job_name='AgentJob_opportunitysalesprocess_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_opportunitysalesprocess_DeltaLoad',
@command=N'
INSERT INTO opportunitysalesprocess_archive
SELECT 
 [Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[quoteid]
      ,[quoteid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[salesorderid]
      ,[salesorderid_entitytype]
      ,[activestageid]
      ,[activestageid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[opportunityid]
      ,[opportunityid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[processid]
      ,[processid_entitytype]
      ,[transactioncurrencyidname]
      ,[modifiedbyyominame]
      ,[createdbyname]
      ,[modifiedon]
      ,[completedon]
      ,[modifiedbyname]
      ,[processidname]
      ,[modifiedonbehalfbyyominame]
      ,[createdonbehalfbyyominame]
      ,[name]
      ,[importsequencenumber]
      ,[modifiedonbehalfbyname]
      ,[versionnumber]
      ,[createdon]
      ,[quoteidname]
      ,[activestagestartedon]
      ,[businessprocessflowinstanceid]
      ,[overriddencreatedon]
      ,[createdonbehalfbyname]
      ,[exchangerate]
      ,[salesorderidname]
      ,[opportunityidname]
      ,[timezoneruleversionnumber]
      ,[activestageidname]
      ,[duration]
      ,[traversedpath]
      ,[createdbyyominame]
      ,[organizationidname]
      ,[utcconversiontimezonecode]
        , CAST(GETDATE() as date) [LoadDate]
FROM opportunitysalesprocess
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'
/* Schedule job execution*/   
EXEC jobs.sp_update_job
@job_name='AgentJob_opportunitysalesprocess_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 20:00'