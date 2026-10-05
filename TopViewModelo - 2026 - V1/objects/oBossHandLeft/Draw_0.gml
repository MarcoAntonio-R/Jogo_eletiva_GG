if (hitFlash > 0)
{
    gpu_set_fog(true, c_white, 0, 0);
}

// Mantém sprite na orientação correta sem rotações indesejadas
image_xscale = (handSide == 1) ? -1 : 1;
image_angle = 0;

draw_self();

if (hitFlash > 0)
{
    gpu_set_fog(false, c_white, 0, 0);
}

// -------------------------------------------------------------
// DEBUG MODE (F1) - MINI BARRA DE VIDA E ESTADO DA MÃO
// -------------------------------------------------------------
var _p = instance_find(obj_player, 0);
if (_p != noone && variable_instance_exists(_p, "debugMode") && _p.debugMode)
{
    var _barW = 64;
    var _barH = 6;
    var _bx1 = x - (_barW * 0.5);
    var _by1 = y + 45;
    var _bx2 = _bx1 + _barW;
    var _by2 = _by1 + _barH;
    var _hpPct = clamp(hp / hpMax, 0, 1);
    
    draw_set_color(c_black);
    draw_rectangle(_bx1 - 1, _by1 - 1, _bx2 + 1, _by2 + 1, false);
    draw_set_color(c_red);
    draw_rectangle(_bx1, _by1, _bx1 + (_barW * _hpPct), _by2, false);
    draw_set_color(c_white);
    draw_rectangle(_bx1, _by1, _bx2, _by2, true);
    
    draw_set_font(fnt_HUD);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_yellow);
    draw_text(x, _by2 + 2, scr_bossGiantHandStateName(state));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
