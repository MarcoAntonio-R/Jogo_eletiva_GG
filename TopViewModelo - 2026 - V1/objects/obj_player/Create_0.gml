// =================================================================
// obj_player - Create (Top-View + Batalha em Turnos)
// =================================================================
event_inherited(); 

// DIDÁTICO: Garante que os gerenciadores persistentes existam no jogo.
if (!instance_exists(obj_playerStats)) {
    instance_create_depth(0, 0, 0, obj_playerStats);
}
if (!instance_exists(obj_battleManager)) {
    instance_create_depth(0, 0, 0, obj_battleManager);
}

// Carrega os status do controlador persistente
hp = obj_playerStats.hp;
hp_max = obj_playerStats.hp_max;
stamina = obj_playerStats.stamina;
stamina_max = obj_playerStats.stamina_max;
coins = obj_playerStats.coins;

// Reposiciona o jogador na posição salva ao retornar do combate no Overworld
if (variable_global_exists("returnX") && global.returnX > 0) {
    x = global.returnX;
    y = global.returnY;
}

// Inicializa a Máquina de Estados Top-View
topViewState = PLAYER_TOPVIEW_STATE.IDLE;
faceDir = FACE_DIR.DOWN;
moveSpeed = 4;