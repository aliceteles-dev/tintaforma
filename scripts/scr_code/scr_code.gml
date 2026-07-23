//controlando o modo debug

#macro DEBUG_MODE 0


#macro modo_normal:DEBUG_MODE 0
#macro modo_debug:DEBUG_MODE 1


#macro FPS game_get_speed(gamespeed_fps)




global.debug = false;


//supostamente isso ativa o vsync
//if (display_aa >= 8) {
    //display_reset(0, true);
//}