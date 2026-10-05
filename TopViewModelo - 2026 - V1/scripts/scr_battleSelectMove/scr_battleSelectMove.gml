/// ------------------------------------------------------------------
/// Estado de Seleção de Golpe do Jogador (BATTLE_STATE.SELECT_MOVE)
/// Utiliza os controles padronizados do scr_playerInput
/// ------------------------------------------------------------------
function scr_battleSelectMove()
{
    battleMessage = "Escolha um Golpe: [Z/Espaco: Confirmar | X/Esc: Voltar]";

    var _numMoves = array_length(playerCreature.moves);

    // Navegação nos Golpes (Cima / Baixo) usando scr_playerInput
    if (downPressed)
    {
        moveIndex = (moveIndex + 1) mod _numMoves;
    }
    if (upPressed)
    {
        moveIndex = (moveIndex - 1 + _numMoves) mod _numMoves;
    }

    // Cancelar / Voltar ao menu de ações
    if (cancelPressed)
    {
        battleState = BATTLE_STATE.PLAYER_OPTION;
    }

    // Confirmar Golpe Selecionado
    if (confirmPressed)
    {
        selectedPlayerMove = playerCreature.moves[moveIndex];
        battleState = BATTLE_STATE.EXECUTE_PLAYER_TURN;

        // Cálculo do Dano com Vantagem Elemental
        var _mult = scr_getTypeMultiplier(selectedPlayerMove.element, enemyCreature.element);
        var _rawDmg = (((2 * 5 / 5 + 2) * selectedPlayerMove.movePower * (playerCreature.attack / enemyCreature.defense)) / 50 + 2) * _mult;
        var _damage = max(1, round(_rawDmg));

        enemyCreature.hp = max(0, enemyCreature.hp - _damage);

        var _effText = "";
        if (_mult > 1.0) _effText = " E SUPER EFETIVO!";
        else if (_mult < 1.0) _effText = " Nao foi muito efetivo...";

        battleMessage = playerCreature.name + " usou " + selectedPlayerMove.name + "!" + _effText;
        messageTimer = 100;
    }
}
