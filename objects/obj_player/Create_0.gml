//associando teclas
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);

#region Variaveis
velh = 0;
vel = 1;

//inputs do jogador
jump   = false;
right  = false;
left   = false;

#endregion


#region Métodos

player_inputs = function()
{
    right = keyboard_check(vk_right);
    left  = keyboard_check(vk_left);
}

movimento = function()
{

    //aplicando os inputs ao velh
    velh = (right - left) * vel;
    
    //cuidando da colisão
    move_and_collide(velh, 0, obj_parede, 4, 0, 1, -1, -1);
    
    //mas eu também quero flipar a sprite
    if (velh >= 0)
    {
        image_xscale = 1;
    }
    else
    {
    	image_xscale = -1;
    }
    
}

#endregion