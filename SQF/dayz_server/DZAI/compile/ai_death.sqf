/*
		DZAI_unitDeath
		
		Description: Called when AI unit blood level drops below zero to process unit death.
		
        Usage: [_unit,_killer] call DZAI_unitDeath;
*/

private["_victim","_killer","_unitGroup","_unitType","_launchWeapon","_launchAmmo","_deathType","_groupIsEmpty","_unitsAlive"];
_victim = _this select 0;
_killer = _this select 1;
_deathType = if ((count _this) > 2) then {_this select 2} else {"bled"};

if (_victim getVariable ["deathhandled",false]) exitWith {};
_victim setVariable ["deathhandled",true];
_victim setDamage 1;
_victim removeAllEventHandlers DZAI_healthType;

_unitGroup = (group _victim);
_unitsAlive = ({alive _x} count (units _unitGroup));
_groupIsEmpty = (_unitsAlive == 0);
if (_groupIsEmpty) then {_unitGroup call DZAI_protectGroup}; //prevent group from being cleaned until ready
_unitGroup setVariable ["GroupSize",((_unitGroup getVariable ["GroupSize",0]) - 1)];
_unitType = _unitGroup getVariable ["unitType",""];

call {
	if (_unitType == "static") exitWith {
		[_victim,_killer,_unitGroup,_groupIsEmpty] call DZAI_AI_killed_static;
		0 = [_victim,_killer,_unitGroup,_unitType,_unitsAlive] call DZAI_AI_killed_all;
		DZAI_numAIUnits = DZAI_numAIUnits - 1;
	};
	if (_unitType == "dynamic") exitWith {
		[_victim,_killer,_unitGroup,_groupIsEmpty] call DZAI_AI_killed_dynamic;
		0 = [_victim,_killer,_unitGroup,_unitType,_unitsAlive] call DZAI_AI_killed_all;
		DZAI_numAIUnits = DZAI_numAIUnits - 1;
	};
	if (_unitType in ["air","aircustom"]) exitWith {
		[_victim,_unitGroup] call DZAI_AI_killed_air;
	};
	if (_unitType in ["land","landcustom"]) exitWith {
		0 = [_victim,_killer,_unitGroup,_unitType] call DZAI_AI_killed_all;
		if (_groupIsEmpty) then {
			[_unitGroup] call DZAI_AI_killed_land; //Only run this if entire group has been killed
		};
	};
	if (_unitType == "aircrashed") exitWith {};
	if (_groupIsEmpty) then {
		_nul = [_unitGroup,30] spawn DZAI_deleteGroupTimed;
	};
};

if !(isNull _victim) then {
	_launchWeapon = (secondaryWeapon _victim);
	if (_launchWeapon in DZAI_launcherTypes) then {
		_launchAmmo = getArray (configFile >> "CfgWeapons" >> _launchWeapon >> "magazines") select 0;
		_victim removeWeapon _launchWeapon;
		_victim removeMagazines _launchAmmo;
	};

	if (_deathType == "shothead") then { //no need for isplayer check since "shothead" is only possible if killer is a player
		_nul = _killer spawn {
			_headshots = _this getVariable["headShots",0];
			_headshots = _headshots + 1;
			_this setVariable["headShots",_headshots,true];
		};
	};

	if (_victim getVariable ["removeNVG",true]) then {
		_victim removeWeapon "NVGoggles";
	};

	if (_unitGroup getVariable ["CombatModeBlue",false]) then {_unitGroup setCombatMode "RED"};

	_victim spawn DZAI_deathFlies;
	_victim setVariable ["bodyName",_victim getVariable ["bodyName","unknown"],true];		//Broadcast the unit's name (was previously a private variable).
	_victim setVariable ["deathType",_deathType,true];
	_victim setVariable ["DZAI_deathTime",(diag_tickTime + DZAI_cleanupDelay)];
	_victim setVariable ["unconscious",true];
};

_victim
