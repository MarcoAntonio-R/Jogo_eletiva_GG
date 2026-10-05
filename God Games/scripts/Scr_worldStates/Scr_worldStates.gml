/// ------------------------------------------------------------------
/// Máquina de Estados do Mundo (scr_worldStates)
/// Gerencia a alternância global entre OVERWORLD, BATTLE_TRANSITION e BATTLE
/// Executado pelo objeto persistente obj_GUI no evento Step
/// ------------------------------------------------------------------
function scr_worldStates()
{
    // Garante a existência da variável de estado global do jogo
    if (!variable_global_exists("gameState"))
    {
        global.gameState = (room == rm_battle) ? GAME_STATE.BATTLE : GAME_STATE.OVERWORLD;
    }

    // Sincroniza o estado global com a sala atual automaticamente
    if (global.gameState != GAME_STATE.BATTLE_TRANSITION)
    {
        if (room == rm_battle)
        {
            global.gameState = GAME_STATE.BATTLE;
        }
        else if (room == rm_topview_world)
        {
            global.gameState = GAME_STATE.OVERWORLD;
        }
    }

    // Tecla F3: Atalho de Debug habilitado SOMENTE quando global.debugMode está ativo (F2)
    // Permite alternar perfeitamente entre rm_topview_world e rm_battle (Indo e Voltando)
    if (variable_global_exists("debugMode") && global.debugMode)
    {
        if (keyboard_check_pressed(vk_f3))
        {
            if (room == rm_topview_world)
            {
                global.previousRoom = rm_topview_world;
                if (instance_exists(obj_player))
                {
                    global.returnX = obj_player.x;
                    global.returnY = obj_player.y;
                }
                global.gameState = GAME_STATE.BATTLE;
                room_goto(rm_battle);
            }
            else if (room == rm_battle)
            {
                global.gameState = GAME_STATE.OVERWORLD;
                room_goto(rm_topview_world);
            }
        }
    }
}
