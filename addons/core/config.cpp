#include "BIS_AddonInfo.hpp"
////////////////////////////////////////////////////////////////////
//DeRap: stealthghillie\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri May 11 21:04:45 2018 : 'file' last modified on Tue Aug 29 11:23:29 2017
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class SGdevelop
	{
		name = "Stealth Ghillie";
		author = "tr3b";
		units[] = {};
		weapons[] = {};
		version = "1.0";
		versionStr = "1.0";
		
		requiredAddons[] = 
		{
			"A3_UI_F",
            "cba_main",
            "cba_xeh"
        };
	};
};
class CfgFunctions
{
	class SG
	{
		class MyCategory
		{
			class MyInit
			{
				postInit = 1;
				file = "\StealthGhillie\init.sqf";
				description = "script run after mission started and object initialization is complete";
			};
		};
	};
};


class Extended_PreInit_EventHandlers
{
    class SGdevelop
    {
        init = "call compile preProcessFileLineNumbers '\StealthGhillie\XEH_preInit.sqf'";
    };
};