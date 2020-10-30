SELECT DATE_FORMAT(R.date_accessed, "%Y-%m-%d") as "RCM Access Date (YYYY-MM-DD)" ,
												CASE 
												WHEN FI.dialect = 1 THEN "English"
												WHEN FI.dialect = 2 THEN "Tagalog"
												WHEN FI.dialect = 3 THEN "Bicolano"
												WHEN FI.dialect = 4 THEN "Hiligaynon"
												WHEN FI.dialect = 5 THEN "Cebuano"
												WHEN FI.dialect = 6 THEN "Iluko"
												ELSE "NULL" END as "Language",
												R.ref_id as "RCM Reference number" ,
												IF (UT.farmer_id!="", UT.farmer_id,"No Farmer ID used") as "RCM Farmer_ID(if available)",
												FI.farmer_name as "Farmers first name",
												FI.lname_farmer as "Farmers last name" ,
												IF (FI.mothers_maiden_name != "", "",FI.birth_date) as "Farmer Birthday" ,
												IF (FI.mothers_maiden_name != "", "",FI.age_farmer) as "Farmer Age" ,
												CASE 
												WHEN FI.gender_farmer = 1 THEN "Male"
												WHEN FI.gender_farmer = 2 THEN "Female"
												ELSE "NULL" END as "Farmer Gender",
												FI.farmer_email as "Farmer Email" ,
												IF (FI.as_user = 1, "Yes","No") as "Farmer - Operator",
												IF (FI.as_user = 2, "Yes","No") as "Farmer receiving rice farming info from local technician",
												LT.first_name as "Local Tech Firstname",
												LT.last_name as "Local Tech Lastname",
												LT.mobile as "Local Tech Mobile Number",
												LT.email as "Local Tech Mobile Email",
												LR.region as "Region" ,
												LP.province as "Province" ,
												LM.municipality as "Municipality" ,
												LB.name as "Barangay" ,
												IF(FI.mothers_maiden_name = "", FI.farmer_middle_name, "") as "Mother Maiden Name" ,
												CASE
												WHEN FI.phone_owner = 1 THEN "Self"
												WHEN FI.phone_owner = 2 THEN "Spouse"
												WHEN FI.phone_owner = 3 THEN "Son or daughter"
												WHEN FI.phone_owner = 4 THEN "Other relaive"
												WHEN FI.phone_owner = 5 THEN "Neighbor"
												WHEN FI.phone_owner = 6 THEN "Others"
												ELSE "NULL" END as "Phone Owner" ,
												IF(FI.receive_sms = 1, "Yes", "No") as "Receive SMS",
												FI.other_phone_owner as "Specify Name of Phone owner if others" ,
												IF (FI.agreed = 1, "Yes", "No") as "Consent of Farmer" ,
												FI.field_count as "Field Count",
												IF (UT.field_id!="", UT.field_id,"No Farm Lot ID used") as "RCM Farm Lot_ID(if available)",												
												F.field_name as "Farm Lot Name" ,
												CASE 
												WHEN F.field_unit = 1 THEN "Hectare"
												WHEN F.field_unit = 2 THEN "Width x Length"
												WHEN F.field_unit = 3 THEN "Square Meter"
												ELSE "NULL" END as "RCM Farm Lot unit",
												CASE 
												WHEN F.field_unit = 1 THEN F.hectare
												WHEN F.field_unit = 2 THEN concat(F.width,"x",F.length)
												WHEN F.field_unit = 3 THEN F.square_meter
												ELSE "NULL" END as "RCM Farm Lot size",
												F.field_size as "RCM Farm Lot size (conversion in ha)" ,
												CI.crops_per_year as "Crops per year" ,
												CASE 
												WHEN R.date_accessed > "2016-05-20 23:59:59" THEN "NULL" 
												WHEN CI.season = 1 THEN "Wet Season"
												WHEN CI.season = 2 THEN "Early Wet Season"
												WHEN CI.season = 3 THEN "Late Wet Season"
												WHEN CI.season = 4 THEN "Dry Season"
												ELSE "NULL" END as "Season",
												CASE 
												WHEN CI.irrigation = 1 THEN "Irrigated"
												WHEN CI.irrigation = 2 THEN "Irrigated"
												WHEN CI.irrigation = 3 THEN "Rainfed"
												ELSE "NULL" END as "RCM Water Regime" ,
												CASE 
												WHEN CI.water = 1 THEN "Adequate"
												WHEN CI.water = 2 THEN "Short"
												WHEN CI.water = 3 THEN "Submergence"
												ELSE "NULL" END as "RCM water supply status" ,
												CASE 
												WHEN CI.prev_crop = 1 THEN "Rice"
												WHEN CI.prev_crop = 2 THEN "Corn"
												WHEN CI.prev_crop = 3 THEN "Legume"
												WHEN CI.prev_crop = 4 THEN "Vegetable or Melon"
												WHEN CI.prev_crop = 5 THEN "Other"
												WHEN CI.prev_crop = 6 THEN "Fallow"
												WHEN CI.prev_crop = 20 THEN "Bell Pepper or Eggplant"
												WHEN CI.prev_crop = 21 THEN "Tomato"
												WHEN CI.prev_crop = 22 THEN "Tobacco"
												ELSE CI.other_pcrop END as "Crop grown before rice" ,
												CASE
												WHEN CI.crop_establishment = 1 THEN "Manually transplanted"
												WHEN CI.crop_establishment = 2 THEN "Wet Seeded"
												WHEN CI.crop_establishment = 3 THEN "Mechanically transplanted"
												WHEN CI.crop_establishment = 4 THEN "Dry seeded"
												ELSE "NULL" END as "RCM Crop establishment" ,
												CI.sowing_date as "RCM Sowing Date" ,
												CASE
												WHEN CI.variety_type = 1 THEN "Inbred"
												WHEN CI.variety_type IN (2,0) THEN "Hybrid"
												ELSE "NULL "END as "RCM Variety type",
												CONCAT(V.variety1,V.variety2,V.variety3) as "RCM Variety name" ,
												CI.variety_name as "RCM Variety name if not in the list" ,
												CASE
												WHEN CI.crop_establishment IN (1,3) AND CI.growth_duration = 1 THEN "101-110"
												WHEN CI.crop_establishment IN (1,3) AND CI.growth_duration = 2 THEN "111-120"
												WHEN CI.crop_establishment IN (1,3) AND CI.growth_duration = 3 THEN "121-130"
												WHEN CI.crop_establishment IN (2,4) AND CI.growth_duration = 1 THEN "91-100"
												WHEN CI.crop_establishment IN (2,4) AND CI.growth_duration = 2 THEN "101-110"
												WHEN CI.crop_establishment IN (2,4) AND CI.growth_duration = 3 THEN "111-120"
												ELSE "NULL" END as "RCM Growth duration if not in the list" ,
												CASE
												WHEN CI.seedling_age = 1 THEN "10-14 days"
												WHEN CI.seedling_age = 2 THEN "15-22 days"
												WHEN CI.seedling_age = 3 THEN "23 days or more"
												ELSE "NULL" END as "RCM Seedling age" ,
												IF(CI.crop_establishment = 1 OR CI.crop_establishment = 3,"NULL",CI.seed_rate) as "RCM Seed rate in kg" ,
												CI.num_sacks_ya as "RCM Reported Gross Yield sacks" ,
												CI.kg_per_sack as "RCM Reported Gross Yield kg" ,
												O.current_yield as "RCM Reported Gross Yield t/ha in 14% MC" ,
												CASE
												WHEN CI.straw= 1 THEN "Manual"
												WHEN CI.straw = 2 THEN "Combined"
												WHEN CI.straw = 3 THEN "Reaper"
												ELSE "NULL" END as "RCM Harvesting Method" ,
												CASE
												WHEN CI.prev_crop IN  (4,20,21,22) THEN "NULL"
												WHEN CI.insecticide = 1 THEN "Yes"
												WHEN CI.insecticide = 2 THEN "No"
												ELSE "NULL" END as "Apply insecticide within 30 DAS/DAE/DAT?" ,
												CASE
												WHEN CI.prev_crop IN  (4,20,21,22) THEN "NULL"
												WHEN CI.insecticide = 2 THEN "NULL"
												WHEN CI.plant_synch = 1 THEN "Yes"
												WHEN CI.plant_synch = 2 THEN "No"
												ELSE "NULL" END as "Will rice be transplanted or sown within 2 weeks before or after neighboring fields?" ,
												CASE
												WHEN CI.low_lying = 1 THEN "Yes"
												WHEN CI.low_lying = 2 THEN "No"
												ELSE "NULL" END as "Is field in low lying area or depression with accumulation of water?" ,
												IF (CI.salinity = 1, "Yes", "No") as "Is field affected by salinity?" ,
												IF (OO.org_bags > 0, "Yes", "No") as "RCM Organic Fertilizer Application" ,
												IF (OO.org_bags > 0, OO.org_bags, "NULL") as "RCM Number of organic fertilizer bags" ,
												OO.org_weight as "RCM Weight of organic fertilizer bag" ,
												CI.fertBags as "Number of bags inorganic fertilizer used in previous season" ,
												FI.farmer_cell as "Farmer Mobile Phone" ,
												EI.extension_id as "RCM Operators ID" ,
												IF (EI.extension_name = "" AND LT.first_name = "", CONCAT(FI.farmer_name," ",FI.lname_farmer),CONCAT(EI.extension_name," ",EI.lname_ext)) as "RCM Operator Name" ,
												CASE 
												WHEN EI.gender = 1 THEN "Male"
												WHEN EI.gender = 2 THEN "Female"
												ELSE "NULL" END as "RCM Operator Gender",
												CASE
												WHEN EI.profession = 1 THEN "Extension Worker/Agent"
												WHEN EI.profession = 2 THEN "Farmer"
												WHEN EI.profession = 3 THEN "Researcher"
												WHEN EI.profession = 4 THEN "Loan Officer"
												WHEN EI.profession = 5 THEN "Fertilizer Dealer"
												WHEN EI.profession = 6 THEN "Others"
												ELSE "NULL" END as "RCM Operator Profession" ,
												EI.other_prof as "RCM Other Profession",
												EI.extension_cell as "RCM Operator Phone Number" ,
												EI.extension_email as "RCM Operator Email" ,
												O.number_sacks as "RCM Target Yield, sacks" ,
												O.attainable_yield as "RCM Target Yield, t/ha in 14% MC" ,
												O.early_days as "Early Fertilizer Application (days)" ,
												O.active_days as "Active Tillering Fertilizer Application (days)" ,
												O.pannicle_days as "Panicle Initiation Fertilizer Application (days)" ,
												IF(O.attainable_yield >= 7.5, O.head_days, "") as "Heading Fertilizer Application (days)" ,
												O2.early_date_21 as "Early Fertilizer Application (if recommended 15-22 seedling days)" ,
												O2.at_date_21 as "Active Tillering Fertilizer Application (if recommended 15-22 seedling days)" ,
												O2.pi_date_21 as "Panicle Initiation Fertilizer Application (if recommended 15-22 seedling days)" ,
												O2.hd_date_21 as "Heading Fertilizer Application (if recommended 15-22 seedling days)" ,
												IF(CI.irrigation =3 AND O.active_days = "NA","",O2.at_date_rf) as "Active Tillering Fertilizer Application (adjusted days)" ,
												IF(CI.irrigation =3 AND O.active_days = "NA","",O2.pi_date_rf) as "Panicle Initiation Fertilizer Application (adjusted days)" ,
												IF (O.fert_source = 1, O.early_fert, "") as "Early application_14-14-14 (kg)" ,
												IF (O.fert_source = 2, O.early_fert, "") as "Early application_16-20-0 (kg)" ,
												IF (O.early_P = 0, O.early_N/0.46, "") as "Early application_UREA (kg)" ,
												O.early_MOP as "Early application_MOP (kg)" ,
												O.active_fert as "Active tillering application_UREA (kg)" ,
												IF (CI.irrigation = 3, O2.at_urea_rf*50, "NULL") as "Active tillering application (adjusted day)_UREA (kg)" ,
												O.pannicle_fert as "Panicle initiation application_UREA (kg)" ,
												O.panicle_MOP as "Panicle initiation application_MOP (kg)" ,												
												O.head_fert as "Heading application_UREA(kg)" ,
												(O.early_N+O.active_N+O.pannicle_N+O.head_N) as "Recommended N (kg/ha)" ,
												O.early_P as "Recommended P2O5 (kg/ha)" ,
												ROUND((((IF (O.fert_source = 1, O.early_fert, "") * 0.14)+(O.panicle_MOP * 0.6))/F.field_size)) as "Recommended K2O (kg/ha)" ,
												ROUND((
												(IF(O.fert_source = 1,O.early_fert,0)*0.14)+
												(IF(O.fert_source = 2,O.early_fert,0)*0.16)+
												(IF(O.early_P = 0, O.early_N/0.46, 0))+
												(O.active_fert*0.46)+
												(O.pannicle_fert*0.46)+
												(O.head_fert*0.46))/F.field_size) as "Total N (kg/ha) from fertilizer recommendation",
												ROUND((
												(IF(O.fert_source = 1,O.early_fert,0)*0.14)+
												(IF(O.fert_source = 2,O.early_fert,0)*0.20))/F.field_size) as "Total P2O5 (kg/ha) from fertilizer recommendation",
												ROUND((
												(IF(O.fert_source = 1,O.early_fert,0)*0.14)+
												(O.panicle_MOP*0.6))/F.field_size) as "Total K2O (kg/ha) from fertilizer recommendation",
												IF (CM.app_ins = 1, "Yes", "No") as "RCM recommendation for insecticide application within 30 days" ,
												IF (CM.hand_weed = 1, "Yes", "No") as "RCM recommendation for weed management" ,
												IF (CM.qseeds = 1, "Yes", "No") as "RCM recommendation for seed rate" ,  /* where does seed rate is saved - capture seed rate instead of yes/no*/
												IF (CM.keep_fw = 1, "Yes", "No") as "RCM recommendation keep flood water low" ,
												IF (CM.use21_sa = 1, "Yes", "No") as "RCM recommendation on use of 21 days old seedlings" ,
												IF (CM.app_zinc = 1, "Yes", "No") as "RCM recommendation for zinc application" ,
												IF (CM.prac_ci = 1, "Yes", "No") as "RCM recommendation for safe AWD" ,
												IF (CI.irrigation_pump = 1, "Yes", "No") as "Is using pump for irrigation?" ,
												CASE 
												WHEN CI.prev_variety_type = 1 THEN "Inbred"
												WHEN CI.prev_variety_type = 2 THEN "Hybrid"
												ELSE "NULL" END as "Previous Variety",
												IF (CI.weed_control like "%1%", "yes", "no") as "RCM Weed Control_Pre-emergence",
												IF (CI.weed_control like "%2%", "yes", "no") as "RCM Weed Control_Post-emergence",
												IF (CI.weed_control like "%3%", "yes", "no") as "RCM Weed Control_Hand Weeding",
												IF (CI.weed_control like "%4%", "yes", "no") as "RCM Weed Control_Water Management",
												IF (CM.irrigate_flowering = 1, "Yes", "No") as "RCM recommendation for irrigation at flowering stage",
												IF (CI.zinc_observation LIKE "1%", "yes", "no") as "Zinc related observation_Water lettuce",
												IF (CI.zinc_observation LIKE "%2%", "yes", "no") as "Zinc related observation_Oily film",
												IF (CI.zinc_observation LIKE "%3%", "yes", "no") as "Zinc related observation_Standing water",
												IF (CI.zinc_observation LIKE "%4%", "yes", "no") as "Zinc related observation_Dusty brownspots in leaves",
												IF (CI.zinc_observation LIKE "%5%", "yes", "no") as "Zinc related observation_None",
												CONCAT(TI.firstname," ",TI.lastname) as "Regional RCM TOT participant",
												IF(EI.fits_associated = 1, TF.center_name, "") as "FITS Center",
												IF (O.rec_type = 1 AND R.ref_id < 1266642, "Modified", "Standard") as "Recommendation Type",
																								CASE
												WHEN CI.upcoming_seed_source = 1 THEN "Purchased certified seeds with tag or provided by DA"
												WHEN CI.upcoming_seed_source = 2 THEN "Purchased or exchanged seeds from other farmer using good quality seed or from a farm lot with proper rouging"
												WHEN CI.upcoming_seed_source = 3 THEN "Seeds from the first harvest of certified seeds with tag"
												WHEN CI.upcoming_seed_source = 4 THEN "Home-saved seeds or seeds used for several seasons"
												ELSE "NULL" END as "Source of rice seeds for the upcoming season" ,
												CASE
												WHEN CI.previous_seed_source = 1 THEN "Purchased certified seeds with tag or provided by DA"
												WHEN CI.previous_seed_source = 2 THEN "Purchased or exchanged seeds from other farmer using good quality seed or from a farm lot with proper rouging"
												WHEN CI.previous_seed_source = 3 THEN "Seeds from the first harvest of certified seeds with tag"
												WHEN CI.previous_seed_source = 4 THEN "Home-saved seeds or seeds used for several seasons"
												ELSE "NULL" END as "Source of rice seeds in the previous season",
												CASE
												WHEN FI.da_subprogram = 1 THEN "RCM Large Scale Dissemination Project"
												WHEN FI.da_subprogram = 3 THEN "Rice Model Farm"
												WHEN FI.da_subprogram = 4 THEN "Intensive Hybridization Program"
												WHEN FI.da_subprogram = 7 THEN "No Project Involvement"
												WHEN FI.da_subprogram = 8 THEN "RCM Research"
												WHEN FI.da_subprogram = 5 THEN "Other"
												ELSE "NULL" END as "DA Sub Program",
												FI.other_da_subprogram as "Othe DA Program",
												CI.sacks_CAR AS "Immediate Previous Yield",
												CI.kg_CAR AS "Immediate Previous Yield (kg)"
  FROM rasph.anreference as R
  LEFT OUTER JOIN rasph.farmers as FI on FI.ref_id = R.ref_id
  INNER JOIN rasph.fields as F on F.ref_id = R.ref_id
  INNER JOIN rasph.tblregion as LR USING (region_id)
  INNER JOIN rasph.tblprovince as LP USING (province_id)
  INNER JOIN rasph.tblmunicipality as LM USING (municipality_id)
  INNER JOIN rasph.tblbarangay as LB ON LB.id = F.barangay_id 
  INNER JOIN rasph.ancropinfo as CI on CI.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.tblvariety as V USING (variety_id)
  LEFT OUTER JOIN phaas.usage_track as UT on UT.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anoutput as O on O.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.antrainerentry as TE on TE.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.antrainerinfo as TI USING (trainer_id)
  LEFT OUTER JOIN rasph.anfieldowner as FO USING (field_id)
  LEFT OUTER JOIN rasph.anorganics as OO on OO.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anotherorganics as OOO on OOO.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.ansessionextension as SE on SE.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anextensioninfo as EI USING (extension_id)
  LEFT OUTER JOIN rasph.anlocaltechnician as LT on LT.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anrecyield as RY on RY.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anrecyield2 as RY2 on RY2.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.ancmoutput as CM on CM.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.ancmoutput2 as CM2 on CM2.ref_id = R.ref_id
  LEFT OUTER JOIN rasph.anoutput2 as O2 ON (O2.ref_id = O.ref_id AND O2.rec_type = O.rec_type)
  LEFT OUTER JOIN rasph.tblFITS as TF ON F.municipality_id = TF.municipality_id
	WHERE R.category = "0" AND R.test = "1"
	AND R.date_accessed between "2020-02-01 00:00:00" AND "2020-02-25 23:59:59" LIMIT 10