params ["_mine"];

diag_log "Deleting a mine from the world!";

private _mineNetId = _mine select 0;
private _owner = _mine select 1; //getVariable["ownerID", ""];
private _mineClass = _mine select 2;
private _isPersistent = _mine select 8; //getVariable["isPersistent", false];
private _databaseIDFromEntity = _mine select 7; //getVariable["ExileDatabaseID", ""];
private _player = [_owner] call fnc_getPlayerFromUID;

private _ownedMines = _player getVariable["KFB_ownedMines", []];

//This prints out a lot of array data
//diag_log format["Mine Net ID array: %1", _ownedMines];

if ([_mineNetId, _mineClass] in _ownedMines) then {
	diag_log format["Found type %1 in mine array", _mineClass];
	_ownedMines = _ownedMines - [[_mineNetId, _mineClass]];
	_player setVariable["KFB_ownedMines", _ownedMines, true];

	//diag_log format["Mine Net ID array after delete: %1", _ownedMines];
};

[_player, _ownedMines] call ExileServer_MineLimiter_network_setMineWeight;

if (_isPersistent) then {

	if !(isNil "_databaseIDFromEntity") then {
		format ["deletePersistentMine:%1", _databaseIDFromEntity] call ExileServer_system_database_query_fireAndForget;
	};
};