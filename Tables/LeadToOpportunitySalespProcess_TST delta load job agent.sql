EXEC jobs.sp_delete_job @job_name='AgentJob_leadtoopportunitysalesprocess_DeltaLoad'
GO
EXEC jobs.sp_add_job @job_name='AgentJob_leadtoopportunitysalesprocess_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_leadtoopportunitysalesprocess_DeltaLoad',
@command=N'
INSERT INTO leadtoopportunitysalesprocess_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[leadid]
      ,[leadid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[opportunityid]
      ,[opportunityid_entitytype]
      ,[activestageid]
      ,[activestageid_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[processid]
      ,[processid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[createdonbehalfbyyominame]
      ,[organizationidname]
      ,[name]
      ,[modifiedbyyominame]
      ,[overriddencreatedon]
      ,[modifiedon]
      ,[activestageidname]
      ,[timezoneruleversionnumber]
      ,[modifiedonbehalfbyname]
      ,[leadidyominame]
      ,[versionnumber]
      ,[modifiedonbehalfbyyominame]
      ,[processidname]
      ,[createdbyname]
      ,[transactioncurrencyidname]
      ,[importsequencenumber]
      ,[completedon]
      ,[createdon]
      ,[utcconversiontimezonecode]
      ,[duration]
      ,[opportunityidname]
      ,[createdonbehalfbyname]
      ,[modifiedbyname]
      ,[businessprocessflowinstanceid]
      ,[leadidname]
      ,[exchangerate]
      ,[createdbyyominame]
      ,[activestagestartedon]
      ,[traversedpath]
        , CAST(GETDATE() as date) [LoadDate]
FROM leadtoopportunitysalesprocess
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'
/* Schedule job execution*/   
EXEC jobs.sp_update_job
@job_name='AgentJob_leadtoopportunitysalesprocess_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 20:00'
