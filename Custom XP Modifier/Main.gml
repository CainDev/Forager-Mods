#define Main
    global.customXP = false;
    global.customXPMod = 0;
    
    CommandCreate("xpmodify", 0, ScriptWrap(SetXPMultiplier), "1 - 25");

#define OnResourceDestroy(inst)
    if(room == rmGame){
        if(global.customXP){
            var xpMulti = global.customXPMod;
            var currXP = floor(objPlayer.xp);
            var xp = newXP - currXP;
                
            // The reason we subtract the original value is because
            // its already been applied we only add the extra xp on afterwards.
            var newXpTotal = (xp * xpMulti) - xp;
            objPlayer.xpToGain += newXpTotal;
        }
    }


#define SetXPMultiplier(_args)
    if(_args == undefined) {
        Trace("Please provide a value.")
        exit;
    }   
    
    var input = real(_args[0]);
    
    if(input > 25 || input < 1){
        Trace("Please provide a value between 1 and 25");
        exit;
    } else if(input == 1){
        Trace("Custom XP Mod Disabled, Returning to Base XP.")
        global.customXP = false;
        global.customXPMod = 1;
    } else {
        Trace("Custom XP Mod Enabled, Current Rate: " + string(input))
        global.customXP = true;
        global.customXPMod = input;
    }