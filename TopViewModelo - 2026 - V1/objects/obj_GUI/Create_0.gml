// ============================================================
// INICIALIZAÇÃO DA GUI DO JOGO TOP-VIEW (Persistente)
// ============================================================

// Define a resolução da camada GUI fixa em 1280x720 para todas as salas
display_set_gui_size(1280, 720);

pauseType = 0; // 0 = Jogando, 1 = Pausado
menuOptions = ["Retornar ao Jogo", "Sair"];
menuIndex = 0;

cachedHp = 100;
cachedHpMax = 100;
cachedStamina = 100;
cachedStaminaMax = 100;
cachedCoins = 0;
