/*

	This is my custom condition check for the addActionHandler

	It basically returns true/false if a mine can be disarmed nearby
*/

params ["_target", "_this", "_originalTarget"];

private _disarmingTool = getText(missionConfigFile >> "CfgMine" >> "disarmingTool");
private _activationDistance = getNumber(missionConfigFile >> "CfgMine" >> "disarmActivationDistance");
private _result = true;

try 
{
	private _MineBase = nearestObject [player, "MineBase"];
	private _PipeBombBase = nearestObject [player, "PipeBombBase"];
	private _TimeBombCore = nearestObject [player, "TimeBombCore"];

	if (isNull _MineBase && isNull _PipeBombBase && isNull _TimeBombCore) then
	{
		_result = false;
	};

	if !(_disarmingTool in (magazines player)) then
	{
		_result = false;
	};

	if !(vehicle player == player) then
	{
		_result = false;
	};

	private _closestBomb = call fnc_getClosestBomb;

	if (((getPosATL player) distance _closestBomb) > _activationDistance) then
	{
		_result = false;
	};
}
catch {

	diag_log _exception;
	_result = false;
};

_result