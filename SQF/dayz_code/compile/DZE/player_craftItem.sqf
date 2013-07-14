/*
	DayZ Unleashed Crafting 0.1
	Usage: DZE_Crafting = ['Crafting','CfgMagazines']; spawn DZE_player_craftItem;
	Made for DayZ Unleashed by [VB]AWOL please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
*/

/*
USAGE EXAMPLE:
class ItemActions
{
	class Crafting
	{
		text = "Craft Tent";
		script = "DZE_Crafting = ['Crafting','CfgMagazines']; spawn DZE_player_craftItem;";
		neednearby[] = {"workshop","fire"};
		requiretools[] = {"ItemToolbox","ItemKnife"}; // (cfgweapons only)
		output[] = {{"ItemTent",1}}; // (CfgMagazines, qty)
		input[] = {{"ItemCanvas",2},{"ItemPole",2}}; // (CfgMagazines, qty)
		inputweapons[] = {"ItemToolbox"}; // consume toolbox (cfgweapons only)
		outputweapons[] = {"ItemToolbox"}; // return toolbox (cfgweapons only)
	};
};	
*/
private ["_onLadder","_canDo","_selectedRecipeOutput","_proceed","_itemIn","_countIn","_missing","_missingQty","_qty","_itemOut","_countOut","_started","_finished","_animState","_isMedic","_removed","_tobe_removed_total","_textCreate","_textMissing","_selectedRecipeInput","_num_removed","_removed_total","_temp_removed_array","_abort","_reason","_isNear","_missingTools","_hastoolweapon","_selectedRecipeTools","_distance","_crafting","_needNear","_item","_baseClass","_num_removed_weapons","_outputWeapons","_inputWeapons"];

if(CraftingInprogress) exitWith { cutText ["Crafting already in progress." , "PLAIN DOWN"]; };
CraftingInprogress = true;

// This is used to find correct recipe based what itemaction was click allows multiple recipes per item.
_crafting = DZE_Crafting select 0;

// This tells the script what type of item we are clicking on
_baseClass = DZE_Crafting select 1;

DZE_Crafting = nil;

_item = _this;
_temp_removed_array = [];
_abort = false;
_distance = 3;
_reason = "";

_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);

// Need Near Requirements
_needNear = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "neednearby");
if("fire" in _needNear) then {
	_isNear = {inflamed _x} count (position player nearObjects _distance);
	if(_isNear == 0) then {  
		_abort = true;
		_reason = "fire";
	};
};
if("workshop" in _needNear) then {
	_isNear = count (nearestObjects [player, ["WorkBench_DZ"], _distance]); // Needs changed to your workbench class
	if(_isNear == 0) then {  
		_abort = true;
		_reason = "workshop";
	};
};
if(_abort) exitWith {
	cutText [format["Crafting needs a %1 within %2 meters",_reason,_distance], "PLAIN DOWN"];
	CraftingInprogress = false;
};

if (_canDo) then {
	
	_selectedRecipeTools = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "requiretools");
	_outputWeapons = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "outputweapons");
	_inputWeapons = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "inputweapons");
	
	_missing = "";
	_missingTools = false;
	{
		_hastoolweapon = _x in weapons player;
		if(!_hastoolweapon) exitWith { _missingTools = true; _missing = _x; };
	} forEach (_selectedRecipeTools+_inputWeapons);

	if(!_missingTools) then {

		_selectedRecipeOutput = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "output");	
		_selectedRecipeInput = getArray (configFile >> _baseClass >> _item >> "ItemActions" >> _crafting >> "input");
	
		// Dry run to see if all parts are available.
		_proceed = true;
		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			_qty = { (_x == _itemIn) || (configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn) } count magazines player;	
			if(_qty < _countIn) exitWith { _missing = _itemIn; _missingQty = (_countIn - _qty); _proceed = false; };
		} forEach _selectedRecipeInput;

		// If all parts proceed
		if (_proceed) then {

			cutText ["Crafting started", "PLAIN DOWN"];
			player playActionNow "Medic";
			[player,"repair",0,false] call dayz_zombieSpeak;
			[player,50,true,(getPosATL player)] spawn player_alertZombies;
			
			r_interrupt = false;
			_animState = animationState player;
			r_doLoop = true;
			_started = false;
			_finished = false;
	
			while {r_doLoop} do {
				_animState = animationState player;
				_isMedic = ["medic",_animState] call fnc_inString;
				if (_isMedic) then {
					_started = true;
				};
				if (_started and !_isMedic) then {
					r_doLoop = false;
					_finished = true;
				};
				if (r_interrupt) then {
					r_doLoop = false;
				};
				sleep 0.1;
			};
			r_doLoop = false;

			if (_finished) then {
				_removed_total = 0; // count total of removed items
				_tobe_removed_total = 0; // count total of all to be removed items
				{
					_removed = 0;
					_itemIn = _x select 0;
					_countIn = _x select 1;
					_tobe_removed_total = _tobe_removed_total + _countIn;
					{					
						if( (_removed < _countIn) && ((_x == _itemIn) || configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn)) then {
							_num_removed = ([player,_x] call BIS_fnc_invRemove);
							_removed = _removed + _num_removed;
							_removed_total = _removed_total + _num_removed;
							if(_num_removed >= 1) then {
								_temp_removed_array set [count _temp_removed_array,_x];
							};
						};
					} forEach magazines player;
				} forEach _selectedRecipeInput;
				
				// Only proceed if all parts were removed successfully
				if(_removed_total == _tobe_removed_total) then {
					_num_removed_weapons = 0;
					{
						_num_removed_weapons = _num_removed_weapons + ([player,_x] call BIS_fnc_invRemove);
					} forEach _inputWeapons;
					if (_num_removed_weapons == (count _inputWeapons)) then {	
						{
							player addWeapon _x; 
						} forEach _outputWeapons;
						{	
							_itemOut = _x select 0;
							_countOut = _x select 1;
							for "_x" from 1 to _countOut do {
								player addMagazine _itemOut;
							};
							_textCreate = getText(configFile >> "CfgMagazines" >> _itemOut >> "displayName");
							cutText [format["Crafted Item: %1 x %2",_textCreate,_countOut], "PLAIN DOWN"];		
						} forEach _selectedRecipeOutput;
					};
					
				} else {
					// Refund parts since we failed 
					{player addMagazine _x;} forEach _temp_removed_array;
					cutText [format["Missing Parts after first check Item: %1 / %2",_removed_total,_tobe_removed_total], "PLAIN DOWN"];
				};
			} else {
				r_interrupt = false;
				if (vehicle player == player) then {
					[objNull, player, rSwitchMove,""] call RE;
					player playActionNow "stop";
				};
				cutText ["Canceled crafting.", "PLAIN DOWN"];
			};
		} else {
			_textMissing = getText(configFile >> "CfgMagazines" >> _missing >> "displayName");
			cutText [format["Missing %1 more of %2",_missingQty, _textMissing], "PLAIN DOWN"];
		};
	} else {
		_textMissing = getText(configFile >> "CfgWeapons" >> _missing >> "displayName");
		cutText [format["Missing Tool: %1",_textMissing], "PLAIN DOWN"];
	};
} else {
	cutText ["Canceled crafting.", "PLAIN DOWN"];
};
CraftingInprogress = false;