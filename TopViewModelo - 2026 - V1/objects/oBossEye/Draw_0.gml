if (hitFlash > 0)
{
    gpu_set_fog(true, c_white, 0, 0);
}

draw_self();

// Desenha o raio laser se estiver executando LASER_ATTACK
if (state == BOSS_GIANT_EYE_STATE.LASER_ATTACK)
{
    draw_set_color(c_red);
    draw_set_alpha(0.85);
    draw_rectangle(x - 18, y + 10, x + 18, 704, false);
    draw_set_color(c_white);
    draw_rectangle(x - 6, y + 10, x + 6, 704, false);
    draw_set_alpha(1.0);
}

if (hitFlash > 0)
{
    gpu_set_fog(false, c_white, 0, 0);
}

// -------------------------------------------------------------
// DEBUG MODE (F1) - ESTADO DO OLHO DO BOSS
// -------------------------------------------------------------
var _p = instance_find(obj_player, 0);
if (_p != noone && variable_instance_exists(_p, "debugMode") && _p.debugMode)
{
    draw_set_font(fnt_HUD);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_aqua);
    draw_text(x, y - 30, "EYE: " + scr_bossGiantEyeStateName(state));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
