/// ------------------------------------------------------------------
/// Estado em Movimento do Player em Top-View
/// Lê os inputs (inputX, inputY) e atribui as velocidades (hsp, vsp)
/// A colisão é resolvida pelo obj_lifeForm via scr_collisionX e Y
/// ------------------------------------------------------------------
function scr_playerTopViewMove()
{
    image_speed = 0.2;

    // Se não há input direcional, passa para o estado IDLE
    if (inputX == 0 && inputY == 0)
    {
        topViewState = PLAYER_TOPVIEW_STATE.IDLE;
        hsp = 0;
        vsp = 0;
        return;
    }

    // Normaliza a velocidade para movimentos diagonais suaves
    if (inputX != 0 && inputY != 0)
    {
        hsp = inputX * moveSpeed * 0.7071;
        vsp = inputY * moveSpeed * 0.7071;
    }
    else
    {
        hsp = inputX * moveSpeed;
        vsp = inputY * moveSpeed;
    }

    // Atualiza a direção do olhar (faceDir)
    if (inputX != 0) faceDir = (inputX > 0) ? FACE_DIR.RIGHT : FACE_DIR.LEFT;
    if (inputY != 0) faceDir = (inputY > 0) ? FACE_DIR.DOWN : FACE_DIR.UP;

    // Teste de Encontro Selvagem em Grama Alta (obj_bush) ou Inimigo (obj_enemy)
    if (place_meeting(x + hsp, y + vsp, obj_bush) || place_meeting(x + hsp, y + vsp, obj_enemy))
    {
        if (random(100) < 3 || place_meeting(x + hsp, y + vsp, obj_enemy))
        {
            if (instance_exists(obj_battleManager))
            {
                obj_battleManager.startWildBattle();
            }
        }
    }
}
