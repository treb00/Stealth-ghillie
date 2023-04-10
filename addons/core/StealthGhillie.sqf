// tr3b's Stealth Ghillie
// 1.1

GhillieSuit = [
    'U_B_GhillieSuit',
    'U_O_GhillieSuit',
    'U_I_GhillieSuit',
    'U_B_FullGhillie_lsh',
    'U_B_FullGhillie_sard',
    'U_B_FullGhillie_ard',
    'U_O_FullGhillie_lsh',
    'U_O_FullGhillie_sard',
    'U_O_FullGhillie_ard',
    'U_I_FullGhillie_lsh',
    'U_I_FullGhillie_sard',
    'U_I_FullGhillie_ard',
    'U_B_T_Sniper_F',
    'U_B_T_FullGhillie_tna_F',
    'U_O_T_Sniper_F',
    'U_O_T_FullGhillie_tna_F'
    ];

// Tresholds

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

SG_fn_Coeff = {
	while {CoeffCalc} do {
		ForestCoeff = position player getEnvSoundController "forest";
		TreeCoeff = position player getEnvSoundController "trees";
		MeadowCoeff = position player getEnvSoundController "meadows";
		NightCoeff = position player getEnvSoundController "night";

		PlayerSpeed = speed player;
		PlayerStance = stance player;

		if (PlayerStance == 'STAND') then { COEFF = Stand; };
		if (PlayerStance == 'CROUCH') then { COEFF = Crouch; };
		if (PlayerStance == 'PRONE') then { COEFF = Prone; };

		if (PlayerSpeed > 0) then { COEFF = COEFF * (PlayerSpeed/15); };
		if (PlayerSpeed == 0) then { COEFF = COEFF * 0.1; };

		if (ForestCoeff >= 0.1) then { COEFF = COEFF * (Forest/ForestCoeff); };
		if (TreeCoeff >= 0.1) then { COEFF = COEFF * (Tree/TreeCoeff); };
		if (MeadowCoeff >= 0.1) then { COEFF = COEFF * (Meadow/MeadowCoeff); };

		if (NightCoeff == 1) then { COEFF = COEFF * NIGHT; };

		player setUnitTrait ['camouflageCoef',COEFF];

		if(develop) then {
			hint parseText format ['Stealth Ghillie: %1%8Stance: %2%8Speed: %3%8Forest: %4%8Tree: %5%8Meadow: %6%8SG VALUE: %7', CoeffCalc, PlayerStance, PlayerSpeed, ForestCoeff, TreeCoeff, MeadowCoeff, COEFF, '<br />'];
		}
	};
};

_StealthGhillie = createTrigger ["EmptyDetector", [0,0,0]];
_StealthGhillie setTriggerActivation ["ANY","PRESENT",true];
_StealthGhillie setTriggerStatements ["((uniform player) in GhillieSuit && !CoeffCalc)",
"
CoeffCalc = true;
_0 = [] spawn SG_fn_Coeff;
"
,""];

_StealthGhillie = createTrigger ["EmptyDetector", [0,0,0]];
_StealthGhillie setTriggerActivation ["ANY","PRESENT",true];
_StealthGhillie setTriggerStatements ["(!((uniform player) in GhillieSuit) && CoeffCalc)",
"
CoeffCalc = false;
"
,""];

//TODO
// Issue:
