/// ------------------------------------------------------------------
/// Estado de Execução do Turno do Inimigo (BATTLE_STATE.EXECUTE_ENEMY_TURN)
/// ------------------------------------------------------------------
function scr_battleExecuteEnemyTurn()
{
    // Seleção aleatória de golpe pelo inimigo
    var _enemyMove = enemyCreature.moves[irandom(array_length(enemyCreature.moves) - 1)];
    var _mult = scr_getTypeMultiplier(_enemyMove.element, playerCreature.element);
    var _rawDmg = (((2 * 5 / 5 + 2) * _enemyMove.movePower * (enemyCreature.attack / playerCreature.defense)) / 50 + 2) * _mult;
    var _damage = max(1, round(_rawDmg));

    playerCreature.hp = max(0, playerCreature.hp - _damage);

    var _effText = "";
    if (_mult > 1.0) _effText = " E SUPER EFETIVO!";
    else if (_mult < 1.0) _effText = " Nao foi muito efetivo...";

    battleMessage = "O " + enemyCreature.name + " inimigo usou " + _enemyMove.name + "!" + _effText;
    messageTimer = 100;

    battleState = BATTLE_STATE.CHECK_FAINT;
}
