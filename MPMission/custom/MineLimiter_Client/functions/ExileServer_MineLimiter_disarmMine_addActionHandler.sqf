/*
    Ok so two things to note here

    1. This loop basically checks to see if a player is nearby a mine and then sends them the addAction command
       This reduces the amount of loops needed on the client until it is necessary

       So for example a player joins, there's no reason why they should have a loop going if it is not needed
       However, if they get near a mine, that's when we would need to give them that loop.
       The loop im referring to is the condition check ExileClient_MineLimiter_disarmMine_canDisarmMine.sqf

    2. When a player dies you need to reset the KFB_mineAddAction variable to false so the addAction gets readded when they respawn.
*/

diag_log "Running MineLimiter AddActionHandler...";

private _activationDistance = getNumber(missionConfigFile >> "CfgMine" >> "disarmActivationDistance");

[
    5,
    {
        private _namespaces = call CBA_fnc_allNamespaces;
        private _cfgAmmo = configFile >> "CfgAmmo";

        {
    
            private _namespace = _x;
            private _validMine = _namespace getVariable ["isValidMine", false];

            if (_validMine) then
            {
                private _mineNetId = _namespace getVariable["netId", nil];
                private _mineObj = objectFromNetId _mineNetId;

                if (isNull _mineObj) then {}
                else
                {
                    {
                        private _player = _x;
                        private _addActionAdded = _player getVariable["KFB_mineAddAction", false];

                        if (alive _player) then 
                        {
                            if (_mineObj distance _player <= 15 && (!(_addActionAdded)) && (!(getModelInfo _mineObj select 0 isEqualTo "empty.p3d"))) then 
                            {
                                _player setVariable["KFB_mineAddAction", true, true];

                                [_player, ["<t color='#B30000'>Disarm Nearby Mine</t>", "['DisarmMine', call fnc_getClosestBomb] call ExileClient_action_execute;", nil, 0, true, true, "", "call ExileClient_MineLimiter_disarmMine_canDisarmMine", _activationDistance, false]] remoteExec ["addAction",_player];
                            };
                        };
                    }
                    foreach allPlayers;
                };
            };
        } 
        foreach _namespaces;
    },
    [],
    true,
    true
] call ExileServer_system_thread_addtask;