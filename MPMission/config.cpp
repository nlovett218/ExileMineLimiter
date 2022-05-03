class CfgMine
{
	//Based on max number or weight (not developed enough only weight system works)
	systemType = "WEIGHT";

	//Not developed
	maxPerPlayer = 3;

	//Max Weight per player
	maxWeight = 150;

	//When you go to place a mine, it checks to see if the type is listed in this array of allowed classes
	//Uses CfgMagazine ID
	classTypes[] = {
		"rhs_mine_m2a3b_trip_mag",
		"rhs_mine_glasmine43_bz_mag",
		"rhs_mine_glasmine43_hz_mag",
		"rhs_ec75_sand_mag",
		"rhs_ec200_sand_mag",
		"rhs_ec400_sand_mag",
		"rhs_ec75_mag",
		"rhs_ec200_mag",
		"rhs_ec400_mag",
		"APERSBoundingMine_Range_Mag",
		"APERSMine_Range_Mag",
		"APERSTripMine_Wire_Mag",
		"SLAMDirectionalMine_Wire_Mag",
		"SatchelCharge_Remote_Mag",
		"DemoCharge_Remote_Mag",
		"IEDLandSmall_Remote_Mag",
		"IEDLandBig_Remote_Mag",
		"IEDUrbanBig_Remote_Mag",
		"IEDUrbanSmall_Remote_Mag",
		"ClaymoreDirectionalMine_Remote_Mag",
		"rhsusf_m112x4_mag",
		"rhsusf_m112_mag",
		"rhs_charge_M2tet_x2_mag",
		"rhs_mine_ozm72_a_mag",
		"rhs_mine_ozm72_b_mag",
		"rhs_mine_pmn2_mag",

		//Lower weights
		//rhs_mine_sm320_green_mag
		"rhs_mine_sm320_green_mag",
		"rhs_mine_sm320_red_mag",
		"rhs_mine_sm320_white_mag",
		"rhsusf_mine_m49a1_10m_mag",
		"rhs_mine_msk40p_blue_mag",
		"rhs_mine_msk40p_green_mag"
	};

	class types
	{
		class DefaultMine
		{
			CfgVehicleName = "";
			isRemote = false;
			weight = 25;
		};

		/*
			Alright so what's going on here is the class is referenced through its magazine typename, then the CfgVehicleName is retrieved

			If you want to add more, you have to go into the editor and get both of the classnames from CfgMagazine and CfgVehicle

			I added all base arma exmplosives
			I added most, if not all explosives from RHS 
		*/

		/* 		CfgMagazine											  				   CfgVehicle																*/
		class rhs_mine_m2a3b_trip_mag: DefaultMine 					{ CfgVehicleName = "rhs_mine_m2a3b_trip"; isRemote = false; };
		class rhs_mine_glasmine43_bz_mag: DefaultMine  				{ CfgVehicleName = "rhs_mine_glasmine43_bz"; isRemote = false; };
		class rhs_mine_glasmine43_hz_mag: DefaultMine 				{ CfgVehicleName = "rhs_mine_glasmine43_hz"; isRemote = false; };
		class rhs_ec200_sand_mag: DefaultMine  						{ CfgVehicleName = "rhs_magazine_rhs_ec200_sand_mag"; isRemote = true; };
		class rhs_ec400_sand_mag: DefaultMine  						{ CfgVehicleName = "rhs_magazine_rhs_ec400_sand_mag"; isRemote = true; };
		class rhs_ec75_sand_mag: DefaultMine  						{ CfgVehicleName = "rhs_magazine_rhs_ec75_sand_mag"; isRemote = true; };
		class rhs_ec75_mag: DefaultMine  							{ CfgVehicleName = "rhs_magazine_rhs_ec75_mag"; isRemote = true; };
		class rhs_ec200_mag: DefaultMine  							{ CfgVehicleName = "rhs_magazine_rhs_ec200_mag"; isRemote = true; };
		class rhs_ec400_mag: DefaultMine  							{ CfgVehicleName = "rhs_magazine_rhs_ec400_mag"; isRemote = true; };
		class APERSBoundingMine_Range_Mag: DefaultMine  			{ CfgVehicleName = "APERSBoundingMine"; isRemote = false; };
		class APERSMine_Range_Mag: DefaultMine  					{ CfgVehicleName = "APERSMine"; isRemote = false; };
		class APERSTripMine_Wire_Mag: DefaultMine  					{ CfgVehicleName = "APERSTripMine"; isRemote = false; };
		class SLAMDirectionalMine_Wire_Mag: DefaultMine  			{ CfgVehicleName = "SLAMDirectionalMine"; isRemote = false; };
		class SatchelCharge_Remote_Mag: DefaultMine  				{ CfgVehicleName = "SatchelCharge_F"; isRemote = true; weight = 50;};
		class DemoCharge_Remote_Mag: DefaultMine  					{ CfgVehicleName = "DemoCharge_F"; isRemote = true; };
		class IEDLandSmall_Remote_Mag: DefaultMine  				{ CfgVehicleName = "IEDLandSmall_F"; isRemote = true; };
		class IEDLandBig_Remote_Mag: DefaultMine 					{ CfgVehicleName = "IEDLandBig_F"; isRemote = true; };
		class IEDUrbanBig_Remote_Mag: DefaultMine  					{ CfgVehicleName = "IEDUrbanBig_F"; isRemote = true; };
		class IEDUrbanSmall_Remote_Mag: DefaultMine  				{ CfgVehicleName = "IEDUrbanSmall_F"; isRemote = true; };
		class ClaymoreDirectionalMine_Remote_Mag: DefaultMine 		{ CfgVehicleName = "Claymore_F"; isRemote = true; };
		class rhsusf_m112x4_mag: DefaultMine  						{ CfgVehicleName = "rhsusf_explosive_m112x4"; isRemote = true; };
		class rhsusf_m112_mag: DefaultMine 							{ CfgVehicleName = "rhsusf_explosive_m112"; isRemote = true; };
		class rhs_mine_sm320_green_mag: DefaultMine  				{ CfgVehicleName = "rhs_mine_sm320_green"; isRemote = false; weight = 10; };
		class rhs_mine_sm320_red_mag: DefaultMine  					{ CfgVehicleName = "rhs_mine_sm320_red"; isRemote = false; weight = 10; };
		class rhs_mine_sm320_white_mag: DefaultMine  				{ CfgVehicleName = "rhs_mine_sm320_white"; isRemote = false; weight = 10; };
		class rhs_mine_msk40p_blue_mag: DefaultMine  				{ CfgVehicleName = "rhs_mine_msk40p_blue"; isRemote = false; weight = 10; };
		class rhs_mine_msk40p_green_mag: DefaultMine  				{ CfgVehicleName = "rhs_mine_msk40p_green"; isRemote = false; weight = 10; };
		class rhs_mine_ozm72_a_mag: DefaultMine  					{ CfgVehicleName = "rhs_mine_ozm72_a"; isRemote = false; };
		class rhs_mine_ozm72_b_mag: DefaultMine  					{ CfgVehicleName = "rhs_mine_ozm72_b"; isRemote = false; };
		class rhs_mine_pmn2_mag: DefaultMine  						{ CfgVehicleName = "rhs_mine_pmn2"; isRemote = false; };
		class rhs_charge_M2tet_x2_mag: DefaultMine  				{ CfgVehicleName = "rhs_magazine_rhs_charge_tnt_x2_mag"; isRemote = true; };

	};

	//If for whatever reason no weight can be found, use this number instead of null
	defaultWeight = 10;

	
	allowDisarming = true; //Do we want to allow disarming mines with a tool?
	disarmingRequiresTool = true; //Should disarming mines require an item in inventory?
	disarmingTool = "Exile_Item_Pliers"; //Item Id
	disarmActivationDistance = 4; //Distance in meters, play around with it to get the right setting. If you set it too close, the mine might go off.

	territoryOnly = false; //Should mines only be allowed to be placed inside territories? (not implemented)

	//Sound ID for disarming
	disarmingSound = "mine_dismantling";
	disarmRequiresLineOfSight = true; //Pretty self-explanatory 

	//Wanna troll some friends and have it blow up automatically??
	BlowUpOnUID[] = {};
};

