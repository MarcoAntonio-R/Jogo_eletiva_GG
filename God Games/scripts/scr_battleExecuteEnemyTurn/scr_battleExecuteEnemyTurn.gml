/// ------------------------------------------------------------------
/// Estado de Execução do Segundo Turno (BATTLE_STATE.EXECUTE_SECOND_TURN)
/// Executa o ataque do segundo combatente (caso não tenha desmaiado)
/// ------------------------------------------------------------------
function scr_battleExecuteSecondTurn()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        var _secondDefenderCreature = (secondAttacker == "player") ? enemyCreature : playerCreature;

        // Se o defensor do 2º ataque desmaiou
        if (_secondDefenderCreature.hp <= 0)
        {
            if (secondAttacker == "player")
            {
                battleState = BATTLE_STATE.VICTORY;
                battleMessage = "O " + enemyCreature.name + " selvagem desmaiou! Voce venceu!";
            }
            else
            {
                battleState = BATTLE_STATE.DEFEAT;
                battleMessage = playerCreature.name + " desmaiou! Voce foi derrotado...";
            }
            messageTimer = 120;
        }
        else
        {
            // Ambos os combatentes sobreviveram ao turno completo: Retorna ao menu de opções do jogador
            battleState = BATTLE_STATE.PLAYER_OPTION;
        }
    }
}
