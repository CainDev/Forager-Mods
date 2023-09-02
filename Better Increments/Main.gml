#define Main
    Trace("Better Increments Loaded");
    CommandCreate("craft", 0, ScriptWrap(ReceiveInput));
    CommandCreate("inctextoff", 0, ScriptWrap(ToggleText));
    global.showText = true;

#define ReceiveInput(_args)
    try {
        if(!instance_exists(uiCrafting)){
            Trace("Make sure the Crafting Menu is open.");
        } else {
            if(_args != undefined){
                var input = real(_args[0]);
                if(floor(input) == input){
                    uiCrafting.quantitySelected = input;
                    if(global.showText) Trace("Crafting amount set to " + (string(input)));
                }
            } else {
                Trace("Please make sure you enter a proper integer.");
            }
        }
    } catch(_exception) {
        Trace("Please make sure you enter a proper integer.");
    }
    
#define ToggleText
    if(global.showText){
        Trace("Disabling Crafting Text");
        global.showText = !global.showText;
    } else {
        Trace("Enabling Crafting Text");
        global.showText = !global.showText;
    }
    
    
