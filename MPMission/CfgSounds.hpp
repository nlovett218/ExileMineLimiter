/*
    This will reference your sound files. This is an example. In my method, I used a custom mod pack that was MP signed. 
    Be sure to change this to where your sound files will be located, either in MPMission or in your own mod pack.
*/

class CfgSounds
{
    sounds[] = {"mine_disarming"};

    class mine_disarming
    {
        name = "mine_disarming";
        sound[] = {"\kfb_assets\sound\mine_disarming.ogg", 1, 1};
        titles[] = {};
    };
}