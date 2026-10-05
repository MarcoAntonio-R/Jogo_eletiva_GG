/// ------------------------------------------------------------------
/// Estado Parado (IDLE) do Player em Top-View
/// ------------------------------------------------------------------
function scr_playerTopViewIdle()
{
    hsp = 0;
    vsp = 0;
    image_speed = 0;

    // Se pressionou qualquer direção, troca para o estado MOVE
    if (inputX != 0 || inputY != 0)
    {
        topViewState = PLAYER_TOPVIEW_STATE.MOVE;
    }
}
