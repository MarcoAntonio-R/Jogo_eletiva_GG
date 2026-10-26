/// ------------------------------------------------------------------
/// Estado de Encerramento e Reinício da Batalha (VICTORY, DEFEAT, RUN) - V3
/// ------------------------------------------------------------------
function scr_battleEnd()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        // Restaura o HP de todos os heróis do time
        for (var i = 0; i < array_length(playerParty); i++)
        {
            playerParty[i].hp = playerParty[i].maxHp;
            playerParty[i].statusEffects = [];
            playerHpDisplay[i] = playerParty[i].hp;
        }

        // Restaura o HP de todos os inimigos do time
        for (var i = 0; i < array_length(enemyParty); i++)
        {
            enemyParty[i].hp = enemyParty[i].maxHp;
            enemyParty[i].statusEffects = [];
            enemyHpDisplay[i] = enemyParty[i].hp;
        }

        queuedActions = [];
        actionQueue = [];
        activeHeroIndex = 0;
        menuIndex = 0;
        moveIndex = 0;

        battleState = BATTLE_STATE.START;
        battleMessage = "Novo confronto em grupo iniciado!";
        messageTimer = 90;
    }
}
