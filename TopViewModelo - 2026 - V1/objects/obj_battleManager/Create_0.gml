/// ------------------------------------------------------------------
/// Inicialização do Gerenciador de Batalhas em Turnos estilo Pokémon
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

// Efeito de Transição Visual
transitionTimer = 0;

// Variáveis de Menu e Seleção
menuIndex = 0; // 0: Atacar, 1: Item, 2: Fugir
moveIndex = 0; // Seleção do golpe no submenu
selectedPlayerMove = noone;

// Instancia as criaturas para a Batalha Standalone em rm_battle
playerCreature = new Creature(
    global.playerCreature.name, 
    global.playerCreature.element, 
    global.playerCreature.maxHp, 
    global.playerCreature.attack, 
    global.playerCreature.defense, 
    global.playerCreature.speed, 
    global.playerCreature.moves
);

// Seleciona um inimigo selvagem aleatório (Bulbasaur / Charmander / Squirtle)
var _randIdx = irandom_range(1, array_length(global.creatureDatabase) - 1);
var _baseE = global.creatureDatabase[_randIdx];

enemyCreature = new Creature(
    _baseE.name, 
    _baseE.element, 
    _baseE.maxHp, 
    _baseE.attack, 
    _baseE.defense, 
    _baseE.speed, 
    _baseE.moves
);

// Exibição Suavizada das Barras de HP
playerHpDisplay = playerCreature.hp;
enemyHpDisplay = enemyCreature.hp;

// Mensagem Inicial de Entrada na Batalha
battleMessage = "Um " + enemyCreature.name + " selvagem (" + scr_getElementName(enemyCreature.element) + ") apareceu!";
messageTimer = 90;

/// @function startWildBattle()
/// @description Função para acionar encontros vindo do Overworld
function startWildBattle()
{
    global.gameState = GAME_STATE.BATTLE_TRANSITION;
    transitionTimer = 35;
    
    var _rIdx = irandom_range(1, array_length(global.creatureDatabase) - 1);
    var _bE = global.creatureDatabase[_rIdx];

    enemyCreature = new Creature(
        _bE.name, _bE.element, _bE.maxHp, _bE.attack, _bE.defense, _bE.speed, _bE.moves
    );

    playerHpDisplay = playerCreature.hp;
    enemyHpDisplay = enemyCreature.hp;

    menuIndex = 0;
    moveIndex = 0;
}
