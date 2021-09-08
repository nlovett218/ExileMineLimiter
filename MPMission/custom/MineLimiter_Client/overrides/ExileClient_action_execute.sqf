// THIS IS NOT THE FULL ExileClient_action_execute.sqf !!! YOU MUST MERGE THIS FILE!


/*
    Define _sound paramater
*/

_missionConfig = missionConfigFile >> "CfgExileDelayedActions" >> _actionName;
_actionConfig = if (isClass _missionConfig) then {_missionConfig} else {configFile >> "CfgExileDelayedActions" >> _actionName};

_sound = getText (_actionConfig >> "playingSound");

if (_sound != "") then 
{
    /*
        param1: net id of player
        param2: sound id from CfgSounds
        param3: sound max distance
    */
	["playSoundAtRequest", [netId player, _sound, 50]] call ExileClient_system_network_send;
};



/*
    This will be near the bottom. Ensures the sound is stopped and/or deleted.

    |
    |
    v
*/
private _soundVehicle = (getPos player) nearestObject "#soundonvehicle";
deleteVehicle _soundVehicle;