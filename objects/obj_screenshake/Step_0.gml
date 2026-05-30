//isso funciona alterando a posição do viewport de acordo com o valor da variável tremble

if (tremble > 0.1)
{	
	var _x = random_range(-tremble, tremble);
	var _y = random_range(-tremble, tremble);
	view_set_xport(view_current, _x)	
	view_set_yport(view_current, _y)	
	tremble = lerp(tremble, 0, .1);
}
else
{
	tremble = 0;
	view_set_xport(view_current, 0);
	view_set_yport(view_current, 0);
}