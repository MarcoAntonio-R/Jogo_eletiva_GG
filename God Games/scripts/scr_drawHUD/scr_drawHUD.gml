/// ------------------------------------------------------------------
/// Script Dedicado para Desenho da HUD do Mundo Aberto (Overworld)
/// ------------------------------------------------------------------
function scr_drawHUD()
{
    // Cancela o desenho da HUD se estiver na sala rm_battle ou em estado de batalha
    if (room == rm_battle || (variable_global_exists("gameState") && global.gameState != GAME_STATE.OVERWORLD)) return;

    var _hp = 100;
    var _hpMax = 100;

    if (instance_exists(obj_playerStats))
    {
        _hp = obj_playerStats.hp;
        _hpMax = obj_playerStats.hp_max;
    }

    // Barra de Vida no canto superior esquerdo
    draw_set_color(c_dkgray);
    draw_rectangle(20, 20, 220, 40, false);
    
    var _hpPct = clamp(_hp / _hpMax, 0, 1);
    var _hpCol = (_hpPct > 0.5) ? c_green : ((_hpPct > 0.2) ? c_yellow : c_red);
    draw_set_color(_hpCol);
    draw_rectangle(20, 20, 20 + (200 * _hpPct), 40, false);
    
    draw_set_color(c_white);
    draw_rectangle(20, 20, 220, 40, true);
    draw_text(25, 22, "HP: " + string(round(_hp)) + " / " + string(_hpMax));

    // Instrução didática na tela
    draw_set_color(c_aqua);
    draw_text(20, 50, "[WASD/Setas]: Mover | [Grama]: Encontro Pokemon | [F2]: Debug");
}