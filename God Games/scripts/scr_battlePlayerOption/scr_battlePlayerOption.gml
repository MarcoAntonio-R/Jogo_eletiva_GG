/// ------------------------------------------------------------------
/// Estado de Escolha de Ação do Jogador para o Herói Ativo (V3)
/// ------------------------------------------------------------------
function scr_battlePlayerOption()
{
    var _curHero = playerParty[activeHeroIndex];
    battleMessage = "O que " + _curHero.name + " vai fazer?";

    if (downPressed)
    {
        menuIndex = (menuIndex + 1) mod 3;
    }
    if (upPressed)
    {
        menuIndex = (menuIndex - 1 + 3) mod 3;
    }

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
        }
        else if (menuIndex == 2) // FUGIR
        {
            battleState = BATTLE_STATE.RUN;
            battleMessage = "Seu grupo fugiu da batalha com seguranca!";
            messageTimer = 80;
        }
    }
}
