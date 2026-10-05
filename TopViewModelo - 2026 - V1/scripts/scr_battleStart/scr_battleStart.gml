/// ------------------------------------------------------------------
/// Estado Inicial da Batalha (BATTLE_STATE.START)
/// Exibe a mensagem de introdução ao encontro
/// ------------------------------------------------------------------
function scr_battleStart()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        battleState = BATTLE_STATE.PLAYER_OPTION;
        menuIndex = 0;
    }
}
