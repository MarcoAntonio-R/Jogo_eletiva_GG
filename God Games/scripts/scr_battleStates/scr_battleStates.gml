/// ------------------------------------------------------------------
/// Switcher da Máquina de Estados da Batalha Side-View 2v2/3v3 (V3)
/// ------------------------------------------------------------------
function scr_battleStates()
{
    if (global.gameState != GAME_STATE.BATTLE)
    {
        global.gameState = GAME_STATE.BATTLE;
    }

    switch (battleState)
    {
        case BATTLE_STATE.START:
            scr_battleStart();
            break;

        case BATTLE_STATE.PLAYER_OPTION:
            scr_battlePlayerOption();
            break;

        case BATTLE_STATE.SELECT_MOVE:
            scr_battleSelectMove();
            break;

        case BATTLE_STATE.SELECT_TARGET:
            scr_battleSelectTarget();
            break;

        case BATTLE_STATE.BUILD_ACTION_QUEUE:
            scr_battleBuildActionQueue();
            break;

        case BATTLE_STATE.EXECUTE_QUEUE_ACTION:
            scr_battleExecuteQueueAction();
            break;

        case BATTLE_STATE.CHECK_ROUND_END:
            scr_battleCheckRoundEnd();
            break;

        case BATTLE_STATE.VICTORY:
        case BATTLE_STATE.RUN:
        case BATTLE_STATE.DEFEAT:
            scr_battleEnd();
            break;
    }
}
