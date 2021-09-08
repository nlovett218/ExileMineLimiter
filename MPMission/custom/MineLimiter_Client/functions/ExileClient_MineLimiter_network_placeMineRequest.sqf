/*

	Client sided request
*/

if (!hasInterface && isServer) exitWith {};

private["_objectNetId", "_class", "_player"];
disableSerialization;
_player = _this select 0;
_class = _this select 1;
_objectNetId = _this select 2;

try 
{
	if (isNil "_objectNetId") then
	{
		throw "MineRequest_client: Object is null";
	};
	if (isNil "_class") then
	{
		throw "MineRequest_client: Class is null";
	};
	if (isNil "_player") then
	{
		throw "MineRequest_client: Player is null";
	};

	["placeMineRequest", [player, _class, _objectNetId]] call ExileClient_system_network_send;
}
catch
{
	diag_log _exception;
};
