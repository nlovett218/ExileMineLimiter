private["_continueLoading", "_page", "_pageSize", "_mineIDs", "_numberOfMines", "_i"];
//ExileMines = [];
"Loading mines from database..." call ExileServer_util_log;
_continueLoading = true;
_page = 0;
_pageSize = 100;
while {_continueLoading} do 
{
	_mineIDs = format ["getPersistentMineIdPage:%1:%2", _page * _pageSize, _pageSize] call ExileServer_system_database_query_selectFull;
	_numberOfMines = count _mineIDs;
	if (_numberOfMines > 0) then 
	{
		for "_i" from 0 to _numberOfMines - 1 do 
		{
			((_mineIDs select _i)select 0) call ExileServer_MineLimiter_mine_database_load;
		};
	};
	_page = _page + 1;
	if (_numberOfMines < 100) then
	{
		_continueLoading = false;
	};
};
"Done loading mines!" call ExileServer_util_log;
true