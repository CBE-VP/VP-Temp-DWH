
--EXEC jobs.sp_delete_job @job_name='AgentJob_Contact_DeltaLoad'
GO

EXEC jobs.sp_add_job @job_name='AgentJob_Contact_DeltaLoad'
GO
-- Add job step for updating table with new or changed rows
EXEC jobs.sp_add_jobstep @job_name='AgentJob_Contact_DeltaLoad',
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
	  ,CAST(GETDATE() as date) [LoadDate]
FROM contact 
WHERE DATEDIFF(wk,getdate(),modifiedon) = 0
AND YEAR(modifiedon) = YEAR(GETDATE())
;',
@credential_name='job_execution',
@target_group_name='d365Group'

/* Schedule job execution*/	
EXEC jobs.sp_update_job
@job_name='AgentJob_Contact_DeltaLoad',
@enabled=1,
@schedule_interval_type='Weeks',
@schedule_interval_count=1,
@schedule_start_time = '20211002 22:00'


