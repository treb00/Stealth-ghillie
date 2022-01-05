[
    "sg_develop_mode",
    "CHECKBOX",
    "Developer mode",
    "Stealth Ghillie",
    false,
	false,
	{
	params ["_value"];
	develop = _value;
	}	
] call cba_settings_fnc_init;