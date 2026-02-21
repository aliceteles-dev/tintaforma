#region Mapeamento de teclas

//associando teclas
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("W"), vk_space);

#endregion


#region Variaveis

//variáveis de movimento
velh        = 0;
max_velh    = 1.5;
velv        = 0;
max_velv    = 4.5;
g           = 0.3;

//inputs do jogador
jump   = false;
right  = false;
left   = false;

//variáveis de controle
touching_ground = false;


#endregion


#region Métodos

player_inputs = function()
{
    right   = keyboard_check(vk_right);
    left    = keyboard_check(vk_left);
    jump    = keyboard_check(vk_space);
}


movimento = function()
{

    //aplicando os inputs ao velh
    velh = (right - left) * max_velh;
    
    
    //cuidando da colisão
    move_and_collide(velh, 0, obj_parede, 12, 0, 1, -1, -1);
    move_and_collide(0, velv, obj_parede, 24);
    
    //mas eu também quero flipar a sprite
    if (velh >= 0)
    {
        image_xscale = 1;
    }
    else
    {
    	image_xscale = -1;
    }
    
    //aplicando a gravidade
    if (touching_ground == false)
    {
        velv += g;
    }
    else 
    {
    	velv = 0;
        velv -= jump * max_velv;
        y = round(y);
    }
    
}

check_ground = function()
{
    touching_ground = place_meeting(x, y + 1, obj_parede);
}

#endregion


#region Debug

view_player = noone;

//ativando o debug
ativa_debug = function()
{
    //alterando o valor de global.debug
    var _ativa_debug = keyboard_check_pressed(vk_tab);
    
    //só vai rodar se o jogo estiver no modo debug
    if (!DEBUG_MODE) return;
    
    if (_ativa_debug)
    {
        global.debug = !global.debug;
        
        if (global.debug)
        {
            roda_debug();
        }
        else
        {
            show_debug_overlay(false);
            if (dbg_view_exists(view_player))
            {
                dbg_view_delete(view_player);
            }
        }
    }
}


roda_debug = function()
{
    if !global.debug return;
        
    show_debug_overlay(global.debug);

    //criando meu próprio debug overlay
    view_player = dbg_view("Debug player", 1, 30, 100, 400, 250);
    
    //vendo as info de velv e velh
    dbg_watch(ref_create(id, "velv"), "velocidade vertical");
    dbg_watch(ref_create(id, "velh"), "velocidade horizontal");
    
    //testando e podendo mudar valores do meu velv
    dbg_slider(ref_create(id, "max_velv"), 1, 10, "max_velv", 0.1);
    
    //vendo as informações do meu g
    dbg_watch(ref_create(id, "g"), "gravidade");
    
    //testando e podendo mudar valores do meu g
    dbg_slider(ref_create(id, "g"), , 10, "Gravidade", 0.1);
    
    
}


#endregion