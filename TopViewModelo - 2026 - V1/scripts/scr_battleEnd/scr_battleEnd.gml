/// ------------------------------------------------------------------
/// Estado de Encerramento e Reinício da Batalha (VICTORY, DEFEAT, RUN)
/// ------------------------------------------------------------------
function scr_battleEnd()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        // Restaura o HP do jogador
        playerCreature.hp = playerCreature.maxHp;
        
        // Seleciona um novo inimigo selvagem
        var _rIdx = irandom_range(1, array_length(global.creatureDatabase) - 1);
        var _bE = global.creatureDatabase[_rIdx];
        enemyCreature = new Creature(
            _bE.name, _bE.element, _bE.maxHp, _bE.attack, _bE.defense, _bE.speed, _bE.moves
        );

        playerHpDisplay = playerCreature.hp;
        enemyHpDisplay = enemyCreature.hp;

        battleState = BATTLE_STATE.START;
        battleMessage = "Novo desafio! Um " + enemyCreature.name + " selvagem apareceu!";
        messageTimer = 90;
    }
}
