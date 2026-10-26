/// ------------------------------------------------------------------
/// Banco de Dados de Batalha: Tipos Elementais, Golpes e Criaturas (V3)
/// Suporte a Grupos (2v2 / 3v3) e Buffs/Debuffs de Status
/// ------------------------------------------------------------------

/// @function scr_getTypeMultiplier(atkElement, defElement)
/// @description Retorna o multiplicador de dano baseado na vantagem elemental (0.5x, 1.0x ou 2.0x)
function scr_getTypeMultiplier(_atkElement, _defElement)
{
    if (_atkElement == ELEMENT.NORMAL || _defElement == ELEMENT.NORMAL) return 1.0;

    if (_atkElement == ELEMENT.FIRE) {
        if (_defElement == ELEMENT.GRASS) return 2.0;
        if (_defElement == ELEMENT.WATER) return 0.5;
    }
    if (_atkElement == ELEMENT.WATER) {
        if (_defElement == ELEMENT.FIRE) return 2.0;
        if (_defElement == ELEMENT.GRASS) return 0.5;
    }
    if (_atkElement == ELEMENT.GRASS) {
        if (_defElement == ELEMENT.WATER) return 2.0;
        if (_defElement == ELEMENT.FIRE) return 0.5;
    }
    if (_atkElement == ELEMENT.ELECTRIC) {
        if (_defElement == ELEMENT.WATER) return 2.0;
        if (_defElement == ELEMENT.GRASS) return 0.5;
    }

    return 1.0;
}

/// @function scr_getElementName(element)
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

/// @function StatusEffect(_type, _duration, _multiplier)
function StatusEffect(_type, _duration, _multiplier = 1.0) constructor
{
    type = _type;
    duration = _duration;
    multiplier = _multiplier;
}

/// @function Move(_name, _element, _movePower, _accuracy, _targetType, _buffType, _buffDuration)
function Move(_name, _element, _movePower, _accuracy, _targetType = "enemy", _buffType = STAT_BUFF.NONE, _buffDuration = 0) constructor
{
    name = _name;
    element = _element;
    movePower = _movePower;
    accuracy = _accuracy;
    targetType = _targetType; // "enemy", "self", "ally"
    buffType = _buffType;
    buffDuration = _buffDuration;
}

/// @function Creature(_name, _element, _maxHp, _attack, _defense, _speed, _moves)
function Creature(_name, _element, _maxHp, _attack, _defense, _speed, _moves) constructor
{
    name = _name;
    element = _element;
    maxHp = _maxHp;
    hp = _maxHp;
    attack = _attack;
    defense = _defense;
    speed = _speed;
    moves = _moves;
    statusEffects = [];

    static getEffectiveAttack = function() {
        var _mult = 1.0;
        for (var i = 0; i < array_length(statusEffects); i++) {
            if (statusEffects[i].type == STAT_BUFF.ATK_UP) _mult *= 1.5;
            if (statusEffects[i].type == STAT_BUFF.ATK_DOWN) _mult *= 0.7;
        }
        return max(1, round(attack * _mult));
    };

    static getEffectiveDefense = function() {
        var _mult = 1.0;
        for (var i = 0; i < array_length(statusEffects); i++) {
            if (statusEffects[i].type == STAT_BUFF.DEF_UP) _mult *= 1.5;
            if (statusEffects[i].type == STAT_BUFF.DEF_DOWN) _mult *= 0.7;
        }
        return max(1, round(defense * _mult));
    };

    static getEffectiveSpeed = function() {
        var _mult = 1.0;
        for (var i = 0; i < array_length(statusEffects); i++) {
            if (statusEffects[i].type == STAT_BUFF.SPD_UP) _mult *= 1.5;
            if (statusEffects[i].type == STAT_BUFF.SPD_DOWN) _mult *= 0.7;
        }
        return max(1, round(speed * _mult));
    };

    static applyBuff = function(_buffType, _duration) {
        if (_buffType == STAT_BUFF.NONE || _duration <= 0) return "";
        
        for (var i = array_length(statusEffects) - 1; i >= 0; i--) {
            if (statusEffects[i].type == _buffType) {
                array_delete(statusEffects, i, 1);
            }
        }
        array_push(statusEffects, new StatusEffect(_buffType, _duration));
        
        switch(_buffType) {
            case STAT_BUFF.ATK_UP:   return name + " aumentou o Ataque (+50%)!";
            case STAT_BUFF.ATK_DOWN: return name + " teve o Ataque reduzido (-30%)!";
            case STAT_BUFF.DEF_UP:   return name + " aumentou a Defesa (+50%)!";
            case STAT_BUFF.DEF_DOWN: return name + " teve a Defesa reduzida (-30%)!";
            case STAT_BUFF.SPD_UP:   return name + " aumentou a Velocidade (+50%)!";
            case STAT_BUFF.SPD_DOWN: return name + " teve a Velocidade reduzida (-30%)!";
            default: return "";
        }
    };

    static updateBuffs = function() {
        for (var i = array_length(statusEffects) - 1; i >= 0; i--) {
            statusEffects[i].duration--;
            if (statusEffects[i].duration <= 0) {
                array_delete(statusEffects, i, 1);
            }
        }
    };
}

/// @function scr_initDatabase()
function scr_initDatabase()
{
    if (variable_global_exists("databaseInitialized") && global.databaseInitialized) return;

    // 1. Criar Banco de Golpes (Com Dano e Buffs/Debuffs)
    global.movesDatabase = [
        new Move("Investida",    ELEMENT.NORMAL,   40, 100, "enemy"),
        new Move("Brasa",        ELEMENT.FIRE,     50, 100, "enemy"),
        new Move("Jato d'Água",  ELEMENT.WATER,    50, 100, "enemy"),
        new Move("Chicote",      ELEMENT.GRASS,    50, 100, "enemy"),
        new Move("Choque",       ELEMENT.ELECTRIC, 55, 100, "enemy"),
        new Move("Afiar",        ELEMENT.NORMAL,    0, 100, "self",  STAT_BUFF.ATK_UP, 3),
        new Move("Escudo",       ELEMENT.NORMAL,    0, 100, "self",  STAT_BUFF.DEF_UP, 3),
        new Move("Acelerar",     ELEMENT.NORMAL,    0, 100, "self",  STAT_BUFF.SPD_UP, 3),
        new Move("Rosnar",       ELEMENT.NORMAL,    0, 100, "enemy", STAT_BUFF.ATK_DOWN, 3)
    ];

    // 2. Criar Banco de Criaturas
    global.creatureDatabase = [
        // 0: Pyromon (Fogo)
        new Creature("Pyromon", ELEMENT.FIRE, 100, 28, 12, 16, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[1], // Brasa
            global.movesDatabase[5]  // Afiar (+ATK)
        ]),

        // 1: Aquamon (Água)
        new Creature("Aquamon", ELEMENT.WATER, 110, 22, 15, 14, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[2], // Jato d'Água
            global.movesDatabase[6]  // Escudo (+DEF)
        ]),

        // 2: Floramon (Planta)
        new Creature("Floramon", ELEMENT.GRASS, 105, 24, 14, 15, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[3], // Chicote
            global.movesDatabase[8]  // Rosnar (-ATK)
        ]),

        // 3: Sparkmon (Elétrico)
        new Creature("Sparkmon", ELEMENT.ELECTRIC, 95, 30, 10, 20, [
            global.movesDatabase[0], // Investida
            global.movesDatabase[4], // Choque
            global.movesDatabase[7]  // Acelerar (+SPD)
        ])
    ];

    // 3. Time Padrão de Heróis (2v2)
    var _c0 = global.creatureDatabase[0];
    var _c1 = global.creatureDatabase[1];
    global.playerPartyPreset = [
        new Creature(_c0.name, _c0.element, _c0.maxHp, _c0.attack, _c0.defense, _c0.speed, _c0.moves),
        new Creature(_c1.name, _c1.element, _c1.maxHp, _c1.attack, _c1.defense, _c1.speed, _c1.moves)
    ];

    // 4. Time Padrão de Inimigos (2v2)
    var _c2 = global.creatureDatabase[2];
    var _c3 = global.creatureDatabase[3];
    global.enemyPartyPreset = [
        new Creature(_c2.name, _c2.element, _c2.maxHp, _c2.attack, _c2.defense, _c2.speed, _c2.moves),
        new Creature(_c3.name, _c3.element, _c3.maxHp, _c3.attack, _c3.defense, _c3.speed, _c3.moves)
    ];

    global.databaseInitialized = true;
}
