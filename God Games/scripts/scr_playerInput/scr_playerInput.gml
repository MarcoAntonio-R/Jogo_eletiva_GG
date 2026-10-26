/// ------------------------------------------------------------------
/// Captura Padronizada de Entradas (Inputs) do Teclado
/// Usado no Overworld e nas Batalhas para padronizar os controles
/// ------------------------------------------------------------------
function scr_playerInput()
{
    // Entradas Contínuas (Segurar tecla)
    leftKey  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    rightKey = keyboard_check(vk_right) || keyboard_check(ord("D"));
    upKey    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
    downKey  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

    // Vetores direcionais para movimentação Top-View
    inputX = rightKey - leftKey;
    inputY = downKey - upKey;

    // Entradas de Disparo Único (Pressionar tecla - 1 frame)
    upPressed      = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
    downPressed    = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
    leftPressed    = keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A"));
    rightPressed   = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));

    // Ações universais (Confirmar / Cancelar / Pausa)
    confirmPressed  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
    cancelPressed   = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));
    interactPressed = confirmPressed;
    pausePressed    = keyboard_check_pressed(vk_escape);
}
