private["_sessionID", "_paramaters", "_objectNetId", "_object", "_ExileDatabaseID"];
_sessionID = _this select 0;
_paramaters = _this select 1;

_objectNetId = _paramaters select 0;
_object = objectFromNetId _objectNetId;

try {
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _object) then {
		throw "Object is null";
	};
	if (isNull _playerObject) then {
		throw "Hacker level 100000000";
	};

	diag_log format ["mine type: %1", typeOf _object];

	deleteVehicle _object;

	private _ExileDatabaseID = _object getVariable["ExileDatabaseID", -1];

	if (_ExileDatabaseID >= 0) then {
		format["deletePersistentMine:%1", _ExileDatabaseID] call ExileServer_system_database_query_fireAndForget;
	};

	[_sessionID, "toastRequest", ["SuccessTitleAndText", ["Mine disarmed!", "You can breathe now!"]]] call ExileServer_system_network_send_to;
}
catch {
	[_sessionID, "toastRequest", ["ErrorTitleAndText", ["Mine not disarmed!", _exception]]] call ExileServer_system_network_send_to;
};