// tr3b's Stealth Ghillie
// 1.1

if (!isServer) exitwith {};

// Coefficients

STAND = 5;
CROUCH = 0.4;
PRONE = 0.1;

FOREST = 0.2;
TREE = 0.3;
MEADOW = 1;

NIGHT = 0.5;

// DEBUG

CoeffCalc = false;
develop = false;

// if PFH is already running, stop the previous one
if (!isnil QGVAR(SGHILLIE)) then {
    GVAR(SGHILLIE) call CBA_fnc_removePerFrameHandler;
};

GVAR(SGHILLIE) = [{
    {
        if(alive _x and (isText (_x >> "displayName") && {(_x >> "displayName") find "ghillie" != -1})) then {
            forestCoeff = position _x getEnvSoundController "forest";
            TreeCoeff = position _x getEnvSoundController "trees";
            MeadowCoeff = position _x getEnvSoundController "meadows";
            NightCoeff = position _x getEnvSoundController "night";

            playerspeed = speed _x;
            playerstance = stance _x;

            if (playerstance == 'STAND') then {
                COEFF = Stand;
            };
            if (playerstance == 'CROUCH') then {
                COEFF = Crouch;
            };
            if (playerstance == 'PRONE') then {
                COEFF = Prone;
            };

            if (playerspeed > 0) then {
                COEFF = COEFF * (playerspeed/15);
            };
            if (playerspeed == 0) then {
                COEFF = COEFF * 0.1;
            };

            if (forestCoeff >= 0.1) then {
                COEFF = COEFF * (FOREST/forestCoeff);
            };
            if (TreeCoeff >= 0.1) then {
                COEFF = COEFF * (TREE/TreeCoeff);
            };
            if (MeadowCoeff >= 0.1) then {
                COEFF = COEFF * (MEADOW/MeadowCoeff);
            };

            if (NightCoeff == 1) then {
                COEFF = COEFF * NIGHT;
            };

            _x setUnitTrait ['camouflageCoef', COEFF];

            if (develop) then {
                hint parsetext format ['Stealth Ghillie: %1%8stance: %2%8speed: %3%8forest: %4%8Tree: %5%8Meadow: %6%8SG VALUE: %7', CoeffCalc, playerstance, playerspeed, forestCoeff, TreeCoeff, MeadowCoeff, COEFF, '<br />'];
            }
        }
    } forEach allPlayers - entities "HeadlessClient_F"
}] call CBA_fnc_addPerFrameHandler
