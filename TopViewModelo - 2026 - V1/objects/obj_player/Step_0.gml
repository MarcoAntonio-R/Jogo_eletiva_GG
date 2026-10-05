/// ------------------------------------------------------------------
/// obj_player - Step (Top-View)
/// ------------------------------------------------------------------

// 1. Captura as entradas do teclado (inputX, inputY, etc.)
scr_playerInput();

// 2. Executa a máquina de estados Top-View (Define hsp e vsp)
scr_playerTopViewStates();

// 3. Executa a colisão e movimento herdados de obj_lifeForm (scr_collisionX e Y)
event_inherited();

// 4. Sincroniza os status com obj_playerStats
if (instance_exists(obj_playerStats)) {
    obj_playerStats.hp = hp;
    obj_playerStats.hp_max = hp_max;
    obj_playerStats.stamina = stamina;
    obj_playerStats.stamina_max = stamina_max;
    obj_playerStats.coins = coins;
}