/// ------------------------------------------------------------------
/// Switcher da Máquina de Estados de Movimentação do Player em Top-View
/// ------------------------------------------------------------------

/// @function scr_playerTopViewStates()
/// @description Switch principal de controle de estados do Player em Visão Superior (Top-View)
function scr_playerTopViewStates()
{
    // Se o jogo global estiver em batalha ou transição, trava o player
    if (variable_global_exists("gameState") && global.gameState != GAME_STATE.OVERWORLD)
    {
        topViewState = PLAYER_TOPVIEW_STATE.LOCKED;
    }

    switch (topViewState)
    {
        case PLAYER_TOPVIEW_STATE.IDLE:
            scr_playerTopViewIdle();
            break;

        case PLAYER_TOPVIEW_STATE.MOVE:
            scr_playerTopViewMove();
            break;

        case PLAYER_TOPVIEW_STATE.LOCKED:
            scr_playerTopViewLocked();
            break;
    }
}
