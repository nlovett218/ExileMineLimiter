/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private ['_code', '_function', '_file'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
    ['ExileServer_MineLimiter_network_placeMineRequest','MineLimiter_Server\code\ExileServer_MineLimiter_network_placeMineRequest.sqf'],
    ['ExileServer_MineLimiter_network_disarmMineRequest', 'MineLimiter_Server\code\ExileServer_MineLimiter_network_disarmMineRequest.sqf'],
    ['ExileServer_MineLimiter_network_disarmMineFailedRequest', 'MineLimiter_Server\code\ExileServer_MineLimiter_network_disarmMineFailedRequest.sqf'],
    ['ExileServer_MineLimiter_network_setMineWeight', 'MineLimiter_Server\code\ExileServer_MineLimiter_network_setMineWeight.sqf'],
    ['ExileServer_MineLimiter_network_loadAllMines', 'MineLimiter_Server\code\ExileServer_MineLimiter_network_loadAllMines.sqf'],
    ['ExileServer_MineLimiter_mine_database_load', 'MineLimiter_Server\code\ExileServer_MineLimiter_mine_database_load.sqf'],
    ['ExileServer_MineLimiter_network_onDeleteMine', 'MineLimiter_Server\code\ExileServer_MineLimiter_network_onDeleteMine.sqf']
];

true
