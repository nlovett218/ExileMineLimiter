private["_sessionID", "_paramaters", "_objectNetId", "_id", "_object", "_player", "_class", "_mineObj", "_mineClass", "_classTypes", "_databaseID", "_playerMineWeight", "_classInfo", "_position", "_vectorDirection", "_vectorUp", "_defaultWeight", "_success", "_data", "_extDB3Message", "_databaseID", "_territoryOnlyEnabled"];
_sessionID = _this select 0;
_paramaters = _this select 1;

_player = _paramaters select 0;
_class = _paramaters select 1;
_objectNetId = _paramaters select 2;
//_direction = _paramaters select 3;

_success = false;

try 
{
	if (isNull _object) then
	{
		throw "Object doesn't exist! Contact server admin!";
	};

	if !(_class in _classTypes) then
	{
		throw "This mine is not allowed to be placed!";
	};

	if ((getPosATL _player) call ExileServer_util_world_isInTraderZone) then 
	{
		throw "Really? You are in a safe zone!";
	};

	if (_territoryOnlyEnabled && (!(_player call ExileServer_util_world_isInOwnTerritory)))
	{
		throw "Placing mines outside friendly territories is not allowed!";
	};

	_object = objectFromNetId _objectNetId;
	_mineClass = _object call CBA_fnc_getObjectConfig;
	_playerMineWeight = _player getVariable["KFB_totalMineWeight", 0];
	_classInfo = (missionConfigFile >> "CfgMine" >> "types");
	_maxWeight = getNumber (missionConfigFile >> "CfgMine" >> "maxWeight");
	_defaultWeight = getNumber (missionConfigFile >> "CfgMine" >> "defaultWeight");
	_classTypes = getArray (missionConfigFile >> "CfgMine" >> "classTypes");
	_territoryOnlyEnabled = (missionConfigFile >> "CfgMine" >> "territoryOnly") call BIS_fnc_getCfgDataBool;

	private _vectorDirAndUp = [vectorDir _object, vectorUp _object];
	_position = getPos _object;
	_vectorDirection = direction _object;
	_vectorUp = vectorUp _object;

	/*

		So to elaborate on the weight system

		Basically you start out with a total of 150 "points"

		Each mine type is worth a certain amount of "points" defined the config.cpp in your mission folder

		When you place a mine, it calculates how many points you have total UP TO the maximum allowed which is 150

		So if an APERS mine is worth 50 points, that means I can place down 3 total APERS mines.

		If a flare mine is worth 10 points, that means you can put down 15 of those.

		You can mix those up to meet the maximum amount: 2 APERS, 5 FLARE MINES, etc.

		I have this system in place to give a little "flexibility" to the players

		If you plan on removing weights in general, you'll need to make sure that you update all references to KFB_totalMineWeight and 
		any calls to setMineWeight

		You're smart, I'm sure you'll figure out what you need to get it working for what you want.
	*/

	private _newWeight = 0;
	private _weightFromClass = 0;

	_weightFromClass = getNumber (_classInfo >> _class >> "weight");

	if (_weightFromClass isEqualTo 0) then 
	{
		if (_playerMineWeight + _defaultWeight > _maxWeight) then 
		{
			throw format["Too many mines already placed of this type! %1", _playerMineWeight];
		};

		_newWeight = _playerMineWeight + _defaultWeight;
	}
	else
	{

		if (_playerMineWeight + _weightFromClass > _maxWeight) then
		{ 
			throw format["Too many mines already placed of this type! %1", _playerMineWeight];
		};

		_newWeight = _playerMineWeight + _weightFromClass;
	};

	_player setVariable["KFB_totalMineWeight", _newWeight, true];

	deleteVehicle _object;

	_success = true;
}
catch
{
	[_sessionID, "toastRequest", ["ErrorTitleAndText", ["Failed to place mine!", _exception]]] call ExileServer_system_network_send_to;
	_exception call ExileServer_util_log;
};

if (_success) then 
{
	[_sessionID, "toastRequest", ["SuccessTitleAndText", ["Hoorah!", "A new mine has been placed where you wanted it!"]]] call ExileServer_system_network_send_to;

	/* 
		We need to get the CfgVehicle type from the given CfgMagazine type
		Which is where our config.cpp comes in to play
	*/
	private _vehicleClassFromType = getText (missionConfigFile >> "CfgMine" >> "types" >> _class >> "CfgVehicleName");
	_position = _player modelToWorld [0,0.7,0];
	private _mine = createMine [_vehicleClassFromType, _position, [], 0];
	private _playerDir = ((direction _player));

	/*

		Always make sure when you setDir or setPos on mines, you propogate them on ALL clients AND server
		This is not done automatically due to the limited functionality of CfgAmmo
	*/
	[[_mine, _playerDir, _position], {(_this select 0) setDir (_this select 1); (_this select 0) setPosATL (_this select 2); (_this select 0) setVectorUp surfaceNormal position (_this select 0);}] remoteExec ["call", 0, true];
	_mine setDir _playerDir;
	_mine setPosATL _position;
	_mine setVectorUp surfaceNormal position _mine;

	/*
		Here we get the newly created mine's netId so we can reference it later

		We then set the mine's ownership to the player through setShotParents

		addOwnedMine is used for remote activation bombs ONLY!

		I left this in in case you want to mess around with limiting satchels at one point (not tested)
	*/

	private _mineNetId = netId _mine;
	_mineObj = objectFromNetId _mineNetId;
	_player addOwnedMine _mine;
	_mine setShotParents [vehicle _player, _player];

	/*
		Ok so after doing what we need on the mine itself, we then convert the reference to the mine to a LOCATION datatype
		Which CBA does for us

		This allows us to use setVariable on it, because you can't use setVariable on CfgAmmo types

		true call CBA_fnc_createNamespace

		The 'true' just simply means it's a global namespace which really doesn't affect us since this is all server sided anyways

		isValidMine MUST stay because if there are other CBA namespaces then the script will loop through them as if they were a mine
		so we keep isValidMine as a check

		Big shoutout to commy2 on reddit for giving me this information!
	*/

	_mineObj = true call CBA_fnc_createNamespace;

	_mineObj setVariable ["netId", _mineNetId];
	_mineObj setVariable ["class", _class];
	_mineObj setVariable ["position", _position];
	_mineObj setVariable ["direction", _vectorDirection];
	_mineObj setVariable ["up", _vectorUp];
	_mineObj setVariable ["ownerID", getPlayerUID _player];
	_mineObj setVariable ["isPersistent", false];
	_mineObj setVariable ["isValidMine", true];


	/*
		Pretty simple, if user is in own territory it creates a persistent mine

		This is where you can add your own code and edit things as you wish.
	*/
	if (_player call ExileServer_util_world_isInOwnTerritory) then 
	{
		private _flag = (getPos _player) call ExileServer_util_world_getTerritoryAtPosition;

		private _data =
		[
			getPlayerUID _player,
			_class,
			_position select 0,
			_position select 1,
			_position select 2,
			_vectorDirection,
			_flag getVariable["ExileDatabaseID", nil]
		];

		private _extDB3Message = ["createPersistentMine", _data] call ExileServer_util_extDB2_createMessage;
		private _databaseID = _extDB3Message call ExileServer_system_database_query_insertSingle;
		_mineObj setVariable["ExileDatabaseID", _databaseID];
		_mineObj setVariable["isPersistent", true];

		//The above 2 lines make it so when we reference this mine later, we know it will be a persistent mine
	};
}
else
{
	//Return mine to player inventory if failed to place
	if (_player canAddItemToVest _class) then
	{
		_player addItemToVest _class;
	}
	else
	{
		if (_player canAddItemToBackpack _class) then
		{
			_player addItemToBackpack _class;
		};
	};
};

