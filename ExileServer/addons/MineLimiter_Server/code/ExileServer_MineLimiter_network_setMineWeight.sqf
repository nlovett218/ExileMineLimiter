params["_player", "_mineNetIdArray"];

if (isNil "_player" && isNil "_mineNetIdArray") exitWith { 
	diag_log "_player and _mineNetIdArray both nil"; 
};

private _classInfo = missionConfigFile >> "CfgMine" >> "types";
private _maxWeight = getNumber (missionConfigFile >> "CfgMine" >> "maxWeight");
private _defaultWeight = getNumber (missionConfigFile >> "CfgMine" >> "defaultWeight");
private _newWeight = 0;

{
	private _netId = _x select 0;
	private _class = _x select 1;

	private _weightFromClass = getNumber (_classInfo >> _class >> "weight");

	if (_weightFromClass isEqualTo 0) then 
	{
		_weightFromClass = _defaultWeight;
	};

	_newWeight = _newWeight + _weightFromClass;
}
foreach _mineNetIdArray;

//diag_log format ["Setting mine weight %1", _newWeight];

_player setVariable["KFB_totalMineWeight", _newWeight, true];