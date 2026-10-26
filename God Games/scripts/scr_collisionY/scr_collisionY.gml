/// ------------------------------------------------------------------
/// Script Dedicado de Colisão Vertical (Resolução do eixo Y)
/// Usado por todos os objetos que herdam de obj_lifeForm
/// ------------------------------------------------------------------
function scr_collisionY()
{
    if (place_meeting(x, y + vsp, colMask))
    {
        while (!place_meeting(x, y + sign(vsp), colMask))
        {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
}