//ExileServer_Sound_network_playSoundAtRequest

private["_sessionID", "_parameters", "_playerNetId", "_soundID", "_maxDistance"];
_sessionID = _this select 0;
_parameters = _this select 1;

try 
{
	diag_log "Attempting to play sound";

	_playerNetId = _parameters select 0;
	_soundID = _parameters select 1;
	_maxDistance = _parameters select 2;


	private _playerObj = objectFromNetId _playerNetId;

	if (_playerObj isEqualTo ObjNull) throw "< SoundRequest > No valid player object selected";

	[_playerObj, [_soundID, _maxDistance, 1]] remoteExec ["say3D", -2, false];
}
catch
{
	diag_log format["< SoundRequest > Failed to play sound | %1", _exception];
};