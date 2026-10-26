/// ------------------------------------------------------------------
/// Gerenciador da Fila de Ações e Turnos de Grupo (V3)
/// ------------------------------------------------------------------

function scr_battleBuildActionQueue()
{
    actionQueue = [];
    for (var i = 0; i < array_length(queuedActions); i++) {
        array_push(actionQueue, queuedActions[i]);
    }

    // Ordenação por Velocidade Efetiva (Bubble Sort simples)
    var _n = array_length(actionQueue);
    for (var i = 0; i < _n - 1; i++)
    {
        for (var j = 0; j < _n - i - 1; j++)
        {
            var _spd1 = actionQueue[j].attacker.getEffectiveSpeed();
            var _spd2 = actionQueue[j + 1].attacker.getEffectiveSpeed();

            if (_spd2 > _spd1)
            {
                var _temp = actionQueue[j];
                actionQueue[j] = actionQueue[j + 1];
                actionQueue[j + 1] = _temp;
            }
        }
    }

    currentActionIndex = 0;
    
    // Executa a primeira ação
    scr_prepareNextAction();
}

function scr_prepareNextAction()
{
    if (currentActionIndex >= array_length(actionQueue))
    {
        battleState = BATTLE_STATE.CHECK_ROUND_END;
        return;
    }

    var _act = actionQueue[currentActionIndex];

    // Se o atacante desmaiou antes do seu turno, pula a ação
    if (_act.attacker.hp <= 0)
    {
        currentActionIndex++;
        scr_prepareNextAction();
        return;
    }

    // Retargeting se o alvo original desmaiou
    if (_act.target.hp <= 0 && _act.targetType == "enemy")
    {
        var _livingOpponents = (_act.team == "player") ? getLivingEnemies() : getLivingHeroes();
        if (array_length(_livingOpponents) > 0)
        {
            _act.target = (_act.team == "player") ? enemyParty[_livingOpponents[0]] : playerParty[_livingOpponents[0]];
        }
        else
        {
            currentActionIndex++;
            scr_prepareNextAction();
            return;
        }
    }

    // Executa o Golpe / Buff / Debuff
    var _atkName = _act.attacker.name;
    var _spdVal = _act.attacker.getEffectiveSpeed();
    var _mv = _act.move;
    var _tgt = _act.target;

    var _effMsg = "";

    // Aplicação de Dano (se o golpe tiver poder > 0)
    if (_mv.movePower > 0)
    {
        var _mult = scr_getTypeMultiplier(_mv.element, _tgt.element);
        var _rawDmg = (((2 * 5 / 5 + 2) * _mv.movePower * (_act.attacker.getEffectiveAttack() / _tgt.getEffectiveDefense())) / 50 + 2) * _mult;
        var _damage = max(1, round(_rawDmg));

        _tgt.hp = max(0, _tgt.hp - _damage);

        if (_mult > 1.0) _effMsg += " (SUPER EFETIVO!)";
        else if (_mult < 1.0) _effMsg += " (Pouco efetivo)";
    }

    // Aplicação de Buff / Debuff
    if (_mv.buffType != STAT_BUFF.NONE)
    {
        var _buffResult = _tgt.applyBuff(_mv.buffType, _mv.buffDuration);
        _effMsg += " " + _buffResult;
    }

    battleMessage = _atkName + " (Vel: " + string(_spdVal) + ") usou " + _mv.name + " em " + _tgt.name + "!" + _effMsg;
    messageTimer = 100;

    battleState = BATTLE_STATE.EXECUTE_QUEUE_ACTION;
}

function scr_battleExecuteQueueAction()
{
    messageTimer--;
    if (messageTimer <= 0)
    {
        // Verifica se uma das equipes foi completamente derrotada no meio do turno
        var _livingHeroes = getLivingHeroes();
        var _livingEnemies = getLivingEnemies();

        if (array_length(_livingEnemies) == 0)
        {
            battleState = BATTLE_STATE.VICTORY;
            battleMessage = "Todos os inimigos foram derrotados! VITORIA!";
            messageTimer = 120;
            return;
        }
        if (array_length(_livingHeroes) == 0)
        {
            battleState = BATTLE_STATE.DEFEAT;
            battleMessage = "Seu grupo foi derrotado...";
            messageTimer = 120;
            return;
        }

        // Próxima ação na fila de velocidade
        currentActionIndex++;
        scr_prepareNextAction();
    }
}

function scr_battleCheckRoundEnd()
{
    var _livingHeroes = getLivingHeroes();
    var _livingEnemies = getLivingEnemies();

    if (array_length(_livingEnemies) == 0)
    {
        battleState = BATTLE_STATE.VICTORY;
        battleMessage = "Todos os inimigos foram derrotados! VITORIA!";
        messageTimer = 120;
        return;
    }
    if (array_length(_livingHeroes) == 0)
    {
        battleState = BATTLE_STATE.DEFEAT;
        battleMessage = "Seu grupo foi derrotado...";
        messageTimer = 120;
        return;
    }

    // Atualiza a duração dos buffs/debuffs de todos os combatentes vivos
    for (var i = 0; i < array_length(playerParty); i++) playerParty[i].updateBuffs();
    for (var i = 0; i < array_length(enemyParty); i++) enemyParty[i].updateBuffs();

    // Reinicia as variáveis para a próxima rodada de escolhas
    queuedActions = [];
    actionQueue = [];
    activeHeroIndex = _livingHeroes[0];
    menuIndex = 0;
    moveIndex = 0;

    battleState = BATTLE_STATE.PLAYER_OPTION;
}
