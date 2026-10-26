/// ------------------------------------------------------------------
/// Script Dedicado para Desenho de Informações de Depuração (Debug)
/// Ativado / Desativado pressionando F2 no jogo
/// Tecla F3 alterna a simulação da Máquina de Estados do Mundo (Overworld <-> Batalha)
/// ------------------------------------------------------------------
function scr_drawDebug()
{
    // Inicializa a variável global do modo debug se não existir
    if (!variable_global_exists("debugMode"))
    {
        global.debugMode = false;
    }

    // Tecla F2 alterna o Modo Debug ligado/desligado
    if (keyboard_check_pressed(vk_f2))
    {
        global.debugMode = !global.debugMode;
    }

    // Se o modo debug estiver desligado, não desenha nada
    if (!global.debugMode) return;

    // Posicionamento no Canto Superior Esquerdo (Abaixo da Barra de HP) para não cobrir o inimigo
    var _dbgX1 = 20;
    var _dbgY1 = 80;
    var _dbgX2 = 380;
    var _dbgY2 = 230;

    // Fundo escuro opaco para garantir visibilidade perfeita
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(_dbgX1, _dbgY1, _dbgX2, _dbgY2, false);
    draw_set_alpha(1.0);

    // Borda em c_yellow para destacar o painel de depuração
    draw_set_color(c_yellow);
    draw_rectangle(_dbgX1, _dbgY1, _dbgX2, _dbgY2, true);
    draw_rectangle(_dbgX1 + 1, _dbgY1 + 1, _dbgX2 - 1, _dbgY2 - 1, true);

    draw_text(_dbgX1 + 10, _dbgY1 + 10, "=== DEBUG OVERLAY (F2) ===");
    draw_set_color(c_white);
    
    var _stateStr = "OVERWORLD";
    if (variable_global_exists("gameState"))
    {
        if (global.gameState == GAME_STATE.BATTLE) _stateStr = "BATALHA (rm_battle)";
        else if (global.gameState == GAME_STATE.BATTLE_TRANSITION) _stateStr = "TRANSIÇÃO";
    }

    draw_text(_dbgX1 + 10, _dbgY1 + 35, "Estado do Mundo: " + _stateStr);
    
    if (instance_exists(obj_player))
    {
        draw_text(_dbgX1 + 10, _dbgY1 + 55, "Player Pos: X=" + string(round(obj_player.x)) + " Y=" + string(round(obj_player.y)));
    }
    else
    {
        draw_text(_dbgX1 + 10, _dbgY1 + 55, "Player Pos: N/A (Modo Arena)");
    }
    
    draw_text(_dbgX1 + 10, _dbgY1 + 75, "Sala Atual: " + room_get_name(room));
    draw_text(_dbgX1 + 10, _dbgY1 + 95, "FPS Real: " + string(round(fps_real)) + " | FPS: " + string(fps));

    draw_set_color(c_aqua);
    draw_text(_dbgX1 + 10, _dbgY1 + 120, "[F3]: Simular Troca de Sala do Mundo");
}