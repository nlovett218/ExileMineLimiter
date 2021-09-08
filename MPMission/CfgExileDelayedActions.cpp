class CfgExileDelayedActions
{
    class Abstract
    {
        duration = 10;
        abortInCombatMode = 1;
        durationFunction = "";
        animation = "";
        animationType = "switchMove";
        failChance = 0;
        conditionFunction = "";
        completedFunction = "";
        abortedFunction = "";
        failedFunction = "";
        repeatingCheckFunction = "";
        playingSound = "";
    };

    class DisarmMine: Abstract
    {
        duration = 10;
        failChance = 5;
        abortInCombatMode = 0;
        animationType = "switchMove";
        animation = "Exile_Acts_RepairVehicle01_Animation01";
        conditionFunction = "ExileClient_action_disarmMine_condition";
        completedFunction = "ExileClient_action_disarmMine_completed";
        abortedFunction = "ExileClient_action_disarmMine_aborted";
        failedFunction = "ExileClient_action_disarmMine_failed";
        playingSound = "mine_disarming";
    };

};