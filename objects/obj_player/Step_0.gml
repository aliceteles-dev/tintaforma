//reiniciando o jogo 
if keyboard_check(ord("R")) game_restart();
player_inputs()
check_ground();
movimento();
ativa_debug();
 //rodando o estado
estado();
ajusta_escala(); 
retorna_stretchnsquash();
