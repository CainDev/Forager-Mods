// Hello source code grubber. Follow me on Github.
// https://github.com/CainDev
// https://github.com/CainDev
// https://github.com/CainDev

#define Main
    global.isAlive = false;
    global.hideMenu = true;
    global.toggleStickyCursor = false;
    global.maxHp = 0;
    global.overlayPosition = 5;
    global.mousePosition = 0;
    
    // Custom Locations
    global.customHpEnabled = false;
    global.customHpX = 0;
    global.customHpY = 0;
    
    global.customDmgEnabled = false;
    global.customDmgX = 0;
    global.customDmgY = 0;
    
    global.customLocationEnabled = false;
    global.customLocationX = 0;
    global.customLocationY = 0;
    
    // Create Commands
    CommandCreate("stickyDamageOverlay", 0, ScriptWrap(StickyCursor), "[Toggles sticky damage.]");
    CommandCreate("basicOverlayPos", 0, ScriptWrap(SelectLocation), "[1 - 3.]");
    CommandCreate("mouseOverlayPos", 0, ScriptWrap(SelectLocationMouse), "[1 - 3.]");
    
    CommandCreate("enableCustomHPLoc", 0, ScriptWrap(CustomHPLocation), "[Toggle on Custom HP Location.]");
    CommandCreate("enableCustomDMGLoc", 0, ScriptWrap(CustomDMGLocation), "[Toggle on Custom DMG Location.]");
    
#define OnStep
    // Small check to save many errors.
    CheckIfAlive();
    
    if(room == rmGame) {
        global.maxHp = objPlayer.hpMax;
    }
    
    if(global.isAlive){
        if (keyboard_check_pressed(ord("J"))) {
            global.hideMenu = !global.hideMenu;
        }
    }
    
#define OnDrawGUIEnd
    if(room == rmGame) {
       if(!global.hideMenu && global.isAlive) {
            var currHp = objPlayer.hp;
            var maxHp = objPlayer.hpMax;
            var currDamage = objPlayer.dmg;
            
            if(global.toggleStickyCursor){
                draw_text(window_mouse_get_x(), window_mouse_get_y(), "dmg:" + string(currDamage));
            }
            
            switch(global.overlayPosition){
                // Case 0 Reserved for Custom Mouse Location
                case 0:
                    if(global.customLocationEnabled){
                        if(currHp >= 10){ 
                            draw_text(global.customLocationX, global.customLocationY, "H:" + string(currHp) + "/" + string(maxHp));
                        } else {
                            draw_text(global.customLocationX - 8, global.customLocationY, "H:" + string(currHp) + "/" + string(maxHp));
                        }
                    
                        if(FixNumberSpacing(currDamage)){
                            draw_text(global.customLocationX - 1, global.customLocationY + 20, "dmg:" + string(currDamage));
                        } else {
                            draw_text(global.customLocationX + 17, global.customLocationY + 20, "dmg:" + string(currDamage));
                        }
                        
                        return;
                    } else {
                        if(global.customHpEnabled){
                            if(currHp >= 10){ 
                                draw_text(global.customHpX, global.customHpY, "H:" + string(currHp) + "/" + string(maxHp));
                            } else {
                                draw_text(global.customHpX - 8, global.customHpY, "H:" + string(currHp) + "/" + string(maxHp));
                            }
                        }
                        
                        if(global.customDmgEnabled){
                            if(FixNumberSpacing(currDamage)){
                                draw_text(global.customDmgX - 1, global.customDmgY + 20, "dmg:" + string(currDamage));
                            } else {
                                draw_text(global.customDmgX + 17, global.customDmgY + 20, "dmg:" + string(currDamage));
                            }
                        }
                    }
                    
                // Rest of Locations
                case 1:
                    if(currHp >= 10){
                        draw_text(475, 623, "H:" + string(currHp) + "/" + string(maxHp));
                    } else {
                        draw_text(475 - 8, 623, "H:" + string(currHp) + "/" + string(maxHp));
                    }
                    
                    if(FixNumberSpacing(currDamage)){
                        draw_text(475 - 1, 623 + 20, "dmg:" + string(currDamage));
                    } else {
                        draw_text(475 + 17, 623 + 20, "dmg:" + string(currDamage));
                    }
                    
                    
                    return;
                    
                case 2:
                    if(currHp >= 10){
                        draw_text(58, 168, "H:" + string(currHp) + "/" + string(maxHp));
                    } else {
                        draw_text(58 - 8, 168, "H:" + string(currHp) + "/" + string(maxHp));
                    }
                        
                    if(FixNumberSpacing(currDamage)){
                        draw_text(58 - 1, 168 + 20, "dmg:" + string(currDamage));
                    } else {
                        draw_text(58 + 17, 168 + 20, "dmg:" + string(currDamage));
                    }
                    return;
                    
                case 3:
                    if(currHp >= 10){
                        draw_text(999, 58, "H:" + string(currHp) + "/" + string(maxHp));
                    } else {
                        draw_text(999 - 8, 58, "H:" + string(currHp) + "/" + string(maxHp));
                    }
                        
                    if(FixNumberSpacing(currDamage)){
                        draw_text(999 - 1, 58 + 20, "dmg:" + string(currDamage));
                    } else {
                        draw_text(999 + 17, 58 + 20, "dmg:" + string(currDamage));
                    }
                    return;
                    
                default:
                    break;
            }
        } 
    }

#define CustomHPLocation()
     if(room == rmGame){
        global.customHpEnabled = !global.customHpEnabled;
        global.customLocationEnabled = false;
        global.overlayPosition = 0;
        
        if(global.customHpEnabled){
            Trace("Custom HP Location Enabled!");
        } else {
            Trace("Custom HP Location Disabled!");
        }
     }

#define CustomDMGLocation()
     if(room == rmGame){
        global.customDmgEnabled = !global.customDmgEnabled;
        global.customLocationEnabled = false;
        global.overlayPosition = 0;
        
        if(global.customDmgEnabled){
            Trace("Custom DMG Location Enabled!");
        } else {
            Trace("Custom DMG Location Disabled!");
        }
     }

#define StickyCursor()
    if(room == rmGame){
        global.toggleStickyCursor = !global.toggleStickyCursor;
        
        if(global.toggleStickyCursor){
            Trace("Sticky Cursor Enabled.");
        } else {
            Trace("Sticky Cursor Disabled.");
        }
    } else {
        Trace("Please do this from within the game screen.")
    }

#define SelectLocationMouse(_args)
    if(room == rmGame){
        var input = _args[0];
        if(GMLIsShit(input)){
            input = real(input);
            
            if(input > 3 || input < 0){
                Trace("Please use a number between 0 and 3");
            } else {
                global.overlayPosition = 0;
            }
        }
        
        switch(input){
            case 1:
                global.customLocationEnabled = true;
                
                if(global.customHpEnabled){
                    Trace("Disabling Custom HP Location.");
                    global.customHpEnabled = false;
                }
                        
                if(global.customDmgEnabled){
                    Trace("Disabling Custom Damage Location.");   
                    global.customDmgEnabled = false;
                }
                        
                if(global.customLocationEnabled){
                    global.customLocationX = window_mouse_get_x();
                    global.customLocationY = window_mouse_get_y();
                    Trace(string(global.customLocationX) + " - " + string(global.customLocationY)); 
                    Trace("Custom Location Set To: X:" + string(global.customLocationX) + ", Y: " + string(global.customLocationY));
                }
                return;
            case 2:
                if(global.customHpEnabled){
                    // Disable first option.
                    global.customLocationEnabled = false;
                    
                    // Do Rest
                    global.customHpX = window_mouse_get_x();
                    global.customHpY = window_mouse_get_y();
                    Trace("Custom HP Location Set To: X:" + string(global.customHpX) + ", Y: " + string(global.customHpY));
                } else {
                    Trace("Please enable Custom HP Location with the Command: [/enableCustomHPLoc] first.");
                }
                
                return;
            case 3: 
                if(global.customDmgEnabled){
                    // Disable first option.
                    global.customLocationEnabled = false;
                    
                    // Do Rest
                    global.customDmgX = window_mouse_get_x();
                    global.customDmgY = window_mouse_get_y();
                    Trace("Custom HP Location Set To: X:" + string(global.customDmgX) + ", Y: " + string(global.customDmgY));
                } else {
                    Trace("Please enable Custom DMG Location with the Command: [/enableCustomDMGLoc] first.");
                }
                return;
        }
    } else {
        Trace("Please do this from within the game screen.")
    }


#define SelectLocation(_args)
    if(room == rmGame) {
        var input = _args[0];
        if(GMLIsShit(input)){
            input = real(input);
            if(input > 3 || input < 1){
                Trace("Please use a number between 1 and 3.");
            } else {
                global.overlayPosition = input;
            }
        } else {
            Trace("Numbers only please.")
        }
    } else {
        Trace("Please do this from within the game screen.")
    }

#define FixNumberSpacing(damage)
    if(floor(damage) == damage) {
        return true;
    } else {
        return false;
    }
    
#define ReturnSwordImage(damage)
    // Forced to use constant values with Switches so thats why I'm using if Statements.
    var realDamage = floor(damage);
    
    if (realDamage >= 1 && realDamage <= 3) {
        return sprSword1;
    } else if (realDamage >= 4 && realDamage <= 6) {
        return sprSword2;
    } else if (realDamage >= 7 && realDamage <= 10) {
        return sprSword3;
    } else if (realDamage >= 11 && realDamage <= 14) {
        return sprSword4;
    } else if (realDamage >= 15) {
        return sprSword5;
    } else {
        return sprSword1;
    }