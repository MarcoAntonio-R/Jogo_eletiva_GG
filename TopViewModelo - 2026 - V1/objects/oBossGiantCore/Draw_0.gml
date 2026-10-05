if (hitFlash > 0)
{
    gpu_set_fog(true, c_white, 0, 0);
}

draw_self();

if (hitFlash > 0)
{
    gpu_set_fog(false, c_white, 0, 0);
}

// -------------------------------------------------------------
// DEBUG MODE (F1) - ESTADO DO CORE DO BOSS
// -------------------------------------------------------------
var _p = instance_find(obj_player, 0);
if (_p != noone && variable_instance_exists(_p, "debugMode") && _p.debugMode)
{
    draw_set_font(fnt_HUD);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_lime);
    draw_text(x, y - 70, "CORE: " + scr_bossGiantCoreStateName(state));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
