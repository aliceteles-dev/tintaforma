//desenhando o brilho ao redor da tocha
var _light = random_range(0, 0.025);
gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_brilho_tocha, 0, x, y, .3 + _light, .3 + _light, image_angle, c_yellow, .2);
gpu_set_blendmode(bm_normal);