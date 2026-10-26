/// ------------------------------------------------------------------
/// Script Dedicado de Colisão Horizontal (Resolução do eixo X)
/// Usado por todos os objetos que herdam de obj_lifeForm
/// ------------------------------------------------------------------
function scr_collisionX()
{
    if (place_meeting(x + hsp, y, colMask))
    {
        while (!place_meeting(x + sign(hsp), y, colMask))
        {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;
}