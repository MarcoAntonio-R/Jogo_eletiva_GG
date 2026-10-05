/// ------------------------------------------------------------------
/// Estado de Verificação de Desmaio (BATTLE_STATE.CHECK_FAINT)
/// ------------------------------------------------------------------
function scr_battleCheckFaint()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        if (playerCreature.hp <= 0)
        {
            battleState = BATTLE_STATE.DEFEAT;
            battleMessage = playerCreature.name + " desmaiou! Voce foi derrotado...";
            messageTimer = 120;
        }
        else
        {
            battleState = BATTLE_STATE.PLAYER_OPTION;
        }
    }
}
