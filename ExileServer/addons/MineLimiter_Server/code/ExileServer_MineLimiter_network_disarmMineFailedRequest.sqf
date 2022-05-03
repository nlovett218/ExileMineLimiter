private["_sessionID", "_paramaters", "_objectNetId", "_object"];
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

	diag_log format ["Failed disarm mine type: %1", typeOf _object];

	//This "should" detonate the object if the disarm was unsuccessful (haven't really tested tbh)
	triggerAmmo _object;
	_object setDamage 1;
}
catch {};