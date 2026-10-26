/// ------------------------------------------------------------------
/// Script de Desenho da HUD Side-View 2v2/3v3 (V3)
/// Desenha os combatentes de lado (Esquerda vs Direita estilo Final Fantasy)
/// ------------------------------------------------------------------
function scr_drawBattleHUD()
{
    if (room != rm_battle || (variable_global_exists("gameState") && global.gameState != GAME_STATE.BATTLE)) return;

    var _guiW = display_get_gui_width();
    var _guiH = display_get_gui_height();

    // 1. Fundo de Arena F.F. (Side-View)
    draw_set_color(c_dkgray);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, _guiW, _guiH, false);
    draw_set_alpha(1.0);

    // ===================================================================
    // 2. TIME DOS INIMIGOS (Coluna da Esquerda)
    // ===================================================================
    for (var i = 0; i < array_length(enemyParty); i++)
    {
        var _c = enemyParty[i];
        var _eX = 220;
        var _eY = 120 + (i * 150);

        // Suavização do HP
        enemyHpDisplay[i] = lerp(enemyHpDisplay[i], _c.hp, 0.1);

        if (_c.hp > 0)
        {
            // Sprite do Inimigo virado para a direita
            draw_sprite_ext(spr_enemy, 0, _eX, _eY + 40, 2.0, 2.0, 0, c_white, 1.0);

            // Quadro de Status do Inimigo
            var _boxX = _eX - 180;
            var _boxY = _eY - 40;

            draw_set_color(c_black);
            draw_set_alpha(0.6);
            draw_rectangle(_boxX, _boxY, _boxX + 220, _boxY + 65, false);
            draw_set_alpha(1.0);

            // Nome, Tipo e Velocidade Efetiva
            draw_set_color(c_white);
            draw_text(_boxX + 10, _boxY + 5, _c.name + " [" + scr_getElementName(_c.element) + "]");
            draw_text(_boxX + 10, _boxY + 24, "Vel: " + string(_c.getEffectiveSpeed()));

            // Indicadores de Buffs/Debuffs
            var _buffStr = "";
            for (var b = 0; b < array_length(_c.statusEffects); b++) {
                var _st = _c.statusEffects[b].type;
                if (_st == STAT_BUFF.ATK_UP) _buffStr += "[ATK+] ";
                if (_st == STAT_BUFF.ATK_DOWN) _buffStr += "[ATK-] ";
                if (_st == STAT_BUFF.DEF_UP) _buffStr += "[DEF+] ";
                if (_st == STAT_BUFF.DEF_DOWN) _buffStr += "[DEF-] ";
                if (_st == STAT_BUFF.SPD_UP) _buffStr += "[SPD+] ";
                if (_st == STAT_BUFF.SPD_DOWN) _buffStr += "[SPD-] ";
            }
            if (_buffStr != "") {
                draw_set_color(c_yellow);
                draw_text(_boxX + 110, _boxY + 24, _buffStr);
            }

            // Barra de HP
            var _hpPct = clamp(enemyHpDisplay[i] / _c.maxHp, 0, 1);
            var _bX1 = _boxX + 10;
            var _bY1 = _boxY + 45;
            var _bX2 = _boxX + 210;
            var _bY2 = _boxY + 58;

            draw_set_color(c_black);
            draw_rectangle(_bX1, _bY1, _bX2, _bY2, false);

            var _hpCol = (_hpPct > 0.5) ? c_green : ((_hpPct > 0.2) ? c_yellow : c_red);
            draw_set_color(_hpCol);
            draw_rectangle(_bX1, _bY1, _bX1 + (_bX2 - _bX1) * _hpPct, _bY2, false);

            draw_set_color(c_white);
            draw_rectangle(_bX1, _bY1, _bX2, _bY2, true);

            // Destaque de Alvo (Cursor <=== ALVO)
            if (battleState == BATTLE_STATE.SELECT_TARGET && selectedTargetType == "enemy" && targetIndex == i)
            {
                draw_set_color(c_yellow);
                draw_text(_eX + 45, _eY + 30, "<=== ALVO");
            }
        }
        else
        {
            draw_set_color(c_gray);
            draw_text(_eX - 50, _eY + 20, "(Desmaiado)");
        }
    }

    // ===================================================================
    // 3. TIME DOS HERÓIS (Coluna da Direita)
    // ===================================================================
    for (var i = 0; i < array_length(playerParty); i++)
    {
        var _h = playerParty[i];
        var _hX = 900;
        var _hY = 120 + (i * 150);

        // Suavização do HP
        playerHpDisplay[i] = lerp(playerHpDisplay[i], _h.hp, 0.1);

        if (_h.hp > 0)
        {
            // Sprite do Herói virado para a esquerda
            draw_sprite_ext(spr_player, 0, _hX, _hY + 40, -2.0, 2.0, 0, c_white, 1.0);

            // Quadro de Status do Herói
            var _boxX = _hX + 45;
            var _boxY = _hY - 40;

            draw_set_color(c_black);
            draw_set_alpha(0.6);
            draw_rectangle(_boxX, _boxY, _boxX + 220, _boxY + 65, false);
            draw_set_alpha(1.0);

            // Nome, Tipo e Velocidade Efetiva
            draw_set_color(c_white);
            draw_text(_boxX + 10, _boxY + 5, _h.name + " [" + scr_getElementName(_h.element) + "]");
            draw_text(_boxX + 10, _boxY + 24, "Vel: " + string(_h.getEffectiveSpeed()));

            // Indicadores de Buffs/Debuffs
            var _buffStr = "";
            for (var b = 0; b < array_length(_h.statusEffects); b++) {
                var _st = _h.statusEffects[b].type;
                if (_st == STAT_BUFF.ATK_UP) _buffStr += "[ATK+] ";
                if (_st == STAT_BUFF.ATK_DOWN) _buffStr += "[ATK-] ";
                if (_st == STAT_BUFF.DEF_UP) _buffStr += "[DEF+] ";
                if (_st == STAT_BUFF.DEF_DOWN) _buffStr += "[DEF-] ";
                if (_st == STAT_BUFF.SPD_UP) _buffStr += "[SPD+] ";
                if (_st == STAT_BUFF.SPD_DOWN) _buffStr += "[SPD-] ";
            }
            if (_buffStr != "") {
                draw_set_color(c_yellow);
                draw_text(_boxX + 110, _boxY + 24, _buffStr);
            }

            // Barra de HP
            var _hpPct = clamp(playerHpDisplay[i] / _h.maxHp, 0, 1);
            var _bX1 = _boxX + 10;
            var _bY1 = _boxY + 45;
            var _bX2 = _boxX + 210;
            var _bY2 = _boxY + 58;

            draw_set_color(c_black);
            draw_rectangle(_bX1, _bY1, _bX2, _bY2, false);

            var _hpCol = (_hpPct > 0.5) ? c_green : ((_hpPct > 0.2) ? c_yellow : c_red);
            draw_set_color(_hpCol);
            draw_rectangle(_bX1, _bY1, _bX1 + (_bX2 - _bX1) * _hpPct, _bY2, false);

            draw_set_color(c_white);
            draw_rectangle(_bX1, _bY1, _bX2, _bY2, true);

            // Destaque de Alvo (Cursor ALVO ===>)
            if (battleState == BATTLE_STATE.SELECT_TARGET && selectedTargetType == "self" && targetIndex == i)
            {
                draw_set_color(c_yellow);
                draw_text(_hX - 130, _hY + 30, "ALVO ===>");
            }
        }
        else
        {
            draw_set_color(c_gray);
            draw_text(_hX - 50, _hY + 20, "(Desmaiado)");
        }
    }

    // ===================================================================
    // 4. CAIXA DE TEXTO NARRATIVA (Usando spr_dialogBox)
    // ===================================================================
    var _msgBoxX = 80;
    var _msgBoxY = 550;

    draw_sprite(spr_dialogBox, 0, _msgBoxX, _msgBoxY);

    // Texto de diálogo em Preto para legibilidade sobre a caixa
    draw_set_color(c_black);
    draw_text_ext(_msgBoxX + 25, _msgBoxY + 25, battleMessage, 24, 670);

    // ===================================================================
    // 5. CAIXA DE COMANDOS E GOLPES DE GRUPO (Texto em Preto / Azul Escuro)
    // ===================================================================
    var _mBoxX = 830;
    var _mBoxY = 550;

    if (battleState == BATTLE_STATE.PLAYER_OPTION)
    {
        draw_sprite(spr_commandBox, 0, _mBoxX, _mBoxY);

        var _curHero = playerParty[activeHeroIndex];
        draw_set_color(c_black);
        draw_text(_mBoxX + 15, _mBoxY + 8, "Vez de: " + _curHero.name);

        var _options = ["ATACAR", "ITEM", "FUGIR"];
        for (var i = 0; i < 3; i++)
        {
            var _optY = _mBoxY + 32 + (i * 26);
            if (menuIndex == i)
            {
                draw_set_color(c_navy);
                draw_text(_mBoxX + 20, _optY, "> " + _options[i]);
            }
            else
            {
                draw_set_color(c_black);
                draw_text(_mBoxX + 35, _optY, _options[i]);
            }
        }
    }
    else if (battleState == BATTLE_STATE.SELECT_MOVE)
    {
        draw_sprite(spr_commandBox, 0, _mBoxX, _mBoxY);

        var _curHero = playerParty[activeHeroIndex];
        var _moves = _curHero.moves;
        for (var i = 0; i < array_length(_moves); i++)
        {
            var _mv = _moves[i];
            var _optY = _mBoxY + 18 + (i * 28);
            if (moveIndex == i)
            {
                draw_set_color(c_navy);
                draw_text(_mBoxX + 15, _optY, "> " + _mv.name + " (" + scr_getElementName(_mv.element) + ")");
            }
            else
            {
                draw_set_color(c_black);
                draw_text(_mBoxX + 30, _optY, _mv.name + " (" + scr_getElementName(_mv.element) + ")");
            }
        }
    }
    else if (battleState == BATTLE_STATE.SELECT_TARGET)
    {
        draw_sprite(spr_commandBox, 0, _mBoxX, _mBoxY);
        draw_set_color(c_black);
        draw_text(_mBoxX + 15, _mBoxY + 20, "Escolha o Alvo:");
        draw_text(_mBoxX + 15, _mBoxY + 50, "[Cima/Baixo: Alvo]");
        draw_text(_mBoxX + 15, _mBoxY + 75, "[Z: Confirmar]");
    }
}
