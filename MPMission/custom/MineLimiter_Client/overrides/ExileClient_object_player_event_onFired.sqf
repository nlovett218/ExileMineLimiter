/**
 * ExileClient_object_player_event_onFired
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_object", "_intersection", "_firstInsection"];
_unit = _this select 0;
_weapon = _this select 1;
_muzzle = _this select 2;
_mode =	_this select 3;
_ammo = _this select 4;
_magazine =	_this select 5;
_projectile = _this select 6;
if (ExilePlayerInSafezone) then 
{
	if (local _projectile) then 
	{
		deleteVehicle _projectile;
	};

	//Ensures that we return the item to the inventory
	if (_weapon isEqualTo "Put") then
	{
		[_unit, _magazine, netId _projectile] call ExileClient_MineLimiter_network_placeMineRequest;
	};
}
else 
{
	switch (_weapon) do 
	{
		case "Exile_Melee_Axe":
		{
			player playActionNow "GestureExileAxeSwing01";
			[] call ExileClient_object_tree_chop;
		};
		case "Exile_Melee_Shovel":
		{
			player playActionNow "GestureExileSledgeHammerSwing01";
		};
		case "Exile_Melee_SledgeHammer":
		{
			player playActionNow "GestureExileSledgeHammerSwing01";
			[] call ExileClient_object_shippingContainer_smash;
		};
		case "Put":
		{
			if (_magazine in ["DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"]) then
			{
				_object = cursorTarget;
				if ((_object isKindOf "LandVehicle") || (_object isKindOf "Air") || (_object isKindOf "Boat") || (_object isKindOf "Man") || (_object isKindOf "Exile_Construction_Abstract_Static")) then
				{
					_intersection = lineIntersectsSurfaces 
					[
						AGLToASL positionCameraToWorld [0, 0, 0],  
						AGLToASL positionCameraToWorld [0, 0, 5],  
						player, 
						objNull, 
						true, 
						1, 
						"VIEW", 
						"GEOM" 
					];
					if (count _intersection > 0) then 
					{
						_firstInsection = _intersection select 0;
						if !(simulationEnabled _object) then 
						{
							if (local _object) then 
							{
								_object enableSimulation true;
							}
							else 
							{
								["enableSimulationRequest", [netId _object]] call ExileClient_system_network_send;
							};
						};
						_projectile setPosASL [0, 0, 0]; 
						_projectile attachTo [_object, _object worldToModel (ASLtoAGL (_firstInsection select 0)) ];
						_projectile setVectorUp (_firstInsection select 1);
					};
				};
			};

			private _validMagazine = isClass (missionConfigFile >> "CfgMine" >> "types" >> _magazine);

			if !(_validMagazine) exitWith {
				 ["ErrorTitleAndText", ["Contact an admin!", "This mine hasn't been added to the config!"]] call ExileClient_gui_toaster_addTemplateToast;
				 deleteVehicle _projectile;
			};

			//START CUSTOM CODE
			private _isRemoteCharge = (missionConfigFile >> "CfgMine" >> "types" >> _magazine >> "isRemote") call BIS_fnc_getCfgDataBool;

			/*

				I haven't really used remote charges with the mine limiter because it requires further testing and development
				So for now I have disabled limiting explosives that can be remote activated
			*/
			if !(_isRemoteCharge) then {
				[_unit, _magazine, netId _projectile] call ExileClient_MineLimiter_network_placeMineRequest;
			}
			else
			{
				private _ownedMines = getAllOwnedMines _unit;
				if !(_projectile in _ownedMines) then {
					_ownedMines pushBack _projectile;
				};

				_unit setVariable["ownedMines", _ownedMines];
			};

			//END
		};
		case "Throw":
		{
		};
		default 
		{
			ExileClientPlayerIsInCombat = true;
			ExileClientPlayerLastCombatAt = diag_tickTime;
			true call ExileClient_gui_hud_toggleCombatIcon;
			if !(isNull _projectile) then 
			{
				if (cameraView isEqualTo "GUNNER") then 
				{
					if (isNumber (configFile >> "CfgMagazines" >> _magazine >> "exileBulletCam")) then 
					{
						call ExileClient_system_bulletCam_destroy;
						ExileClientBulletCameraThread = _projectile spawn ExileClient_system_bulletCam_thread;
					};
				};
			};
		};
	};
};
true