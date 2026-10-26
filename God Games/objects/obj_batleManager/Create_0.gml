/// ------------------------------------------------------------------
/// Gerenciador de Batalhas em Grupo Side-View 2v2/3v3 (V3)
/// Rodando diretamente na sala dedicada de batalha rm_battle
/// ------------------------------------------------------------------

// Garante a inicialização do banco de dados de criaturas e golpes
scr_initDatabase();

// Estado Global do Jogo (Inicializa diretamente em Batalha)
global.gameState = GAME_STATE.BATTLE;
global.previousRoom = rm_topview_world;
global.returnX = 220;
global.returnY = 360;

// Sub-Estados da Batalha
battleState = BATTLE_STATE.START;
transitionTimer = 0;

// Configuração dos Times de Combatentes (2v2 ou 3v3)
playerParty = [
    new Creature(global.creatureDatabase[0].name, global.creatureDatabase[0].element, global.creatureDatabase[0].maxHp, global.creatureDatabase[0].attack, global.creatureDatabase[0].defense, global.creatureDatabase[0].speed, global.creatureDatabase[0].moves),
    new Creature(global.creatureDatabase[1].name, global.creatureDatabase[1].element, global.creatureDatabase[1].maxHp, global.creatureDatabase[1].attack, global.creatureDatabase[1].defense, global.creatureDatabase[1].speed, global.creatureDatabase[1].moves)
];

enemyParty = [
    new Creature(global.creatureDatabase[2].name, global.creatureDatabase[2].element, global.creatureDatabase[2].maxHp, global.creatureDatabase[2].attack, global.creatureDatabase[2].defense, global.creatureDatabase[2].speed, global.creatureDatabase[2].moves),
    new Creature(global.creatureDatabase[3].name, global.creatureDatabase[3].element, global.creatureDatabase[3].maxHp, global.creatureDatabase[3].attack, global.creatureDatabase[3].defense, global.creatureDatabase[3].speed, global.creatureDatabase[3].moves)
];

// Display Suavizado de HP para cada combatente
playerHpDisplay = [];
for (var i = 0; i < array_length(playerParty); i++) {
    array_push(playerHpDisplay, playerParty[i].hp);
}

enemyHpDisplay = [];
for (var i = 0; i < array_length(enemyParty); i++) {
    array_push(enemyHpDisplay, enemyParty[i].hp);
}

// Variáveis de Navegação e Menu
menuIndex = 0;          // 0: Atacar, 1: Item, 2: Fugir
moveIndex = 0;          // Índice do Golpe no submenu
activeHeroIndex = 0;    // Índice do Herói atual no time escolhendo ação (0, 1...)
targetIndex = 0;        // Índice do Alvo selecionado
selectedMove = noone;

// Fila de Ações do Turno
queuedActions = [];     // Ações preparadas na fase de escolha
actionQueue = [];       // Fila de ações ordenadas por Velocidade Efetiva
currentActionIndex = 0; // Índice da ação sendo executada no momento

// Mensagem Inicial
battleMessage = "Batalha em Grupo Side-View iniciada! Escolha as acoes.";
messageTimer = 90;

/// @function getLivingHeroes()
function getLivingHeroes()
{
    var _living = [];
    for (var i = 0; i < array_length(playerParty); i++) {
        if (playerParty[i].hp > 0) array_push(_living, i);
    }
    return _living;
}

/// @function getLivingEnemies()
function getLivingEnemies()
{
    var _living = [];
    for (var i = 0; i < array_length(enemyParty); i++) {
        if (enemyParty[i].hp > 0) array_push(_living, i);
    }
    return _living;
}
