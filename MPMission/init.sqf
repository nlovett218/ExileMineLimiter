[] execVM "custom\initCustomFile.sqf";

if (isServer) then { 

    [
    	2,
	    { 
	        (_this select 0) params ["_previousMines"]; 
	        if (isNil "_previousMines") then {
	        	_previousMines = [];
	        };
	 
	        private _namespaces = call CBA_fnc_allNamespaces;

	        private _currentMines = [];

	        {
	        	private _namespace = _x;
	        	private _validMine = _namespace getVariable ["isValidMine", false];

	        	if (_validMine) then 
	        	{
		        	private _mineNetId = _namespace getVariable["netId", nil];
		        	private _mineOwner = _namespace getVariable["ownerID", nil];
		        	private _mineClass =  _namespace getVariable["class", nil];
		        	private _minePosition =  _namespace getVariable["position", nil];
		        	private _mineDir =  _namespace getVariable["direction", nil];
		        	private _mineUp =  _namespace getVariable["up", nil];
		        	private _mineDatabaseID = _namespace getVariable["ExileDatabaseID", -1];
		        	private _minePersistent = _namespace getVariable["isPersistent", false];

		        	private _player = nil;

	        		_player = [_mineOwner] call fnc_getPlayerFromUID;

		        	if !(isNull objectFromNetId _mineNetId) then 
		        	{
		        		private _mineObj = objectFromNetId _mineNetId;

		        		_currentMines pushBack [_mineNetId, _mineOwner, _mineClass, _minePosition, _mineDir, _mineUp, _validMine, _mineDatabaseID, _minePersistent];

		        		if !(isNil "_player") then 
		        		{
			        		private _ownedMines = _player getVariable["KFB_ownedMines", []];

			        		if !([_mineNetId, _mineClass] in _ownedMines) then 
			        		{
			        			diag_log format["Adding new _mineNetId %1 to array", _mineNetId];
			        			_ownedMines pushBack [_mineNetId, _mineClass];
			        			_mineObj setShotParents [vehicle _player, _player];

			        			_player setVariable["KFB_ownedMines", _ownedMines, true];
			        		};

							[_player, _ownedMines] call ExileServer_MineLimiter_network_setMineWeight;
		        		};
		        	}
		        	else
		        	{
		        		//diag_log format ["Mine deleted from world | Total Mine Weight For '%1': %2", name _player, _player getVariable["KFB_totalMineWeight", 0]];
		        		_namespace call CBA_fnc_deleteNamespace;
		        	};
	        	};
	    	} foreach _namespaces;

	        private _deletedMines = _previousMines - _currentMines;  
	 
	        { 
	            ["Mission_MineDeleted", [_x]] call CBA_fnc_globalEvent; 
	        } forEach _deletedMines; 
	 
	        (_this select 0) set [0, _currentMines]; 
	    }, 
	    [[]],
	    true,
	    true
    ] call ExileServer_system_thread_addTask;

    ["Mission_MineDeleted", { 
		params ["_mine"];
	    //When a mine is deleted, we run this function
	    [_mine] call ExileServer_MineLimiter_network_onDeleteMine;
	}] call CBA_fnc_addEventHandler;
}; 
 

fnc_getPlayerFromUID = {
	params["_uid"];

	private _player = nil;

	{
		if (getPlayerUID _x isEqualTo _uid) then {
			_player = _x;
		};
	}
	foreach allPlayers;

	if (isNil "_player") exitWith { nil };

	_player
};
