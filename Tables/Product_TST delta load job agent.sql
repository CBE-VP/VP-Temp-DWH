
-- Delete job
EXEC jobs.sp_delete_job @job_name='AgentJob_Product_DeltaLoad'
GO
EXEC jobs.sp_add_job @job_name='AgentJob_Product_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Product_DeltaLoad',
@command=N'
INSERT INTO product_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[vp_manufacture]
      ,[producttypecode]
      ,[productstructure]
      ,[isstockitem]
      ,[iskit]
      ,[isreparented]
      ,[vp_productivd]
      ,[subjectid]
      ,[subjectid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[defaultuomid]
      ,[defaultuomid_entitytype]
      ,[createdbyexternalparty]
      ,[createdbyexternalparty_entitytype]
      ,[modifiedbyexternalparty]
      ,[modifiedbyexternalparty_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[parentproductid]
      ,[parentproductid_entitytype]
      ,[pricelevelid]
      ,[pricelevelid_entitytype]
      ,[defaultuomscheduleid]
      ,[defaultuomscheduleid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[price_base]
      ,[currentcost]
      ,[standardcost_base]
      ,[currentcost_base]
      ,[standardcost]
      ,[price]
      ,[productid]
      ,[defaultuomscheduleidname]
      ,[createdonbehalfbyyominame]
      ,[validfromdate]
      ,[organizationidname]
      ,[pricelevelidname]
      ,[vendorname]
      ,[processid]
      ,[producturl]
      ,[name]
      ,[overriddencreatedon]
      ,[defaultuomidname]
      ,[modifiedon]
      ,[entityimage_url]
      ,[productnumber]
      ,[timezoneruleversionnumber]
      ,[entityimage_timestamp]
      ,[modifiedonbehalfbyyominame]
      ,[createdbyname]
      ,[versionnumber]
      ,[dmtimportstate]
      ,[transactioncurrencyidname]
      ,[importsequencenumber]
      ,[createdbyexternalpartyyominame]
      ,[createdon]
      ,[modifiedbyexternalpartyyominame]
      ,[subjectidname]
      ,[utcconversiontimezonecode]
      ,[entityimageid]
      ,[stageid]
      ,[hierarchypath]
      ,[size]
      ,[createdbyexternalpartyname]
      ,[suppliername]
      ,[createdonbehalfbyname]
      ,[modifiedbyname]
      ,[description]
      ,[vendorpartnumber]
      ,[parentproductidname]
      ,[quantitydecimal]
      ,[stockvolume]
      ,[validtodate]
      ,[exchangerate]
      ,[createdbyyominame]
      ,[modifiedbyexternalpartyname]
      ,[modifiedbyyominame]
      ,[modifiedonbehalfbyname]
      ,[vendorid]
      ,[traversedpath]
      ,[quantityonhand]
      ,[stockweight]
        , CAST(GETDATE() as date) [LoadDate]
FROM product
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'
/* Schedule job execution*/   
EXEC jobs.sp_update_job
@job_name='AgentJob_Product_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 20:00'