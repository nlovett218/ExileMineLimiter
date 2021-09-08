/**
 * ExileClient_util_world_isInOwnTerritory
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_playerObject", "_sessionID", "_is", "_territory"];
_playerObject = _this;
_is = false;
//_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
_territory = (getPosATL _playerObject) call ExileServer_util_world_getTerritoryAtPosition;
if(!isNull _territory)then
{
	//diag_log "Found Territory! Not null";
	//diag_log format ["Territory Build Rights: %1", _territory getVariable ["ExileTerritoryBuildRights",[]]];
	if((getPlayerUID _playerObject) in (_territory getVariable ["ExileTerritoryBuildRights",[]]))then
	{
		//diag_log "Player is in build rights";
		_is = true;
	}
	else
	{
		//diag_log "Player is NOT in build rights";
	};
}
else 
{
	//diag_log "Territory is null and DOES NOT EXIST!";
};
_is