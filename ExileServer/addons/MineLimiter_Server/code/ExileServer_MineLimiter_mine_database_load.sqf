/**
 * ExileServer_MineLimiter_mine_database_load
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_mineId", "_data", "_id", "_owner", "_position", "_class", "_spawned_at", "_direction"];
_mineId = _this;
_data = format ["getPersistentMine:%1", _mineId] call ExileServer_system_database_query_selectSingle;

_id = _data select 0;
_class = _data select 1;
_spawned_at = _data select 2;
_owner = _data select 3;
_position = 
[
    _data select 4,
    _data select 5,
    _data select 6
];
_direction = _data select 7;

private _vehicleClassFromType = getText (missionConfigFile >> "CfgMine" >> "types" >> _class >> "CfgVehicleName");
private _mine = createMine [_vehicleClassFromType, _position, [], 0];

[[_mine, _direction, _position], {(_this select 0) setDir (_this select 1); (_this select 0) setPosATL (_this select 2); (_this select 0) setVectorUp surfaceNormal position (_this select 0);}] remoteExec ["call", 0, true];

_mine setDir _direction;
_mine setPosATL _position;
_mine setVectorUp surfaceNormal position _mine;

private _mineNetId = netId _mine;
private _mineObj = objectFromNetId _mineNetId;
private _vectorUp = vectorUp _mine;

_mineObj = true call CBA_fnc_createNamespace;

_mineObj setVariable ["netId", _mineNetId];
_mineObj setVariable ["class", _class];
_mineObj setVariable ["position", _position];
_mineObj setVariable ["direction", _direction];
_mineObj setVariable ["up", _vectorUp];
_mineObj setVariable ["ownerID", _owner];
_mineObj setVariable ["isPersistent", true];
_mineObj setVariable ["ExileDatabaseID", _id];
_mineObj setVariable ["isValidMine", true];

true 