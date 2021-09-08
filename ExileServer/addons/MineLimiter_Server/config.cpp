class CfgPatches
{
	class MineLimiter_Server
	{
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_client","exile_assets","exile_server_config"};
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
	};
};
class CfgFunctions
{
    class MineLimiter_Server
    {
        class Bootstrap
        {
            file = "MineLimiter_Server\bootstrap";
            class preInit
            {
                preInit = 1;
            };
            class postInit
            {
                postInit = 1;
            };
        };
    };
};
class CfgNetworkMessages
{
    class placeMineRequest
    {
        // Declare the module, this is part of the file name
        module = "MineLimiter";

        // Declare the parameters, these are the typeNames of the fields in the package
        parameters[] = {
            "OBJECT",     // player
            "STRING",     // class
            "STRING"        // netId
        };
    };

    class placeMineResponse
    {
        // Declare the module, this is part of the file name
        module = "MineLimiter";

        // Declare the parameters, these are the typeNames of the fields in the package
        parameters[] = {
            "STRING",     // Net ID of object
            "STRING",     // weapon type
            "STRING",      // weapon mag
            "BOOL"       // response
        };
    };

    class disarmMineRequest
    {
        // Declare the module, this is part of the file name
        module = "MineLimiter";

        // Declare the parameters, these are the typeNames of the fields in the package
        parameters[] = {
            "STRING"     // Net ID of object
        };
    };

    class disarmMineFailedRequest
    {
        // Declare the module, this is part of the file name
        module = "MineLimiter";

        // Declare the parameters, these are the typeNames of the fields in the package
        parameters[] = {
            "STRING"     // Net ID of object
        };
    };
};
