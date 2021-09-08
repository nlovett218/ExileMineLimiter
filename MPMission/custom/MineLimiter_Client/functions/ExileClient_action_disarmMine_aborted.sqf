/**
 * ExileClient_action_hackLock_aborted
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */


/*

	I wanted to troll my friends a bit with _blowUpOn, basically if they abort the defusal for any reason it blows up automatically :)
*/

private _blowUpOn = getArray(missionConfigFile >> "CfgMine" >> "BlowUpOnUID");
private _failChance = getNumber(missionConfigFile >> "CfgExileDelayedActions" >> "DisarmMine" >> "failChance");

if ((getPlayerUID player) in _blowUpOn) exitWith {
	["disarmMineFailedRequest", [netId _this]] call ExileClient_system_network_send;
	["ErrorTitleAndText", ["KABOOM!", "Disarm mine interrupted!"]] call ExileClient_gui_toaster_addTemplateToast;
};

private _chanceNum = [0, 100] call BIS_fnc_randomNum;

if (_chanceNum < _failChance) exitWith {
	["disarmMineFailedRequest", [netId _this]] call ExileClient_system_network_send;
	["ErrorTitleAndText", ["KABOOM!", "Mine was triggered!"]] call ExileClient_gui_toaster_addTemplateToast;
};