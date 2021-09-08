/**
 * ExileClient_action_disarmMine_condition
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 

/*
	This is exile's condition check when doing a DelayedAction
*/

private["_mine", "_result"];
_mine = _this;
_result = "";

private _allowDisarming = getNumber(missionConfigFile >> "CfgMine" >> "allowDisarming"); 
private _disarmingRequiresTool = getNumber(missionConfigFile >> "CfgMine" >> "disarmingRequiresTool");
private _disarmingTool = getText(missionConfigFile >> "CfgMine" >> "disarmingTool");
private _activationDistance = getNumber(missionConfigFile >> "CfgMine" >> "disarmActivationDistance");

try 
{
	if !(_allowDisarming isEqualTo 1) then
	{
		throw "Disarming is disabled!";
	};
	if (ExilePlayerInSafezone) then
	{
		throw "You are in a safe zone!";
	};
	if !(_disarmingTool in (magazines player) && _disarmingRequiresTool isEqualTo 1) then
	{
		throw "You need pliers!";
	};
	if ((_mine distance player) > _activationDistance) then 
	{
		throw "You are too far away!";
	};
}
catch 
{
	_result = _exception;
};
_result