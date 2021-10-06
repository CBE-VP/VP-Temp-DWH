--Connect to the job database specified when creating the job agent

--Add job for updating table with new or changed rows

/*

EXEC jobs.sp_delete_job @job_name='AgentJob_Opportunity_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_Team_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_LeadToOpportunitySalesprocess_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_SalesOrder_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_CompanyType_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_CountDistinctRows_BaseArchive';
EXEC jobs.sp_delete_job @job_name='AgentJob_SystemUser_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_Territory_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_Quote_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_OpportunitySalesProcess_DeltaLoad';
EXEC jobs.sp_delete_job @job_name='AgentJob_Organization_DeltaLoad_Prod';

*/


EXEC jobs.sp_update_job
@job_name='AgentJob_ControlUniqueIDCounts_Prod',
--@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210529 21:00'



EXEC jobs.sp_start_job 'AgentJob_Account_DeltaLoad_Prod';
SELECT * FROM jobs.job_executions
WHERE is_active = 1
ORDER BY start_time DESC;


EXEC jobs.sp_add_job @job_name='AgentJob_DELETE_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_DELETE_Prod',
@command=N'
INSERT INTO DELETE_Account_archive
SELECT *
FROM account 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'


*/




EXEC jobs.sp_delete_job @job_name='AgentJob_Account_Deltaload_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Account_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Account_DeltaLoad_Prod',
@command=N'
INSERT INTO Account_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[accountratingcode]
      ,[address1_addresstypecode]
      ,[vp_imagemodalities]
      ,[preferredappointmentdaycode]
      ,[vp_pacsintegration]
      ,[address1_shippingmethodcode]
      ,[vp_smscategory]
      ,[accountcategorycode]
      ,[vp_softwareuse]
      ,[vp_vnaintegration]
      ,[address1_freighttermscode]
      ,[vp_imsintegration]
      ,[preferredappointmenttimecode]
      ,[accountclassificationcode]
      ,[customersizecode]
      ,[ownershipcode]
      ,[address2_freighttermscode]
      ,[preferredcontactmethodcode]
      ,[industrycode]
      ,[shippingmethodcode]
      ,[paymenttermscode]
      ,[businesstypecode]
      ,[address2_addresstypecode]
      ,[customertypecode]
      ,[vp_profonlinesupportbalance]
      ,[address2_shippingmethodcode]
      ,[vp_lisintegration]
      ,[territorycode]
      ,[donotpostalmail]
      ,[vp_ivdcustomer]
      ,[creditonhold]
      ,[donotbulkpostalmail]
      ,[vp_ivdapp]
      ,[donotbulkemail]
      ,[donotfax]
      ,[donotemail]
      ,[followemail]
      ,[participatesinworkflow]
      ,[vp_taxexempt]
      ,[marketingonly]
      ,[isprivate]
      ,[merged]
      ,[donotphone]
      ,[donotsendmm]
      ,[vp_ivdscanner]
      ,[vp_synctohubspot]
      ,[msa_managingpartnerid]
      ,[msa_managingpartnerid_entitytype]
      ,[slainvokedid]
      ,[slainvokedid_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[originatingleadid]
      ,[originatingleadid_entitytype]
      ,[vp_address1_countryid]
      ,[vp_address1_countryid_entitytype]
      ,[territoryid]
      ,[territoryid_entitytype]
      ,[slaid]
      ,[slaid_entitytype]
      ,[parentaccountid]
      ,[parentaccountid_entitytype]
      ,[primarycontactid]
      ,[primarycontactid_entitytype]
      ,[preferredequipmentid]
      ,[preferredequipmentid_entitytype]
      ,[owningbusinessunit]
      ,[owningbusinessunit_entitytype]
      ,[owningteam]
      ,[owningteam_entitytype]
      ,[vp_owningdistributoraccountid]
      ,[vp_owningdistributoraccountid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[owninguser]
      ,[owninguser_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[vp_companysubtypeid]
      ,[vp_companysubtypeid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[vp_address2_countryid]
      ,[vp_address2_countryid_entitytype]
      ,[modifiedbyexternalparty]
      ,[modifiedbyexternalparty_entitytype]
      ,[masterid]
      ,[masterid_entitytype]
      ,[defaultpricelevelid]
      ,[defaultpricelevelid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[createdbyexternalparty]
      ,[createdbyexternalparty_entitytype]
      ,[preferredserviceid]
      ,[preferredserviceid_entitytype]
      ,[preferredsystemuserid]
      ,[preferredsystemuserid_entitytype]
      ,[vp_companytypeid]
      ,[vp_companytypeid_entitytype]
      ,[ownerid]
      ,[ownerid_entitytype]
      ,[aging90]
      ,[openrevenue]
      ,[aging30]
      ,[marketcap]
      ,[aging60_base]
      ,[vp_smscost_base]
      ,[creditlimit]
      ,[openrevenue_base]
      ,[creditlimit_base]
      ,[aging60]
      ,[aging30_base]
      ,[revenue]
      ,[revenue_base]
      ,[vp_smscost]
      ,[aging90_base]
      ,[marketcap_base]
      ,[emailaddress3]
      ,[emailaddress2]
      ,[emailaddress1]
      ,[masteraccountidyominame]
      ,[address1_city]
      ,[vp_supportremaining]
      ,[address1_line1]
      ,[adx_createdbyipaddress]
      ,[modifiedon]
      ,[vp_customercenteraccountlogin]
      ,[websiteurl]
      ,[address1_longitude]
      ,[entityimage_timestamp]
      ,[vp_companysubtypeidname]
      ,[sharesoutstanding]
      ,[adx_modifiedbyusername]
      ,[primarycontactidname]
      ,[transactioncurrencyidname]
      ,[preferredsystemuseridyominame]
      ,[telephone1]
      ,[opendeals_date]
      ,[modifiedbyexternalpartyyominame]
      ,[masteraccountidname]
      ,[preferredsystemuseridname]
      ,[address2_stateorprovince]
      ,[address2_line2]
      ,[vp_customercenteraccountname]
      ,[address1_line3]
      ,[name]
      ,[onholdtime]
      ,[parentaccountidname]
      ,[originatingleadidname]
      ,[address1_utcoffset]
      ,[numberofemployees]
      ,[modifiedbyexternalpartyname]
      ,[address1_telephone1]
      ,[vp_owningdistributoraccountidname]
      ,[exchangerate]
      ,[address2_county]
      ,[vp_bedrockwakeup]
      ,[telephone3]
      ,[fax]
      ,[address2_city]
      ,[vp_trainingcomments]
      ,[address2_latitude]
      ,[createdon]
      ,[vp_sharepointnumber]
      ,[timespentbymeonemailandmeetings]
      ,[address1_composite]
      ,[opendeals_state]
      ,[address2_postalcode]
      ,[lastusedincampaign]
      ,[accountnumber]
      ,[owneridyominame]
      ,[entityimage_url]
      ,[teamsfollowed]
      ,[address2_line3]
      ,[description]
      ,[vp_smsexpiry]
      ,[timezoneruleversionnumber]
      ,[address1_county]
      ,[createdbyname]
      ,[vp_onsitetrainingdays]
      ,[address2_postofficebox]
      ,[address2_telephone1]
      ,[address2_telephone2]
      ,[address2_telephone3]
      ,[originatingleadidyominame]
      ,[adx_createdbyusername]
      ,[address1_addressid]
      ,[traversedpath]
      ,[territoryidname]
      ,[yominame]
      ,[createdonbehalfbyname]
      ,[address2_name]
      ,[openrevenue_state]
      ,[address1_country]
      ,[primarysatoriid]
      ,[owneridtype]
      ,[entityimageid]
      ,[adx_modifiedbyipaddress]
      ,[primarytwitterid]
      ,[owneridname]
      ,[modifiedonbehalfbyname]
      ,[overriddencreatedon]
      ,[address2_composite]
      ,[address1_stateorprovince]
      ,[msa_managingpartneridname]
      ,[preferredserviceidname]
      ,[accountid]
      ,[vp_trainingbalance]
      ,[vp_department]
      ,[createdbyexternalpartyyominame]
      ,[vp_swversion]
      ,[vp_crmurllink]
      ,[address1_telephone2]
      ,[address1_telephone3]
      ,[address1_postofficebox]
      ,[createdonbehalfbyyominame]
      ,[slainvokedidname]
      ,[address2_country]
      ,[sic]
      ,[vp_vatno]
      ,[address2_utcoffset]
      ,[vp_eanno]
      ,[address2_fax]
      ,[address2_longitude]
      ,[vp_owningdistributoraccountidyominame]
      ,[ftpsiteurl]
      ,[preferredequipmentidname]
      ,[address1_primarycontactname]
      ,[modifiedbyyominame]
      ,[lastonholdtime]
      ,[address1_line2]
      ,[openrevenue_date]
      ,[address2_upszone]
      ,[vp_address1_countryidname]
      ,[address1_postalcode]
      ,[tickersymbol]
      ,[stageid]
      ,[utcconversiontimezonecode]
      ,[createdbyexternalpartyname]
      ,[vp_address2_countryidname]
      ,[defaultpricelevelidname]
      ,[msa_managingpartneridyominame]
      ,[stockexchange]
      ,[address2_addressid]
      ,[vp_smscomment]
      ,[telephone2]
      ,[importsequencenumber]
      ,[versionnumber]
      ,[vp_academytrainings]
      ,[address1_name]
      ,[address1_fax]
      ,[address1_latitude]
      ,[primarycontactidyominame]
      ,[vp_companytypeidname]
      ,[modifiedbyname]
      ,[createdbyyominame]
      ,[address2_line1]
      ,[address1_upszone]
      ,[modifiedonbehalfbyyominame]
      ,[slaname]
      ,[processid]
      ,[parentaccountidyominame]
      ,[address2_primarycontactname]
      ,[opendeals]
	  , CAST(GETDATE() as date) [LoadDate]
FROM account 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Account_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210515 21:00'

---------------------------------------------

EXEC jobs.sp_delete_job @job_name='AgentJob_BusinessUnit_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_BusinessUnit_DeltaLoad_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_BusinessUnit_DeltaLoad_Prod',
@command=N'
INSERT INTO businessunit_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[address1_addresstypecode]
      ,[address1_shippingmethodcode]
      ,[address2_shippingmethodcode]
      ,[address2_addresstypecode]
      ,[workflowsuspended]
      ,[isdisabled]
      ,[parentbusinessunitid]
      ,[parentbusinessunitid_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[calendarid]
      ,[calendarid_entitytype]
      ,[organizationid]
      ,[organizationid_entitytype]
      ,[ftpsiteurl]
      ,[divisionname]
      ,[address2_latitude]
      ,[address1_stateorprovince]
      ,[usergroupid]
      ,[address1_postofficebox]
      ,[createdbyyominame]
      ,[websiteurl]
      ,[name]
      ,[address2_utcoffset]
      ,[createdbyname]
      ,[createdonbehalfbyyominame]
      ,[utcoffset]
      ,[address2_line2]
      ,[modifiedon]
      ,[address1_line1]
      ,[address1_telephone2]
      ,[address2_country]
      ,[modifiedbyname]
      ,[address1_utcoffset]
      ,[address2_telephone1]
      ,[address2_telephone2]
      ,[address2_telephone3]
      ,[disabledreason]
      ,[address1_postalcode]
      ,[tickersymbol]
      ,[businessunitid]
      ,[address2_upszone]
      ,[modifiedonbehalfbyname]
      ,[address2_longitude]
      ,[address2_line1]
      ,[costcenter]
      ,[fileasname]
      ,[stockexchange]
      ,[versionnumber]
      ,[address1_upszone]
      ,[importsequencenumber]
      ,[modifiedbyyominame]
      ,[address1_city]
      ,[address1_line3]
      ,[address2_city]
      ,[address1_telephone3]
      ,[address1_line2]
      ,[picture]
      ,[address2_line3]
      ,[address1_telephone1]
      ,[modifiedonbehalfbyyominame]
      ,[address1_country]
      ,[organizationidname]
      ,[emailaddress]
      ,[address1_latitude]
      ,[address2_county]
      ,[address2_stateorprovince]
      ,[address1_name]
      ,[address2_postofficebox]
      ,[overriddencreatedon]
      ,[exchangerate]
      ,[createdon]
      ,[inheritancemask]
      ,[parentbusinessunitidname]
      ,[address2_fax]
      ,[address1_county]
      ,[description]
      ,[transactioncurrencyidname]
      ,[address1_longitude]
      ,[address1_addressid]
      ,[address2_name]
      ,[address2_addressid]
      ,[address2_postalcode]
      ,[creditlimit]
      ,[address1_fax]
      ,[createdonbehalfbyname]
	  , CAST(GETDATE() as date) [LoadDate]
FROM businessunit 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'


/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_BusinessUnit_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210515 21:00'

---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_Contact_DeltaLoad_Prod'
GO


EXEC jobs.sp_add_job @job_name='AgentJob_Contact_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Contact_DeltaLoad_Prod',
@command=N'
INSERT INTO contact_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[address1_shippingmethodcode]
      ,[vp_contactsource]
      ,[address2_shippingmethodcode]
      ,[msdyn_orgchangestatus]
      ,[address1_freighttermscode]
      ,[vp_salutation]
      ,[shippingmethodcode]
      ,[preferredappointmenttimecode]
      ,[preferredcontactmethodcode]
      ,[address3_freighttermscode]
      ,[territorycode]
      ,[accountrolecode]
      ,[address2_freighttermscode]
      ,[leadsourcecode]
      ,[haschildrencode]
      ,[gendercode]
      ,[vp_forwardcustomertypecode]
      ,[customertypecode]
      ,[address2_addresstypecode]
      ,[vp_jobfunction]
      ,[educationcode]
      ,[address3_shippingmethodcode]
      ,[customersizecode]
      ,[paymenttermscode]
      ,[address3_addresstypecode]
      ,[familystatuscode]
      ,[preferredappointmentdaycode]
      ,[address1_addresstypecode]
      ,[adx_confirmremovepassword]
      ,[vp_newcontactimport]
      ,[merged]
      ,[followemail]
      ,[adx_profilealert]
      ,[msdyn_isminorwithparentalconsent]
      ,[donotfax]
      ,[adx_identity_logonenabled]
      ,[adx_profileisanonymous]
      ,[isbackofficecustomer]
      ,[adx_identity_locallogindisabled]
      ,[donotemail]
      ,[msdyn_disablewebtracking]
      ,[isautocreate]
      ,[donotpostalmail]
      ,[vp_hubspotunsubscribedfromallemail]
      ,[adx_identity_emailaddress1confirmed]
      ,[isprivate]
      ,[vp_synctohubspot]
      ,[donotbulkemail]
      ,[adx_identity_lockoutenabled]
      ,[msdyn_isminor]
      ,[donotsendmm]
      ,[donotphone]
      ,[adx_identity_twofactorenabled]
      ,[creditonhold]
      ,[vp_activeonopportunity]
      ,[adx_identity_mobilephoneconfirmed]
      ,[marketingonly]
      ,[donotbulkpostalmail]
      ,[vp_mqlreached]
      ,[participatesinworkflow]
      ,[msdyn_gdproptout]
      ,[parentcontactid]
      ,[parentcontactid_entitytype]
      ,[originatingleadid]
      ,[originatingleadid_entitytype]
      ,[owningbusinessunit]
      ,[owningbusinessunit_entitytype]
      ,[defaultpricelevelid]
      ,[defaultpricelevelid_entitytype]
      ,[slainvokedid]
      ,[slainvokedid_entitytype]
      ,[owningteam]
      ,[owningteam_entitytype]
      ,[owninguser]
      ,[owninguser_entitytype]
      ,[msa_managingpartnerid]
      ,[msa_managingpartnerid_entitytype]
      ,[preferredsystemuserid]
      ,[preferredsystemuserid_entitytype]
      ,[parent_contactid]
      ,[parent_contactid_entitytype]
      ,[accountid]
      ,[accountid_entitytype]
      ,[modifiedbyexternalparty]
      ,[modifiedbyexternalparty_entitytype]
      ,[vp_address3_countryid]
      ,[vp_address3_countryid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[createdbyexternalparty]
      ,[createdbyexternalparty_entitytype]
      ,[slaid]
      ,[slaid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[vp_address2_countryid]
      ,[vp_address2_countryid_entitytype]
      ,[adx_preferredlanguageid]
      ,[adx_preferredlanguageid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[vp_address1_countryid]
      ,[vp_address1_countryid_entitytype]
      ,[preferredserviceid]
      ,[preferredserviceid_entitytype]
      ,[masterid]
      ,[masterid_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[preferredequipmentid]
      ,[preferredequipmentid_entitytype]
      ,[ownerid]
      ,[ownerid_entitytype]
      ,[parentcustomerid]
      ,[parentcustomerid_entitytype]
      ,[aging60]
      ,[creditlimit_base]
      ,[aging30]
      ,[aging30_base]
      ,[annualincome]
      ,[aging90_base]
      ,[creditlimit]
      ,[aging60_base]
      ,[aging90]
      ,[annualincome_base]
      ,[overriddencreatedon]
      ,[createdbyname]
      ,[address3_postofficebox]
      ,[createdbyexternalpartyyominame]
      ,[vp_recentconversion_hubspot]
      ,[address2_telephone3]
      ,[teamsfollowed]
      ,[address3_telephone2]
      ,[address2_upszone]
      ,[createdonbehalfbyyominame]
      ,[adx_createdbyipaddress]
      ,[parentcustomeridtype]
      ,[parentcustomeridyominame]
      ,[externaluseridentifier]
      ,[pager]
      ,[mobilephone]
      ,[numberofchildren]
      ,[mastercontactidyominame]
      ,[address2_stateorprovince]
      ,[adx_createdbyusername]
      ,[createdbyyominame]
      ,[address2_line3]
      ,[adx_preferredlanguageidname]
      ,[address2_latitude]
      ,[fax]
      ,[address1_line3]
      ,[address3_utcoffset]
      ,[vp_address1_countryidname]
      ,[address3_county]
      ,[transactioncurrencyidname]
      ,[vp_hubspotleadsource]
      ,[managername]
      ,[adx_identity_lastsuccessfullogin]
      ,[address1_telephone3]
      ,[address2_name]
      ,[onholdtime]
      ,[assistantname]
      ,[address3_postalcode]
      ,[adx_identity_lockoutenddate]
      ,[address1_postalcode]
      ,[businesscard]
      ,[address1_line1]
      ,[department]
      ,[adx_organizationname]
      ,[createdbyexternalpartyname]
      ,[vp_numberofactiveopportunities_state]
      ,[modifiedonbehalfbyname]
      ,[yomifirstname]
      ,[preferredequipmentidname]
      ,[address3_primarycontactname]
      ,[parent_contactidyominame]
      ,[modifiedbyyominame]
      ,[address2_city]
      ,[address2_country]
      ,[traversedpath]
      ,[address3_telephone1]
      ,[childrensnames]
      ,[ftpsiteurl]
      ,[address1_county]
      ,[owneridyominame]
      ,[address3_addressid]
      ,[defaultpricelevelidname]
      ,[modifiedbyname]
      ,[mastercontactidname]
      ,[entityimageid]
      ,[address3_line3]
      ,[address3_country]
      ,[address2_telephone1]
      ,[address2_telephone2]
      ,[parentcustomeridname]
      ,[slaname]
      ,[emailaddress2]
      ,[utcconversiontimezonecode]
      ,[vp_numberofactiveopportunities]
      ,[callback]
      ,[vp_address2_countryidname]
      ,[salutation]
      ,[address3_composite]
      ,[adx_profilealertdate]
      ,[birthdate]
      ,[address1_primarycontactname]
      ,[address1_utcoffset]
      ,[createdon]
      ,[address1_longitude]
      ,[yomifullname]
      ,[telephone2]
      ,[address2_longitude]
      ,[address2_line1]
      ,[websiteurl]
      ,[emailaddress3]
      ,[emailaddress1]
      ,[employeeid]
      ,[vp_leadscore_hubspot]
      ,[owneridtype]
      ,[address1_fax]
      ,[preferredsystemuseridname]
      ,[description]
      ,[address2_primarycontactname]
      ,[address2_postofficebox]
      ,[address3_telephone3]
      ,[firstname]
      ,[msa_managingpartneridname]
      ,[processid]
      ,[address3_fax]
      ,[subscriptionid]
      ,[address2_addressid]
      ,[governmentid]
      ,[adx_modifiedbyipaddress]
      ,[business2]
      ,[middlename]
      ,[address1_city]
      ,[adx_identity_passwordhash]
      ,[address1_stateorprovince]
      ,[originatingleadidyominame]
      ,[entityimage_timestamp]
      ,[modifiedon]
      ,[address3_line1]
      ,[vp_address3_countryidname]
      ,[msdyn_portaltermsagreementdate]
      ,[accountidyominame]
      ,[versionnumber]
      ,[vp_hubspottimelinelink]
      ,[preferredserviceidname]
      ,[address3_upszone]
      ,[adx_profilealertinstructions]
      ,[address3_city]
      ,[yomilastname]
      ,[address3_latitude]
      ,[adx_identity_securitystamp]
      ,[adx_identity_accessfailedcount]
      ,[address1_composite]
      ,[entityimage_url]
      ,[address2_postalcode]
      ,[parentcontactidyominame]
      ,[address3_line2]
      ,[company]
      ,[adx_identity_newpassword]
      ,[telephone3]
      ,[address2_utcoffset]
      ,[vp_becamemqldate]
      ,[vp_numberofactiveopportunities_date]
      ,[lastusedincampaign]
      ,[address2_fax]
      ,[preferredsystemuseridyominame]
      ,[address1_upszone]
      ,[suffix]
      ,[modifiedbyexternalpartyname]
      ,[adx_publicprofilecopy]
      ,[yomimiddlename]
      ,[msa_managingpartneridyominame]
      ,[address1_telephone1]
      ,[address1_telephone2]
      ,[telephone1]
      ,[address2_line2]
      ,[adx_identity_username]
      ,[address1_addressid]
      ,[adx_timezone]
      ,[address2_county]
      ,[spousesname]
      ,[owneridname]
      ,[address1_latitude]
      ,[address2_composite]
      ,[parentcontactidname]
      ,[createdonbehalfbyname]
      ,[stageid]
      ,[address3_stateorprovince]
      ,[vp_accountsmsexpiry]
      ,[exchangerate]
      ,[vp_bedrockwakeup]
      ,[jobtitle]
      ,[managerphone]
      ,[adx_modifiedbyusername]
      ,[lastonholdtime]
      ,[adx_profilelastactivity]
      ,[address1_name]
      ,[address1_postofficebox]
      ,[adx_profilemodifiedon]
      ,[businesscardattributes]
      ,[address1_line2]
      ,[timespentbymeonemailandmeetings]
      ,[importsequencenumber]
      ,[nickname]
      ,[timezoneruleversionnumber]
      ,[address1_country]
      ,[anniversary]
      ,[parent_contactidname]
      ,[address3_longitude]
      ,[address3_name]
      ,[fullname]
      ,[lastname]
      ,[modifiedonbehalfbyyominame]
      ,[originatingleadidname]
      ,[accountidname]
      ,[modifiedbyexternalpartyyominame]
      ,[slainvokedidname]
      ,[contactid]
      ,[home2]
      ,[assistantphone]
	  , CAST(GETDATE() as date) [LoadDate]
FROM contact 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Contact_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'

---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_Goal_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Goal_DeltaLoad_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Goal_DeltaLoad_Prod',
@command=N'
INSERT INTO goal_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[fiscalperiod]
      ,[amountdatatype]
      ,[fiscalyear]
      ,[consideronlygoalownersrecords]
      ,[isfiscalperiodgoal]
      ,[isoverride]
      ,[rolluponlyfromchildgoals]
      ,[isoverridden]
      ,[isamount]
      ,[rollupqueryinprogressintegerid]
      ,[rollupqueryinprogressintegerid_entitytype]
      ,[parentgoalid]
      ,[parentgoalid_entitytype]
      ,[rollupqueryactualdecimalid]
      ,[rollupqueryactualdecimalid_entitytype]
      ,[goalwitherrorid]
      ,[goalwitherrorid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[rollupquerycustommoneyid]
      ,[rollupquerycustommoneyid_entitytype]
      ,[rollupquerycustomdecimalid]
      ,[rollupquerycustomdecimalid_entitytype]
      ,[metricid]
      ,[metricid_entitytype]
      ,[goalownerid]
      ,[goalownerid_entitytype]
      ,[rollupqueryactualintegerid]
      ,[rollupqueryactualintegerid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[rollupquerycustomintegerid]
      ,[rollupquerycustomintegerid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[owningteam]
      ,[owningteam_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[rollupqueryactualmoneyid]
      ,[rollupqueryactualmoneyid_entitytype]
      ,[owninguser]
      ,[owninguser_entitytype]
      ,[owningbusinessunit]
      ,[owningbusinessunit_entitytype]
      ,[rollupqueryinprogressmoneyid]
      ,[rollupqueryinprogressmoneyid_entitytype]
      ,[rollupqueryinprogressdecimalid]
      ,[rollupqueryinprogressdecimalid_entitytype]
      ,[ownerid]
      ,[ownerid_entitytype]
      ,[customrollupfieldmoney_base]
      ,[inprogressmoney_base]
      ,[actualmoney_base]
      ,[actualmoney]
      ,[computedtargetasoftodaymoney]
      ,[stretchtargetmoney_base]
      ,[targetmoney_base]
      ,[customrollupfieldmoney]
      ,[inprogressmoney]
      ,[stretchtargetmoney]
      ,[computedtargetasoftodaymoney_base]
      ,[targetmoney]
      ,[title]
      ,[targetstring]
      ,[entityimage_timestamp]
      ,[createdon]
      ,[modifiedonbehalfbyyominame]
      ,[percentage]
      ,[rollupqueryinprogressintegeridname]
      ,[actualinteger]
      ,[owneridtype]
      ,[treeid]
      ,[depth]
      ,[stretchtargetinteger]
      ,[modifiedbyname]
      ,[rollupqueryinprogressmoneyidname]
      ,[lastrolledupdate]
      ,[rollupqueryinprogressdecimalidname]
      ,[parentgoalidname]
      ,[goalowneridtype]
      ,[overriddencreatedon]
      ,[rollupquerycustommoneyidname]
      ,[rollupqueryactualintegeridname]
      ,[createdonbehalfbyyominame]
      ,[exchangerate]
      ,[customrollupfielddecimal]
      ,[computedtargetasoftodayinteger]
      ,[goalwitherroridname]
      ,[goalowneridname]
      ,[goalowneridyominame]
      ,[timezoneruleversionnumber]
      ,[targetdecimal]
      ,[rollupquerycustomdecimalidname]
      ,[customrollupfieldstring]
      ,[actualstring]
      ,[versionnumber]
      ,[stretchtargetdecimal]
      ,[metricidname]
      ,[goalid]
      ,[utcconversiontimezonecode]
      ,[rollupqueryactualdecimalidname]
      ,[rolluperrorcode]
      ,[modifiedon]
      ,[importsequencenumber]
      ,[owneridyominame]
      ,[computedtargetasoftodaydecimal]
      ,[entityimageid]
      ,[createdbyname]
      ,[inprogressdecimal]
      ,[createdonbehalfbyname]
      ,[rollupquerycustomintegeridname]
      ,[goalstartdate]
      ,[inprogressinteger]
      ,[rollupqueryactualmoneyidname]
      ,[targetinteger]
      ,[actualdecimal]
      ,[transactioncurrencyidname]
      ,[goalenddate]
      ,[inprogressstring]
      ,[owneridname]
      ,[modifiedonbehalfbyname]
      ,[entityimage_url]
      ,[computedtargetasoftodaypercentageachieved]
      ,[stretchtargetstring]
      ,[customrollupfieldinteger]
	  , CAST(GETDATE() as date) [LoadDate]
FROM goal 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Goal_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'

---------------------------------------------

EXEC jobs.sp_delete_job @job_name='AgentJob_Lead_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Lead_DeltaLoad_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Lead_DeltaLoad_Prod',
@command=N'
INSERT INTO lead_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[address1_shippingmethodcode]
      ,[leadqualitycode]
      ,[industrycode]
      ,[leadsourcecode]
      ,[address2_shippingmethodcode]
      ,[vp_originofopportunity]
      ,[budgetstatus]
      ,[purchaseprocess]
      ,[purchasetimeframe]
      ,[need]
      ,[vp_salutationoption]
      ,[vp_source]
      ,[salesstage]
      ,[vp_leadsegment]
      ,[preferredcontactmethodcode]
      ,[prioritycode]
      ,[salesstagecode]
      ,[vp_jobfunction]
      ,[address2_addresstypecode]
      ,[address1_addresstypecode]
      ,[initialcommunication]
      ,[confirminterest]
      ,[vp_synctohubspot]
      ,[decisionmaker]
      ,[vp_mqlreached]
      ,[donotpostalmail]
      ,[evaluatefit]
      ,[donotbulkemail]
      ,[donotphone]
      ,[msdyn_gdproptout]
      ,[donotsendmm]
      ,[isprivate]
      ,[isautocreate]
      ,[merged]
      ,[donotfax]
      ,[donotemail]
      ,[followemail]
      ,[participatesinworkflow]
      ,[vp_hubspotunsubscribedfromallemail]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[relatedobjectid]
      ,[relatedobjectid_entitytype]
      ,[parentcontactid]
      ,[parentcontactid_entitytype]
      ,[vp_companysubtypeid]
      ,[vp_companysubtypeid_entitytype]
      ,[vp_address1_countryid]
      ,[vp_address1_countryid_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[slainvokedid]
      ,[slainvokedid_entitytype]
      ,[accountid]
      ,[accountid_entitytype]
      ,[originatingcaseid]
      ,[originatingcaseid_entitytype]
      ,[owninguser]
      ,[owninguser_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[vp_companytypeid]
      ,[vp_companytypeid_entitytype]
      ,[parentaccountid]
      ,[parentaccountid_entitytype]
      ,[slaid]
      ,[slaid_entitytype]
      ,[qualifyingopportunityid]
      ,[qualifyingopportunityid_entitytype]
      ,[masterid]
      ,[masterid_entitytype]
      ,[owningbusinessunit]
      ,[owningbusinessunit_entitytype]
      ,[contactid]
      ,[contactid_entitytype]
      ,[owningteam]
      ,[owningteam_entitytype]
      ,[campaignid]
      ,[campaignid_entitytype]
      ,[vp_address2_countryid]
      ,[vp_address2_countryid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[ownerid]
      ,[ownerid_entitytype]
      ,[customerid]
      ,[customerid_entitytype]
      ,[revenue]
      ,[estimatedamount]
      ,[revenue_base]
      ,[budgetamount_base]
      ,[budgetamount]
      ,[estimatedamount_base]
      ,[address2_postalcode]
      ,[relatedobjectidname]
      ,[vp_hubspotleadsource]
      ,[pager]
      ,[address1_county]
      ,[overriddencreatedon]
      ,[qualifyingopportunityidname]
      ,[entityimageid]
      ,[address2_longitude]
      ,[address2_line3]
      ,[middlename]
      ,[transactioncurrencyidname]
      ,[address1_upszone]
      ,[processid]
      ,[leadid]
      ,[address1_stateorprovince]
      ,[fullname]
      ,[emailaddress2]
      ,[emailaddress1]
      ,[owneridyominame]
      ,[vp_bedrockwakeup]
      ,[yomicompanyname]
      ,[exchangerate]
      ,[estimatedvalue]
      ,[parentcontactidname]
      ,[address1_line2]
      ,[vp_leadscore_hubspot]
      ,[jobtitle]
      ,[address1_postofficebox]
      ,[numberofemployees]
      ,[address1_utcoffset]
      ,[address2_stateorprovince]
      ,[telephone1]
      ,[firstname]
      ,[modifiedon]
      ,[customeridyominame]
      ,[createdon]
      ,[yomimiddlename]
      ,[yomilastname]
      ,[subject]
      ,[schedulefollowup_prospect]
      ,[address2_utcoffset]
      ,[modifiedbyyominame]
      ,[parentaccountidyominame]
      ,[yomifullname]
      ,[modifiedbyname]
      ,[contactidyominame]
      ,[businesscardattributes]
      ,[salutation]
      ,[entityimage_url]
      ,[address2_country]
      ,[websiteurl]
      ,[vp_leadsourcedescription]
      ,[address2_line2]
      ,[vp_companytypeidname]
      ,[address2_fax]
      ,[address1_city]
      ,[fax]
      ,[timezoneruleversionnumber]
      ,[createdonbehalfbyyominame]
      ,[masterleadidyominame]
      ,[contactidname]
      ,[vp_address2_countryidname]
      ,[address2_composite]
      ,[owneridtype]
      ,[address1_name]
      ,[address1_postalcode]
      ,[parentaccountidname]
      ,[schedulefollowup_qualify]
      ,[qualificationcomments]
      ,[campaignidname]
      ,[mobilephone]
      ,[entityimage_timestamp]
      ,[address2_name]
      ,[emailaddress3]
      ,[address1_latitude]
      ,[yomifirstname]
      ,[masterleadidname]
      ,[teamsfollowed]
      ,[versionnumber]
      ,[address1_country]
      ,[telephone2]
      ,[lastusedincampaign]
      ,[address1_line3]
      ,[vp_becamemqldate]
      ,[lastname]
      ,[timespentbymeonemailandmeetings]
      ,[createdonbehalfbyname]
      ,[estimatedclosedate]
      ,[address2_postofficebox]
      ,[parentcontactidyominame]
      ,[vp_hubspottimelinelink]
      ,[accountidname]
      ,[vp_sharepointnumber]
      ,[slaname]
      ,[address1_composite]
      ,[sic]
      ,[address2_line1]
      ,[lastonholdtime]
      ,[modifiedonbehalfbyname]
      ,[address1_telephone2]
      ,[address1_telephone3]
      ,[description]
      ,[stageid]
      ,[originatingcaseidname]
      ,[address1_longitude]
      ,[utcconversiontimezonecode]
      ,[address1_telephone1]
      ,[address1_addressid]
      ,[address2_city]
      ,[address2_latitude]
      ,[traversedpath]
      ,[address2_addressid]
      ,[onholdtime]
      ,[address1_line1]
      ,[businesscard]
      ,[companyname]
      ,[createdbyyominame]
      ,[owneridname]
      ,[address2_telephone1]
      ,[address2_telephone2]
      ,[address2_telephone3]
      ,[customeridname]
      ,[vp_companysubtypeidname]
      ,[customeridtype]
      ,[createdbyname]
      ,[slainvokedidname]
      ,[vp_sourcecomments]
      ,[address2_upszone]
      ,[accountidyominame]
      ,[vp_address1_countryidname]
      ,[modifiedonbehalfbyyominame]
      ,[address1_fax]
      ,[importsequencenumber]
      ,[vp_recentconversion_hubspot]
      ,[telephone3]
      ,[address2_county]
      ,[vp_mqlreachedchangeddate]
	  , CAST(GETDATE() as date) [LoadDate]
FROM lead 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Lead_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------


EXEC jobs.sp_add_job @job_name='AgentJob_LeadToOpportunitySalesProcess_DeltaLoad_Prod'
GO
EXEC jobs.sp_delete_job @job_name='AgentJob_LeadToOpportunitySalesProcess_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_LeadToOpportunitySalesProcess_DeltaLoad_Prod',
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
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_LeadToOpportunitySalesProcess_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_Opportunity_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Opportunity_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Opportunity_DeltaLoad_Prod',
@command=N'
INSERT INTO opportunity_archive
SELECT 
[Id]
      ,[SinkCreatedOn]
      ,[SinkModifiedOn]
      ,[statecode]
      ,[statuscode]
      ,[vp_sowagreed]
      ,[vp_productfocus]
      ,[vp_sowissued]
      ,[vp_partnersource]
      ,[initialcommunication]
      ,[vp_distributor]
      ,[purchasetimeframe]
      ,[vp_source]
      ,[vp_development]
      ,[opportunityratingcode]
      ,[salesstage]
      ,[vp_funnelstatus]
      ,[vp_estimateofeffortagreed]
      ,[vp_projectquestionnairereceived]
      ,[vp_projectquestionnairesent]
      ,[vp_originofopportunity]
      ,[vp_ordertype]
      ,[vp_salestype]
      ,[skippricecalculation]
      ,[vp_estimateofeffortsent]
      ,[timeline]
      ,[msdyn_forecastcategory]
      ,[budgetstatus]
      ,[pricingerrorcode]
      ,[prioritycode]
      ,[vp_opportunitysegment]
      ,[purchaseprocess]
      ,[salesstagecode]
      ,[need]
      ,[vp_pmfocus]
      ,[vp_applicationsegment]
      ,[presentfinalproposal]
      ,[completeinternalreview]
      ,[developproposal]
      ,[isrevenuesystemcalculated]
      ,[confirminterest]
      ,[presentproposal]
      ,[completefinalproposal]
      ,[identifypursuitteam]
      ,[pursuitdecision]
      ,[vp_pocplanagreed]
      ,[sendthankyounote]
      ,[identifycompetitors]
      ,[evaluatefit]
      ,[filedebrief]
      ,[vp_verbalapprovalreceived]
      ,[vp_3rdpartyitemsincluded]
      ,[captureproposalfeedback]
      ,[participatesinworkflow]
      ,[decisionmaker]
      ,[vp_bidmanagementinvolvement]
      ,[isprivate]
      ,[resolvefeedback]
      ,[identifycustomercontacts]
      ,[vp_painadmitted]
      ,[vp_synctohubspot]
      ,[contactid]
      ,[contactid_entitytype]
      ,[slaid]
      ,[slaid_entitytype]
      ,[accountid]
      ,[accountid_entitytype]
      ,[vp_territoryid]
      ,[vp_territoryid_entitytype]
      ,[owningbusinessunit]
      ,[owningbusinessunit_entitytype]
      ,[parentcontactid]
      ,[parentcontactid_entitytype]
      ,[parentaccountid]
      ,[parentaccountid_entitytype]
      ,[pricelevelid]
      ,[pricelevelid_entitytype]
      ,[modifiedby]
      ,[modifiedby_entitytype]
      ,[owningteam]
      ,[owningteam_entitytype]
      ,[owninguser]
      ,[owninguser_entitytype]
      ,[slainvokedid]
      ,[slainvokedid_entitytype]
      ,[vp_createdbyid]
      ,[vp_createdbyid_entitytype]
      ,[createdonbehalfby]
      ,[createdonbehalfby_entitytype]
      ,[transactioncurrencyid]
      ,[transactioncurrencyid_entitytype]
      ,[modifiedonbehalfby]
      ,[modifiedonbehalfby_entitytype]
      ,[campaignid]
      ,[campaignid_entitytype]
      ,[originatingleadid]
      ,[originatingleadid_entitytype]
      ,[createdby]
      ,[createdby_entitytype]
      ,[msa_partneroppid]
      ,[msa_partneroppid_entitytype]
      ,[msa_partnerid]
      ,[msa_partnerid_entitytype]
      ,[ownerid]
      ,[ownerid_entitytype]
      ,[customerid]
      ,[customerid_entitytype]
      ,[budgetamount_base]
      ,[vp_bonusvalue]
      ,[vp_bonusvaluetechsales_base]
      ,[freightamount]
      ,[totaltax]
      ,[discountamount_base]
      ,[vp_bonusvaluetechsales]
      ,[totallineitemamount_base]
      ,[vp_grossprofit_base]
      ,[vp_servicevalue]
      ,[vp_bonusvalue_base]
      ,[totaldiscountamount]
      ,[freightamount_base]
      ,[estimatedvalue]
      ,[actualvalue_base]
      ,[totalamountlessfreight_base]
      ,[totalamountlessfreight]
      ,[totallineitemamount]
      ,[vp_servicevalue_base]
      ,[actualvalue]
      ,[vp_bonusvalueremaining_base]
      ,[vp_firstyearsubscriptionvalue_base]
      ,[vp_grossprofit]
      ,[totallineitemdiscountamount_base]
      ,[budgetamount]
      ,[estimatedvalue_base]
      ,[totaldiscountamount_base]
      ,[totallineitemdiscountamount]
      ,[totalamount]
      ,[totalamount_base]
      ,[vp_bonusvalueremaining]
      ,[discountamount]
      ,[totaltax_base]
      ,[vp_firstyearsubscriptionvalue]
      ,[finaldecisiondate]
      ,[modifiedon]
      ,[contactidname]
      ,[transactioncurrencyidname]
      ,[campaignidname]
      ,[vp_salessupportperc]
      ,[vp_statuslastmodifiedby]
      ,[vp_commentopportunity]
      ,[customerpainpoints]
      ,[quotecomments]
      ,[msa_partneridname]
      ,[vp_statuslastmodifiedon]
      ,[owneridyominame]
      ,[customerneed]
      ,[estimatedclosedate]
      ,[parentaccountidname]
      ,[originatingleadidname]
      ,[versionnumber]
      ,[contactidyominame]
      ,[name]
      ,[parentaccountidyominame]
      ,[exchangerate]
      ,[vp_bedrockwakeup]
      ,[proposedsolution]
      ,[createdon]
      ,[vp_sharepointnumber]
      ,[vp_laststagechange_date]
      ,[customeridyominame]
      ,[actualclosedate]
      ,[qualificationcomments]
      ,[customeridtype]
      ,[vp_opportunityidnumber]
      ,[onholdtime]
      ,[processid]
      ,[teamsfollowed]
      ,[description]
      ,[timezoneruleversionnumber]
      ,[stepname]
      ,[accountidname]
      ,[vp_createdbyidname]
      ,[originatingleadidyominame]
      ,[traversedpath]
      ,[vp_lastactivity]
      ,[vp_close_date]
      ,[msa_partneroppidname]
      ,[schedulefollowup_qualify]
      ,[owneridtype]
      ,[msa_partneroppidyominame]
      ,[timespentbymeonemailandmeetings]
      ,[modifiedonbehalfbyname]
      ,[overriddencreatedon]
      ,[vp_lastactivity_date]
      ,[msa_partneridyominame]
      ,[opportunityid]
      ,[vp_jiraid]
      ,[createdonbehalfbyname]
      ,[vp_calculatedprobability]
      ,[emailaddress]
      ,[vp_createdbyidyominame]
      ,[vp_sourcecomment]
      ,[parentcontactidyominame]
      ,[slainvokedidname]
      ,[accountidyominame]
      ,[scheduleproposalmeeting]
      ,[vp_laststagechange]
      ,[stepid]
      ,[createdbyname]
      ,[vp_lastactivitytype]
      ,[modifiedbyyominame]
      ,[lastonholdtime]
      ,[schedulefollowup_prospect]
      ,[modifiedonbehalfbyyominame]
      ,[vp_recycledate]
      ,[stageid]
      ,[utcconversiontimezonecode]
      ,[vp_territoryidname]
      ,[customeridname]
      ,[importsequencenumber]
      ,[createdonbehalfbyyominame]
      ,[vp_lastactivity_state]
      ,[vp_laststagechange_state]
      ,[pricelevelidname]
      ,[parentcontactidname]
      ,[modifiedbyname]
      ,[createdbyyominame]
      ,[owneridname]
      ,[slaname]
      ,[closeprobability]
      ,[discountpercentage]
      ,[currentsituation]
	   , CAST(GETDATE() as date) [LoadDate]
FROM opportunity 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Opportunity_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------


EXEC jobs.sp_add_job @job_name='AgentJob_OpportunitySalesProcess_DeltaLoad_Prod'
GO

EXEC jobs.sp_delete_job @job_name='AgentJob_OpportunitySalesProcess_DeltaLoad_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_OpportunitySalesProcess_DeltaLoad_Prod',
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
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_OpportunitySalesProcess_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------


EXEC jobs.sp_add_job @job_name='AgentJob_Product_DeltaLoad_Prod'
GO

EXEC jobs.sp_delete_job @job_name='AgentJob_Product_DeltaLoad_Prod'
GO


-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Product_DeltaLoad_Prod',
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
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Product_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_Quote_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Quote_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Quote_DeltaLoad_Prod',
@command=N'
INSERT INTO quote_archive
SELECT [id],
       [sinkcreatedon],
       [sinkmodifiedon],
       [statecode],
       [statuscode],
       [skippricecalculation],
       [pricingerrorcode],
       [paymenttermscode],
       [shippingmethodcode],
       [shipto_freighttermscode],
       [freighttermscode],
       [willcall],
       [vp_billtocountryid],
       [vp_billtocountryid_entitytype],
       [modifiedby],
       [modifiedby_entitytype],
       [contactid],
       [contactid_entitytype],
       [vp_shiptocountryid],
       [vp_shiptocountryid_entitytype],
       [owningbusinessunit],
       [owningbusinessunit_entitytype],
       [slainvokedid],
       [slainvokedid_entitytype],
       [pricelevelid],
       [pricelevelid_entitytype],
       [modifiedonbehalfby],
       [modifiedonbehalfby_entitytype],
       [slaid],
       [slaid_entitytype],
       [opportunityid],
       [opportunityid_entitytype],
       [vp_contactid],
       [vp_contactid_entitytype],
       [createdonbehalfby],
       [createdonbehalfby_entitytype],
       [transactioncurrencyid],
       [transactioncurrencyid_entitytype],
       [owningteam],
       [owningteam_entitytype],
       [createdby],
       [createdby_entitytype],
       [owninguser],
       [owninguser_entitytype],
       [campaignid],
       [campaignid_entitytype],
       [accountid],
       [accountid_entitytype],
       [ownerid],
       [ownerid_entitytype],
       [customerid],
       [customerid_entitytype],
       [freightamount],
       [totallineitemamount_base],
       [totalamountlessfreight_base],
       [totaldiscountamount],
       [totallineitemamount],
       [discountamount],
       [discountamount_base],
       [totaltax_base],
       [freightamount_base],
       [totalamountlessfreight],
       [totaltax],
       [totaldiscountamount_base],
       [totalamount],
       [totallineitemdiscountamount_base],
       [totallineitemdiscountamount],
       [totalamount_base],
       [closedon],
       [shipto_line2],
       [createdon],
       [billto_fax],
       [modifiedonbehalfbyyominame],
       [opportunityidname],
       [billto_line2],
       [billto_telephone],
       [modifiedbyyominame],
       [discountpercentage],
       [owneridtype],
       [billto_postalcode],
       [vp_sharepointnumber],
       [shipto_line3],
       [shipto_country],
       [customeridtype],
       [overriddencreatedon],
       [slainvokedidname],
       [accountidname],
       [uniquedscid],
       [quotenumber],
       [createdonbehalfbyyominame],
       [exchangerate],
       [vp_estimateddeliverytimeweeks],
       [billto_city],
       [vp_contactidyominame],
       [accountidyominame],
       [billto_stateorprovince],
       [expireson],
       [shipto_line1],
       [shipto_city],
       [owneridname],
       [timezoneruleversionnumber],
       [billto_contactname],
       [customeridyominame],
       [shipto_addressid],
       [billto_country],
       [effectiveto],
       [billto_addressid],
       [versionnumber],
       [emailaddress],
       [effectivefrom],
       [traversedpath],
       [createdonbehalfbyname],
       [utcconversiontimezonecode],
       [vp_shiptocountryidname],
       [billto_name],
       [name],
       [modifiedon],
       [importsequencenumber],
       [owneridyominame],
       [onholdtime],
       [shipto_postalcode],
       [processid],
       [description],
       [vp_contactidname],
       [createdbyname],
       [modifiedonbehalfbyname],
       [customeridname],
       [lastonholdtime],
       [stageid],
       [shipto_fax],
       [vp_billtocountryidname],
       [vp_originalquoteidnumber],
       [requestdeliveryby],
       [shipto_composite],
       [shipto_contactname],
       [campaignidname],
       [vp_originalrevisionid],
       [createdbyyominame],
       [transactioncurrencyidname],
       [contactidyominame],
       [shipto_stateorprovince],
       [contactidname],
       [shipto_name],
       [slaname],
       [modifiedbyname],
       [billto_composite],
       [shipto_telephone],
       [billto_line1],
       [revisionnumber],
       [billto_line3],
       [pricelevelidname],
       [quoteid]
	   , CAST(GETDATE() as date) [LoadDate]
FROM   quote
WHERE  Datediff(wk, Getdate(), modifiedon) = 0
       AND Year(modifiedon) = Year(Getdate()); 
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Quote_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'

---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_SalesOrder_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_SalesOrder_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_SalesOrder_DeltaLoad_Prod',
@command=N'
INSERT INTO salesorder_archive
SELECT [id],
       [sinkcreatedon],
       [sinkmodifiedon],
       [statecode],
       [statuscode],
       [shipto_freighttermscode],
       [prioritycode],
       [shippingmethodcode],
       [paymenttermscode],
       [pricingerrorcode],
       [vp_handler],
       [freighttermscode],
       [skippricecalculation],
       [vp_distributor],
       [vp_newcast],
       [ispricelocked],
       [willcall],
       [owninguser],
       [owninguser_entitytype],
       [vp_billtocountryid],
       [vp_billtocountryid_entitytype],
       [modifiedonbehalfby],
       [modifiedonbehalfby_entitytype],
       [slaid],
       [slaid_entitytype],
       [owningteam],
       [owningteam_entitytype],
       [pricelevelid],
       [pricelevelid_entitytype],
       [slainvokedid],
       [slainvokedid_entitytype],
       [owningbusinessunit],
       [owningbusinessunit_entitytype],
       [campaignid],
       [campaignid_entitytype],
       [accountid],
       [accountid_entitytype],
       [quoteid],
       [quoteid_entitytype],
       [transactioncurrencyid],
       [transactioncurrencyid_entitytype],
       [modifiedby],
       [modifiedby_entitytype],
       [opportunityid],
       [opportunityid_entitytype],
       [vp_contactid],
       [vp_contactid_entitytype],
       [createdby],
       [createdby_entitytype],
       [contactid],
       [contactid_entitytype],
       [vp_shiptocountryid],
       [vp_shiptocountryid_entitytype],
       [createdonbehalfby],
       [createdonbehalfby_entitytype],
       [vp_salesresponsibleuserid],
       [vp_salesresponsibleuserid_entitytype],
       [ownerid],
       [ownerid_entitytype],
       [customerid],
       [customerid_entitytype],
       [totalamountlessfreight],
       [totallineitemdiscountamount],
       [freightamount],
       [discountamount_base],
       [totalamount_base],
       [freightamount_base],
       [totaltax_base],
       [totalamountlessfreight_base],
       [totalamount],
       [totallineitemamount],
       [totaltax],
       [discountamount],
       [totaldiscountamount],
       [totallineitemdiscountamount_base],
       [totaldiscountamount_base],
       [totallineitemamount_base],
       [slaname],
       [importsequencenumber],
       [customeridyominame],
       [vp_purchaseorderdate],
       [shipto_line2],
       [pricelevelidname],
       [shipto_city],
       [billto_line2],
       [vp_customerspono],
       [billto_name],
       [createdbyname],
       [vp_historydatefullfilled],
       [owneridname],
       [opportunityidname],
       [contactidname],
       [vp_shiptocountryidname],
       [createdonbehalfbyname],
       [salesorderid],
       [shipto_stateorprovince],
       [vp_salesresponsibleuseridname],
       [billto_stateorprovince],
       [slainvokedidname],
       [shipto_fax],
       [emailaddress],
       [entityimageid],
       [lastbackofficesubmit],
       [modifiedbyname],
       [name],
       [exchangerate],
       [entityimage_url],
       [contactidyominame],
       [versionnumber],
       [vp_trackingnumber],
       [shipto_postalcode],
       [shipto_country],
       [modifiedonbehalfbyname],
       [vp_contactidyominame],
       [billto_city],
       [transactioncurrencyidname],
       [customeridtype],
       [createdon],
       [shipto_name],
       [overriddencreatedon],
       [quoteidname],
       [utcconversiontimezonecode],
       [vp_salesresponsibleuseridyominame],
       [billto_line1],
       [createdonbehalfbyyominame],
       [billto_telephone],
       [ordernumber],
       [vp_contactidname],
       [submitstatusdescription],
       [customeridname],
       [entityimage_timestamp],
       [processid],
       [owneridyominame],
       [shipto_addressid],
       [createdbyyominame],
       [billto_postalcode],
       [description],
       [billto_fax],
       [shipto_line3],
       [modifiedon],
       [shipto_line1],
       [vp_billtocountryidname],
       [modifiedbyyominame],
       [onholdtime],
       [modifiedonbehalfbyyominame],
       [shipto_telephone],
       [stageid],
       [vp_licensename],
       [lastonholdtime],
       [requestdeliveryby],
       [accountidname],
       [campaignidname],
       [shipto_contactname],
       [submitstatus],
       [shipto_composite],
       [vp_supplier],
       [billto_addressid],
       [billto_country],
       [datefulfilled],
       [owneridtype],
       [traversedpath],
       [discountpercentage],
       [billto_contactname],
       [timezoneruleversionnumber],
       [accountidyominame],
       [submitdate],
       [billto_line3],
       [billto_composite]
	   , CAST(GETDATE() as date) [LoadDate]
FROM   salesorder
WHERE  Datediff(wk, Getdate(), modifiedon) = 0
       AND Year(modifiedon) = Year(Getdate()); 
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_SalesOrder_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'

---------------------------------------------


EXEC jobs.sp_add_job @job_name='AgentJob_Systemuser_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Systemuser_DeltaLoad_Prod',
@command=N'
INSERT INTO systemuser_archive
SELECT *
FROM contact 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Systemuser_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'

---------------------------------------------
EXEC jobs.sp_delete_job @job_name='AgentJob_CompanyType_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_CompanyType_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_CompanyType_DeltaLoad_Prod',
@command=N'
INSERT INTO vp_companytype_archive
SELECT [id],
       [sinkcreatedon],
       [sinkmodifiedon],
       [statecode],
       [statuscode],
       [modifiedby],
       [modifiedby_entitytype],
       [createdonbehalfby],
       [createdonbehalfby_entitytype],
       [modifiedonbehalfby],
       [modifiedonbehalfby_entitytype],
       [organizationid],
       [organizationid_entitytype],
       [vp_parentcompanytypeid],
       [vp_parentcompanytypeid_entitytype],
       [createdby],
       [createdby_entitytype],
       [createdbyyominame],
       [organizationidname],
       [vp_name],
       [createdonbehalfbyyominame],
       [modifiedonbehalfbyyominame],
       [modifiedbyyominame],
       [createdbyname],
       [versionnumber],
       [vp_parentcompanytypeidname],
       [timezoneruleversionnumber],
       [vp_companytypeid],
       [importsequencenumber],
       [modifiedonbehalfbyname],
       [modifiedbyname],
       [modifiedon],
       [overriddencreatedon],
       [utcconversiontimezonecode],
       [createdonbehalfbyname],
       [createdon]
	   , CAST(GETDATE() as date) [LoadDate]
FROM   vp_companytype
WHERE  Datediff(wk, Getdate(), modifiedon) = 0
       AND Year(modifiedon) = Year(Getdate()); 
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_CompanyType_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'
---------------------------------------------

EXEC jobs.sp_delete_job @job_name='AgentJob_Territory_DeltaLoad_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Territory_DeltaLoad_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Territory_DeltaLoad_Prod',
@command=N'
INSERT INTO territory_archive
SELECT [id],
       [sinkcreatedon],
       [sinkmodifiedon],
       [organizationid],
       [organizationid_entitytype],
       [modifiedby],
       [modifiedby_entitytype],
       [createdby],
       [createdby_entitytype],
       [parentterritoryid],
       [parentterritoryid_entitytype],
       [transactioncurrencyid],
       [transactioncurrencyid_entitytype],
       [managerid],
       [managerid_entitytype],
       [modifiedonbehalfby],
       [modifiedonbehalfby_entitytype],
       [createdonbehalfby],
       [createdonbehalfby_entitytype],
       [transactioncurrencyidname],
       [timezoneruleversionnumber],
       [modifiedonbehalfbyyominame],
       [description],
       [versionnumber],
       [parentterritoryidname],
       [entityimage_timestamp],
       [modifiedonbehalfbyname],
       [manageridyominame],
       [organizationidname],
       [overriddencreatedon],
       [createdonbehalfbyname],
       [modifiedbyname],
       [entityimage_url],
       [modifiedon],
       [createdbyname],
       [utcconversiontimezonecode],
       [modifiedbyyominame],
       [name],
       [createdonbehalfbyyominame],
       [territoryid],
       [createdon],
       [exchangerate],
       [importsequencenumber],
       [entityimageid],
       [manageridname],
       [createdbyyominame]
	   , CAST(GETDATE() as date) [LoadDate]
FROM   territory
WHERE  Datediff(wk, Getdate(), modifiedon) = 0
       AND Year(modifiedon) = Year(Getdate()); 
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Territory_DeltaLoad_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210508 23:00'


---------------------------------------------

EXEC jobs.sp_delete_job @job_name='AgentJob_ControlUniqueIDCounts_Prod'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_ControlUniqueIDCounts_Prod'
GO

-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_ControlUniqueIDCounts_Prod',
@command=N'
WITH cte
     AS (SELECT ''Account''   AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   account a
                LEFT JOIN account_archive b
                       ON a.id = b.id
         UNION
         SELECT ''BusinessUnit'' AS TableName,
                Count(a.id)    AS UniqueIDCount,
                Count(b.id)    AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END            AS HasDiff
         FROM   businessunit a
                LEFT JOIN businessunit_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Contact''   AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   [dbo].contact a
                LEFT JOIN [dbo].contact_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Goal''      AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   goal a
                LEFT JOIN goal_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Lead''      AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   [dbo].lead a
                LEFT JOIN [dbo].lead_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Lead to opportunity sales process'' AS TableName,
                Count(a.id)                         AS UniqueIDCount,
                Count(b.id)                         AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END                                 AS HasDiff
         FROM   [dbo].[leadtoopportunitysalesprocess] a
                LEFT JOIN [dbo].[leadtoopportunitysalesprocess_archive] b
                       ON a.id = b.id
         UNION
         SELECT ''Opportunity'' AS TableName,
                Count(a.id)   AS UniqueIDCount,
                Count(b.id)   AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END           AS HasDiff
         FROM   [dbo].opportunity a
                LEFT JOIN [dbo].opportunity_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Opportunity sales process'' AS TableName,
                Count(a.id)                 AS UniqueIDCount,
                Count(b.id)                 AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END                         AS HasDiff
         FROM   [dbo].opportunitysalesprocess a
                LEFT JOIN [dbo].opportunitysalesprocess_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Product''   AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   [dbo].product a
                LEFT JOIN [dbo].product_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Quote''    AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   [dbo].quote a
                LEFT JOIN [dbo].quote_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Sales order'' AS TableName,
                Count(a.id)   AS UniqueIDCount,
                Count(b.id)   AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END           AS HasDiff
         FROM   [dbo].salesorder a
                LEFT JOIN [dbo].salesorder_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Territory'' AS TableName,
                Count(a.id) AS UniqueIDCount,
                Count(b.id) AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END         AS HasDiff
         FROM   [dbo].territory a
                LEFT JOIN [dbo].territory_archive b
                       ON a.id = b.id
         UNION
         SELECT ''Company type'' AS TableName,
                Count(a.id)    AS UniqueIDCount,
                Count(b.id)    AS ArchiveUniqueIDCount,
                CASE
                  WHEN Count(a.id) <> Count(b.id) THEN 1
                  ELSE 0
                END            AS HasDiff
         FROM   [dbo].vp_companytype a
                LEFT JOIN [dbo].vp_companytype_archive b
                       ON a.id = b.id)
INSERT INTO controluniqueidcounts
SELECT Getdate() AS Date,
       tablename,
       uniqueidcount,
       archiveuniqueidcount,
       hasdiff
FROM   cte; 
;',
@credential_name='job_execution_prod',
@target_group_name='d365Group_prod'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_ControlUniqueIDCounts_Prod',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20210619 23:00'
