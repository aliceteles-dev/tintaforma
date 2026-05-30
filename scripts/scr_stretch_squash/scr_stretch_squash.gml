function inicia_efeito_stretchnsquash()
{
    //iniciando as variáveis que serão usadas
    xscale = 1;
    yscale = 1;
}


//função pra definir os valores de distorção da sprite
function efeito_stretchnsquash(_xscale = 1, _yscale = 1)
{
    xscale = _xscale;
    yscale = _yscale;   
}


function retorna_stretchnsquash(_qtd = .1)
{
    xscale = lerp(xscale, 1, _qtd);
    yscale = lerp(yscale, 1, _qtd);
}

function desenha_stretchnsquash()
{
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}