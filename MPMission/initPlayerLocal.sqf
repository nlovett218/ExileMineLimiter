//Put this near the top
[] execVM "custom\MineLimiter_Client\MineLimiter_Client_init.sqf";


//What this does is it returns the closest mine/bomb in proximity to the player so they can disarm it
fnc_getClosestBomb = {
    private _MineBase = nearestObject [player, "MineBase"];
    private _PipeBombBase = nearestObject [player, "PipeBombBase"];
    private _TimeBombCore = nearestObject [player, "TimeBombCore"];

    private _closestMine = [[_MineBase,_PipeBombBase,_TimeBombCore], [], { player distance _x }, "ASCEND"] call BIS_fnc_sortBy;

    _closestMine select 0
};
