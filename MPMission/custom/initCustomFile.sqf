//initServerFile
private ['_code', '_function', '_file'];

if (!hasInterface && isServer) then 
{
	{
	    _code = '';
	    _function = _x select 0;
	    _file = _x select 1;

	    _code = compileFinal (preprocessFileLineNumbers _file);

	    missionNamespace setVariable [_function, _code];
	}
	forEach
	[
		['ExileServer_util_world_isInOwnTerritory','custom\territory\ExileServer_util_world_isInOwnTerritory.sqf'],
		['ExileServer_util_world_getTerritoryAtPosition', 'custom\territory\ExileServer_util_world_getTerritoryAtPosition.sqf'],
		['ExileServer_sound_network_playSoundAtRequest', 'custom\sound\ExileServer_sound_network_playSoundAtRequest.sqf'],
	    ['ExileServer_MineLimiter_disarmMine_addActionHandler', 'custom\MineLimiter_Client\functions\ExileServer_MineLimiter_disarmMine_addActionHandler.sqf'],
	];
};

if (hasInterface && !isServer) then 
{
	{
	    _code = '';
	    _function = _x select 0;
	    _file = _x select 1;

	    _code = compileFinal (preprocessFileLineNumbers _file);

	    missionNamespace setVariable [_function, _code];
	}
	forEach
	[
	    ['ExileClient_action_disarmMine_condition', 'custom\MineLimiter_Client\functions\ExileClient_action_disarmMine_condition.sqf'],
	    ['ExileClient_action_disarmMine_completed', 'custom\MineLimiter_Client\functions\ExileClient_action_disarmMine_completed.sqf'],
	    ['ExileClient_action_disarmMine_aborted', 'custom\MineLimiter_Client\functions\ExileClient_action_disarmMine_aborted.sqf'],
	    ['ExileClient_action_disarmMine_failed', 'custom\MineLimiter_Client\functions\ExileClient_action_disarmMine_failed.sqf'],
	    ['ExileClient_MineLimiter_disarmMine_canDisarmMine', 'custom\MineLimiter_Client\functions\ExileClient_MineLimiter_disarmMine_canDisarmMine.sqf'],
	];
}
