/// ------------------------------------------------------------------
/// Desenho da HUD do Overworld e Overlay de Debug (F2)
/// ------------------------------------------------------------------

// Trava a resolução da camada GUI em 1280x720 antes de qualquer desenho
display_set_gui_size(1280, 720);

// Chama o script dedicado para a HUD do Overworld
scr_drawHUD();

// Chama o script dedicado para a Overlay de Depuração (F2)
scr_drawDebug();