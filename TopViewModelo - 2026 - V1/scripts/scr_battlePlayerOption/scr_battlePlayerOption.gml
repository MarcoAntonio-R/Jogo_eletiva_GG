/// ------------------------------------------------------------------
/// Estado de Escolha de Ação do Jogador (BATTLE_STATE.PLAYER_OPTION)
/// Utiliza os controles padronizados do scr_playerInput
/// ------------------------------------------------------------------
function scr_battlePlayerOption()
{
    battleMessage = "O que " + playerCreature.name + " vai fazer?";

    // Navegação Vertical Padronizada (0: ATACAR, 1: ITEM, 2: FUGIR) usando scr_playerInput
    if (downPressed)
    {
        menuIndex = (menuIndex + 1) mod 3;
    }
    if (upPressed)
    {
        menuIndex = (menuIndex - 1 + 3) mod 3;
    }

    // Confirmar opção selecionada
    if (confirmPressed)
    {
        if (menuIndex == 0) // ATACAR
        {
            battleState = BATTLE_STATE.SELECT_MOVE;
            moveIndex = 0;
        }
        else if (menuIndex == 1) // ITEM
        {
            battleMessage = "Sua bolsa esta vazia!";
            messageTimer = 60;
            battleState = BATTLE_STATE.START;
        }
        else if (menuIndex == 2) // FUGIR
        {
            battleState = BATTLE_STATE.RUN;
            battleMessage = "Voce fugiu da batalha com seguranca!";
            messageTimer = 80;
        }
    }
}
