/// ------------------------------------------------------------------
/// Loop do obj_battleManager
/// Captura os inputs e executa o switcher modular da batalha (scr_battleStates)
/// ------------------------------------------------------------------

// 1. Captura padronizada de inputs
scr_playerInput();

// 2. Executa a máquina de estados da batalha
scr_battleStates();
