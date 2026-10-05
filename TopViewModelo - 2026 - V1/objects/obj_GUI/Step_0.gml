/// ------------------------------------------------------------------
/// Loop da GUI Top-View & Controlador da Máquina de Estados do Mundo
/// ------------------------------------------------------------------

// 1. Executa a Máquina de Estados do Mundo (scr_worldStates)
scr_worldStates();

// 2. Tecla de Pausa (ESC)
if (keyboard_check_pressed(vk_escape))
{
    if (pauseType == 0) {
        pauseType = 1;
        menuIndex = 0;
    } else {
        pauseType = 0;
    }
}

if (pauseType == 1)
{
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        menuIndex = (menuIndex + 1) mod array_length(menuOptions);
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        menuIndex = (menuIndex - 1 + array_length(menuOptions)) mod array_length(menuOptions);
    }
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        if (menuIndex == 0) {
            pauseType = 0;
        } else if (menuIndex == 1) {
            game_end();
        }
    }
}

// 3. Atualiza caches com base no obj_playerStats
if (instance_exists(obj_playerStats)) {
    cachedHp = obj_playerStats.hp;
    cachedHpMax = obj_playerStats.hp_max;
    cachedStamina = obj_playerStats.stamina;
    cachedStaminaMax = obj_playerStats.stamina_max;
    cachedCoins = obj_playerStats.coins;
}
