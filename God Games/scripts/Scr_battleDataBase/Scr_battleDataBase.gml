/// ------------------------------------------------------------------
/// Banco de Dados de Batalha: Tipos Elementais, Golpes e Criaturas
/// Estruturado em Funções Construtoras (Structs) e Arrays didáticos
/// ------------------------------------------------------------------

/// @function scr_getTypeMultiplier(atkElement, defElement)
/// @description Retorna o multiplicador de dano baseado na vantagem elemental (0.5x, 1.0x ou 2.0x)
function scr_getTypeMultiplier(_atkElement, _defElement)
{
    // Ataques Neutros/Normais
    if (_atkElement == ELEMENT.NORMAL || _defElement == ELEMENT.NORMAL) return 1.0;

    // Fogo vs Outros
    if (_atkElement == ELEMENT.FIRE) {
        if (_defElement == ELEMENT.GRASS) return 2.0; // Super efetivo!
        if (_defElement == ELEMENT.WATER) return 0.5; // Pouco efetivo!
    }

    // Água vs Outros
    if (_atkElement == ELEMENT.WATER) {
        if (_defElement == ELEMENT.FIRE) return 2.0;  // Super efetivo!
        if (_defElement == ELEMENT.GRASS) return 0.5; // Pouco efetivo!
    }

    // Planta vs Outros
    if (_atkElement == ELEMENT.GRASS) {
        if (_defElement == ELEMENT.WATER) return 2.0; // Super efetivo!
        if (_defElement == ELEMENT.FIRE) return 0.5;  // Pouco efetivo!
    }

    // Elétrico vs Outros
    if (_atkElement == ELEMENT.ELECTRIC) {
        if (_defElement == ELEMENT.WATER) return 2.0; // Super efetivo!
        if (_defElement == ELEMENT.GRASS) return 0.5; // Pouco efetivo!
    }

    return 1.0; // Dano normal por padrão
}

/// @function scr_getElementName(element)
/// @description Retorna o nome formatado do elemento para ser exibido na tela
function scr_getElementName(_element)
{
    switch (_element) {
        case ELEMENT.FIRE:     return "Fogo";
        case ELEMENT.WATER:    return "Água";
        case ELEMENT.GRASS:    return "Planta";
        case ELEMENT.ELECTRIC: return "Elétrico";
        default:               return "Normal";
    }
}

/// @function Move(_name, _element, _movePower, _accuracy)
/// @description Construtor para criar uma técnica / golpe de batalha
function Move(_name, _element, _movePower, _accuracy) constructor
{
    name = _name;
    element = _element;
    movePower = _movePower;
    accuracy = _accuracy;
}

/// @function Creature(_name, _element, _maxHp, _attack, _defense, _speed, _moves)
/// @description Construtor para criar os dados de uma criatura/monstro
function Creature(_name, _element, _maxHp, _attack, _defense, _speed, _moves) constructor
{
    name = _name;
    element = _element;
    maxHp = _maxHp;
    hp = _maxHp;
    attack = _attack;
    defense = _defense;
    speed = _speed;
    moves = _moves; // Array de Structs Move
}

/// @function scr_initDatabase()
/// @description Inicializa o banco de dados global de monstros e golpes do jogo
function scr_initDatabase()
{
    if (variable_global_exists("databaseInitialized") && global.databaseInitialized) return;

    // 1. Criar o Banco de Golpes (Array de Moves)
    global.movesDatabase = [
        new Move("Investida",    ELEMENT.NORMAL,   40, 100),
        new Move("Brasa",        ELEMENT.FIRE,     50, 100),
        new Move("Jato d'Água",  ELEMENT.WATER,    50, 100),
        new Move("Chicote",      ELEMENT.GRASS,    50, 100),
        new Move("Choque",       ELEMENT.ELECTRIC, 55, 100)
    ];

    // 2. Criar o Banco de Criaturas (Array de Structs)
    global.creatureDatabase = [
        // 0: Pyromon (Fogo)
        new Creature("Pyromon", ELEMENT.FIRE, 100, 28, 12, 16, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[1]  // Brasa
        ]),

        // 1: Aquamon (Água)
        new Creature("Aquamon", ELEMENT.WATER, 110, 22, 15, 14, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[2]  // Jato d'Água
        ]),

        // 2: Floramon (Planta)
        new Creature("Floramon", ELEMENT.GRASS, 105, 24, 14, 15, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[3]  // Chicote
        ]),

        // 3: Sparkmon (Elétrico)
        new Creature("Sparkmon", ELEMENT.ELECTRIC, 95, 30, 10, 20, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[4]  // Choque
        ])
    ];

    // 3. Monstro ativo no time do Jogador (Cópia da criatura 0 do banco)
    var _baseP = global.creatureDatabase[0];
    global.playerCreature = new Creature(
        _baseP.name, _baseP.element, _baseP.maxHp, _baseP.attack, _baseP.defense, _baseP.speed, _baseP.moves
    );

    global.databaseInitialized = true;
}
