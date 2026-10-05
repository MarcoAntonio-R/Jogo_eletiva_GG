/// ------------------------------------------------------------------
/// Script Dedicado para Desenho da HUD e Elementos da Batalha em Turnos
/// Desenha apenas quando estiver na sala rm_battle e no estado BATTLE
/// ------------------------------------------------------------------
function scr_drawBattleHUD()
{
    // Cancela o desenho da Batalha se o jogo não estiver na sala rm_battle ou no estado BATTLE
    if (room != rm_battle || (variable_global_exists("gameState") && global.gameState != GAME_STATE.BATTLE)) return;

    var _guiW = display_get_gui_width();
    var _guiH = display_get_gui_height();

    // ===================================================================
    // 1. ARENA E SPRITES DOS COMBATENTES NA TELA
    // ===================================================================
    // Fundo escuro de arena
    draw_set_color(c_dkgray);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, _guiW, _guiH, false);
    draw_set_alpha(1.0);

    // Sprite do Inimigo no Fundo (Canto Superior Direito)
    draw_sprite_ext(spr_enemy, 0, 950, 220, 2.5, 2.5, 0, c_white, 1.0);

    // Sprite do Jogador na Frente (Canto Inferior Esquerdo)
    draw_sprite_ext(spr_player, 0, 280, 300, 2.5, 2.5, 0, c_white, 1.0);

    // ===================================================================
    // 2. QUADRO DE STATUS DO INIMIGO (Usando spr_statsBox)
    // ===================================================================
    if (enemyCreature != noone)
    {
        var _eBoxX = 800;
        var _eBoxY = 40;

        // Desenha a Sprite da caixa de status do inimigo
        draw_sprite(spr_statsBox, 0, _eBoxX, _eBoxY);

        // Texto: Nome do Inimigo e Tipo
        draw_set_color(c_black);
        draw_text(_eBoxX + 20, _eBoxY + 15, enemyCreature.name);
        draw_set_color(c_white);
        draw_text(_eBoxX + 220, _eBoxY + 15, "[" + scr_getElementName(enemyCreature.element) + "]");

        // Barra de HP do Inimigo
        var _hpPctE = clamp(enemyHpDisplay / enemyCreature.maxHp, 0, 1);
        var _barX1 = _eBoxX + 20;
        var _barY1 = _eBoxY + 50;
        var _barX2 = _eBoxX + 370;
        var _barY2 = _eBoxY + 70;

        draw_set_color(c_black);
        draw_rectangle(_barX1, _barY1, _barX2, _barY2, false);

        var _hpColorE = (_hpPctE > 0.5) ? c_green : ((_hpPctE > 0.2) ? c_yellow : c_red);
        draw_set_color(_hpColorE);
        draw_rectangle(_barX1, _barY1, _barX1 + (_barX2 - _barX1) * _hpPctE, _barY2, false);

        draw_set_color(c_white);
        draw_rectangle(_barX1, _barY1, _barX2, _barY2, true);
        draw_text(_barX1 + 5, _barY1 + 2, "HP");
    }

    // ===================================================================
    // 3. QUADRO DE STATUS DO JOGADOR (Usando spr_statsBox)
    // ===================================================================
    if (playerCreature != noone)
    {
        var _pBoxX = 80;
        var _pBoxY = 400;

        // Desenha a Sprite da caixa de status do jogador
        draw_sprite(spr_statsBox, 0, _pBoxX, _pBoxY);

        // Texto: Nome do Jogador e Tipo
        draw_set_color(c_black);
        draw_text(_pBoxX + 20, _pBoxY + 15, playerCreature.name);
        draw_set_color(c_white);
        draw_text(_pBoxX + 220, _pBoxY + 15, "[" + scr_getElementName(playerCreature.element) + "]");

        // Barra de HP do Jogador
        var _hpPctP = clamp(playerHpDisplay / playerCreature.maxHp, 0, 1);
        var _barX1 = _pBoxX + 20;
        var _barY1 = _pBoxY + 45;
        var _barX2 = _pBoxX + 370;
        var _barY2 = _pBoxY + 65;

        draw_set_color(c_black);
        draw_rectangle(_barX1, _barY1, _barX2, _barY2, false);

        var _hpColorP = (_hpPctP > 0.5) ? c_green : ((_hpPctP > 0.2) ? c_yellow : c_red);
        draw_set_color(_hpColorP);
        draw_rectangle(_barX1, _barY1, _barX1 + (_barX2 - _barX1) * _hpPctP, _barY2, false);

        draw_set_color(c_white);
        draw_rectangle(_barX1, _barY1, _barX2, _barY2, true);

        // Valores numéricos do HP
        draw_text(_pBoxX + 20, _pBoxY + 72, "HP: " + string(round(playerHpDisplay)) + " / " + string(playerCreature.maxHp));
    }

    // ===================================================================
    // 4. CAIXA DE TEXTO NARRATIVA (Usando spr_dialogBox)
    // ===================================================================
    var _msgBoxX = 80;
    var _msgBoxY = 550;

    draw_sprite(spr_dialogBox, 0, _msgBoxX, _msgBoxY);

    draw_set_color(c_white);
    draw_text_ext(_msgBoxX + 25, _msgBoxY + 25, battleMessage, 24, 670);

    // ===================================================================
    // 5. CAIXA DE COMANDOS E GOLPES (Usando spr_commandBox)
    // ===================================================================
    if (battleState == BATTLE_STATE.PLAYER_OPTION)
    {
        var _mBoxX = 830;
        var _mBoxY = 550;

        draw_sprite(spr_commandBox, 0, _mBoxX, _mBoxY);

        var _options = ["ATACAR", "ITEM", "FUGIR"];
        for (var i = 0; i < 3; i++)
        {
            var _optY = _mBoxY + 20 + (i * 32);
            if (menuIndex == i)
            {
                draw_set_color(c_aqua);
                draw_text(_mBoxX + 20, _optY, "> " + _options[i]);
            }
            else
            {
                draw_set_color(c_white);
                draw_text(_mBoxX + 35, _optY, _options[i]);
            }
        }
    }
    else if (battleState == BATTLE_STATE.SELECT_MOVE)
    {
        var _mBoxX = 830;
        var _mBoxY = 550;

        draw_sprite(spr_commandBox, 0, _mBoxX, _mBoxY);

        var _moves = playerCreature.moves;
        for (var i = 0; i < array_length(_moves); i++)
        {
            var _mv = _moves[i];
            var _optY = _mBoxY + 18 + (i * 28);
            if (moveIndex == i)
            {
                draw_set_color(c_aqua);
                draw_text(_mBoxX + 15, _optY, "> " + _mv.name + " (" + scr_getElementName(_mv.element) + ")");
            }
            else
            {
                draw_set_color(c_white);
                draw_text(_mBoxX + 30, _optY, _mv.name + " (" + scr_getElementName(_mv.element) + ")");
            }
        }
    }
}
