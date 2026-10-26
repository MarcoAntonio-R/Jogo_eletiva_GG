/// ------------------------------------------------------------------
/// Seleção de Golpe e Seleção de Alvo para Grupo (V3)
/// Com Bloqueio e Filtro Estrito de Alvos (Self, Ally, Enemy)
/// ------------------------------------------------------------------

function scr_battleSelectMove()
{
    var _curHero = playerParty[activeHeroIndex];
    battleMessage = "Escolha um Golpe para " + _curHero.name + ": [Z: Confirmar | X: Voltar]";

    var _numMoves = array_length(_curHero.moves);

    if (downPressed)
    {
        moveIndex = (moveIndex + 1) mod _numMoves;
    }
    if (upPressed)
    {
        moveIndex = (moveIndex - 1 + _numMoves) mod _numMoves;
    }

    if (cancelPressed)
    {
        battleState = BATTLE_STATE.PLAYER_OPTION;
    }

    if (confirmPressed)
    {
        selectedMove = _curHero.moves[moveIndex];
        
        // Se o golpe for "self", aplica direto no herói ativo sem pedir seleção de alvo!
        if (selectedMove.targetType == "self")
        {
            selectedTargetType = "self";
            targetIndex = activeHeroIndex;

            array_push(queuedActions, {
                attacker: _curHero,
                move: selectedMove,
                target: _curHero,
                targetType: "self",
                team: "player"
            });

            scr_advanceToNextHeroOrAI();
        }
        else if (selectedMove.targetType == "ally")
        {
            selectedTargetType = "ally";
            var _livingHeroes = getLivingHeroes();
            targetIndex = (array_length(_livingHeroes) > 0) ? _livingHeroes[0] : activeHeroIndex;
            battleState = BATTLE_STATE.SELECT_TARGET;
        }
        else // "enemy"
        {
            selectedTargetType = "enemy";
            var _livingEnemies = getLivingEnemies();
            targetIndex = (array_length(_livingEnemies) > 0) ? _livingEnemies[0] : 0;
            battleState = BATTLE_STATE.SELECT_TARGET;
        }
    }
}

function scr_battleSelectTarget()
{
    battleMessage = "Escolha o Alvo para " + selectedMove.name + ": [Z: Confirmar | X: Voltar]";

    if (selectedTargetType == "enemy")
    {
        var _living = getLivingEnemies();
        var _numLiving = array_length(_living);

        if (_numLiving > 0)
        {
            var _curPos = 0;
            for (var i = 0; i < _numLiving; i++) {
                if (_living[i] == targetIndex) { _curPos = i; break; }
            }

            if (downPressed) {
                _curPos = (_curPos + 1) mod _numLiving;
                targetIndex = _living[_curPos];
            }
            if (upPressed) {
                _curPos = (_curPos - 1 + _numLiving) mod _numLiving;
                targetIndex = _living[_curPos];
            }
        }
    }
    else // targetType == "self" ou "ally"
    {
        var _living = getLivingHeroes();
        var _numLiving = array_length(_living);

        if (_numLiving > 0)
        {
            var _curPos = 0;
            for (var i = 0; i < _numLiving; i++) {
                if (_living[i] == targetIndex) { _curPos = i; break; }
            }

            if (downPressed) {
                _curPos = (_curPos + 1) mod _numLiving;
                targetIndex = _living[_curPos];
            }
            if (upPressed) {
                _curPos = (_curPos - 1 + _numLiving) mod _numLiving;
                targetIndex = _living[_curPos];
            }
        }
    }

    if (cancelPressed)
    {
        battleState = BATTLE_STATE.SELECT_MOVE;
    }

    if (confirmPressed)
    {
        var _curHero = playerParty[activeHeroIndex];
        var _targetObj = (selectedTargetType == "enemy") ? enemyParty[targetIndex] : playerParty[targetIndex];

        array_push(queuedActions, {
            attacker: _curHero,
            move: selectedMove,
            target: _targetObj,
            targetType: selectedTargetType,
            team: "player"
        });

        scr_advanceToNextHeroOrAI();
    }
}

/// @function scr_advanceToNextHeroOrAI()
/// @description Avança a escolha para o próximo Herói vivo ou chama a IA inimiga
function scr_advanceToNextHeroOrAI()
{
    var _livingHeroes = getLivingHeroes();
    var _nextHeroIdx = -1;
    for (var h = 0; h < array_length(_livingHeroes); h++) {
        if (_livingHeroes[h] > activeHeroIndex) {
            _nextHeroIdx = _livingHeroes[h];
            break;
        }
    }

    if (_nextHeroIdx != -1)
    {
        // Próximo herói vivo escolhe a sua ação
        activeHeroIndex = _nextHeroIdx;
        menuIndex = 0;
        moveIndex = 0;
        battleState = BATTLE_STATE.PLAYER_OPTION;
    }
    else
    {
        // Todos os heróis vivos escolheram suas ações! Inimigos escolhem ações agora respeitando o targetType:
        var _livingEnemies = getLivingEnemies();
        var _livingHeroesNow = getLivingHeroes();

        for (var e = 0; e < array_length(_livingEnemies); e++)
        {
            var _eIdx = _livingEnemies[e];
            var _eCreature = enemyParty[_eIdx];
            var _randMove = _eCreature.moves[irandom(array_length(_eCreature.moves) - 1)];

            // Define o alvo do Inimigo baseado no targetType do golpe
            var _eTarget = _eCreature; // Padrão ("self")
            if (_randMove.targetType == "ally")
            {
                var _randAllyIdx = _livingEnemies[irandom(array_length(_livingEnemies) - 1)];
                _eTarget = enemyParty[_randAllyIdx];
            }
            else if (_randMove.targetType == "enemy")
            {
                var _randomHeroIdx = _livingHeroesNow[irandom(array_length(_livingHeroesNow) - 1)];
                _eTarget = playerParty[_randomHeroIdx];
            }

            array_push(queuedActions, {
                attacker: _eCreature,
                move: _randMove,
                target: _eTarget,
                targetType: _randMove.targetType,
                team: "enemy"
            });
        }

        // Transição para ordenação da fila por Velocidade
        battleState = BATTLE_STATE.BUILD_ACTION_QUEUE;
    }
}
