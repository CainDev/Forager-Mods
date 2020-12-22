// Check If Alive
#define CheckIfAlive
        if(instance_exists(objPlayer) == false) exit;
            if (objPlayer.hp > 0) {
               global.isAlive = true;
            } else {
                global.isAlive = false;
            }
    
// This really really REALLY shouldn't be a thing but it is.
#define GMLIsShit(string_2_check)
    var copy = string_2_check;
    string_2_check = string_digits(string_2_check);
    
    if(copy == string(string_2_check)){
        return true;
    } else {
        return false;
    }