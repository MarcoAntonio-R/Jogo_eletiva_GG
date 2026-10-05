/// ------------------------------------------------------------------
/// Switcher da Máquina de Estados da Batalha em Turnos (scr_battleStates)
/// Suaviza as barras de vida e executa os scripts modulares por estado
/// ------------------------------------------------------------------
function scr_battleStates()
{
    // Garantia de estado global de batalha durante o teste standalone na rm_battle
    if (global.gameState != GAME_STATE.BATTLE)
    {
        global.gameState = GAME_STATE.BATTLE;
    }

    // Suavização das barras de vida dos combatentes (Lerp)
    if (playerCreature != noone) {
        playerHpDisplay = lerp(playerHpDisplay, playerCreature.hp, 0.1);
    }
    if (enemyCreature != noone) {
        enemyHpDisplay = lerp(enemyHpDisplay, enemyCreature.hp, 0.1);
    }

    // Switch principal de estados da batalha (Invoca scripts modulares)
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

        case BATTLE_STATE.EXECUTE_PLAYER_TURN:
            scr_battleExecutePlayerTurn();
            break;

        case BATTLE_STATE.EXECUTE_ENEMY_TURN:
            scr_battleExecuteEnemyTurn();
            break;

        case BATTLE_STATE.CHECK_FAINT:
            scr_battleCheckFaint();
            break;

        case BATTLE_STATE.VICTORY:
        case BATTLE_STATE.RUN:
        case BATTLE_STATE.DEFEAT:
            scr_battleEnd();
            break;
    }
}
