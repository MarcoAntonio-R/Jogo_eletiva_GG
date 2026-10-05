/// ------------------------------------------------------------------
/// Estado de Execução do Turno do Jogador (BATTLE_STATE.EXECUTE_PLAYER_TURN)
/// ------------------------------------------------------------------
function scr_battleExecutePlayerTurn()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        // Se o inimigo desmaiou, vai para a vitória
        if (enemyCreature.hp <= 0)
        {
            battleState = BATTLE_STATE.VICTORY;
            battleMessage = "O " + enemyCreature.name + " selvagem desmaiou! Voce venceu!";
            messageTimer = 120;
        }
        else
        {
            // Caso contrário, vai para o turno do inimigo
            battleState = BATTLE_STATE.EXECUTE_ENEMY_TURN;
        }
    }
}
