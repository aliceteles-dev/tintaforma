player_inputs()
check_ground();
movimento();


//reiniciando o jogo 
if keyboard_check(ord("R")) game_restart();

ativa_debug();
 
//rodando o estado
estado();

//show_debug_message(check_ground) isso só mostra onde a função se aloca na memoria, mas não me informou o retorno dela

show_debug_message(touching_ground);