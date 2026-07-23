#region Mapeamento de teclas

//associando teclas
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("W"), vk_space);

#endregion


#region Variaveis

//variáveis de movimento
velh        = 0;
max_velh    = 1;
velv        = 0;
max_velv    = 3.7;
g           = 0.2;
var _tile   = layer_tilemap_get_id("tl_level");
colisao     = [obj_parede, _tile];

//inputs do jogador
jump   = false;
right  = false;
left   = false;
poder  = false;

//variáveis de controle
touching_ground = false;

//animação do jogador
estado = noone;
dir = 1;

#endregion


#region Métodos


//garantindo que a animação vai começar da sprite 0
troca_sprite = function(_sprite = spr_parede)
{
    if (sprite_index != _sprite)
    {
        image_index = 0;
        sprite_index = _sprite;
    }
    
    
}




player_inputs = function()
{
    right   = keyboard_check(vk_right);
    left    = keyboard_check(vk_left);
    jump    = keyboard_check_pressed(vk_space);
    poder   = keyboard_check_pressed(ord("F"));
}


aplica_velocidade = function()
{

    check_ground();
    
    //aplicando os inputs ao velh
    velh = (right - left) * max_velh;
    
    
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
    
    velv = clamp(velv, -max_velv, max_velv);
}

ajusta_escala = function()
{
    if (velh != 0)
    {
        dir = sign(velh);
    }
}


movimento = function()
{
    move_and_collide(velh, 0, colisao, 12, 0, 1, -1, -1);
    move_and_collide(0, velv, colisao, 24);
}


check_ground = function()
{
    touching_ground = place_meeting(x, y + 1, colisao);
}

acabou_animacao = function(_estado = estado_pulando)
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    
    if (image_index + _spd >= image_number)
    {
        estado = _estado;
    }
}

//estados do player
estado_parado = function()
{
    velv = 0;
    velh = 0;
    aplica_velocidade();
    
    //image_blend = c_red;
    troca_sprite(spr_player_idle);
    
    if (right ^^ left)
        estado = estado_movendo;
    
    if (jump)
    {
        estado = estado_pulando;
        var _part = instance_create_depth(x, y, depth - 1, obj_particulas_player);
        _part.sprite_index = spr_player_particula_pulo;
        efeito_stretchnsquash(.4, 1.5);
    }
    
    if (!touching_ground)
    {
        estado = estado_pulando;
    }
    
    //entrando na tinta (estado_entrando_tinta)
    if (poder)
    {
        estado = estado_entrando_tinta;
    }
}

estado_movendo = function()
{
    aplica_velocidade();
    
    //image_blend = c_blue;
    if (sprite_index != spr_player_falling)
    {
        troca_sprite(spr_player_movendo);
    }
    
    if (velh == 0)
    {
        estado = estado_parado;
    }

    if (jump)
    {
        estado = estado_pulando;
        var _part = instance_create_depth(x, y, depth - 1, obj_particulas_player);
        _part.sprite_index = spr_player_particula_pulo;
        efeito_stretchnsquash(.4, 1.5);
    }
    
    if (!touching_ground)
    {
        estado = estado_pulando;
    }
}

estado_pulando = function()
{
    aplica_velocidade();
    
    //image_blend = c_green;
    if (velv <= 0)
    { 
        troca_sprite(spr_player_jump);
    }
    else
    {
        troca_sprite(spr_player_falling);
    }
    
    if (touching_ground)
    {
        estado = estado_parado;
        var _part = instance_create_depth(x, y, depth - 1, obj_particulas_player);
        _part.sprite_index = spr_player_particula_pouso;
        efeito_stretchnsquash(1.4, .7);
    }
}

//estados relativos ao power up
estado_powerup_inicio = function()
{
    troca_sprite(spr_player_powerup1);
    acabou_animacao(estado_powerup_meio);
}


estado_powerup_meio = function()
{
    troca_sprite(spr_player_powerup2);
    acabou_animacao(estado_powerup_final);
}


estado_powerup_final = function()
{
    troca_sprite(spr_player_powerup3);
    acabou_animacao(estado_parado);
}


//estados relativos à saída e entrada na tinta
estado_entrando_tinta = function()
{
    velh = 0;
    troca_sprite(spr_player_entra_tinta);
    
    if image_index <= 0
    { 
        var _part = instance_create_depth(x, y, depth - 1, obj_particulas_player); 
        _part.sprite_index = spr_particula_entrando_tinta;
    }
    
    acabou_animacao(estado_loop_tinta);
}


estado_loop_tinta = function()
{
    aplica_velocidade();
    troca_sprite(spr_loop_tinta);
    if(poder) estado = estado_saindo_tinta;
        
    var _parar = !place_meeting(x + (sprite_width - 5) * dir + velh, y + 1, colisao)
    if (_parar)
    {
        velh = 0;
    }
    
    
}

estado_saindo_tinta = function()
{
    velh = 0;
    
    troca_sprite(spr_player_sai_tinta);
    
    if image_index <= 0
    {
        var _part = instance_create_depth(x, y, depth - 1, obj_particulas_player);
        _part.sprite_index = spr_particula_saindo_tinta;
    }
    
    acabou_animacao(estado_parado);
}


//efeito stretch and squash
inicia_efeito_stretchnsquash();


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
    
    //testando e mudando o velh
    dbg_slider(ref_create(id, "max_velh"), 0.1, 10, "velh", 0.1);
    
    //vendo as informações do meu g
    dbg_watch(ref_create(id, "g"), "gravidade");
    
    //testando e podendo mudar valores do meu g
    dbg_slider(ref_create(id, "g"), , 10, "Gravidade", 0.1);
    
    
}


#endregion


//definindo estado inicial do player
estado = estado_parado;