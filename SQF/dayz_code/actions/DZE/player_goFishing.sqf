/*
	DayZ Fishing
	Usage: spawn DZE_player_goFishing;
	Made for DayZ Epoch and Unleashed please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
*/
private ["_itemOut","_position","_isOk","_counter"];

if(CodeInProgress) exitWith { cutText ["Fishing already in progress." , "PLAIN DOWN"]; };
CodeInProgress = true;

call gear_ui_init;

// find position 5m in front of player
_position = player modeltoworld [0,5,0];
if(!(surfaceIsWater _position)) exitWith {CodeInProgress = false; cutText ["Must be near a shore or on a boat to fish." , "PLAIN DOWN"]; };

if(dayz_isSwimming) exitWith {CodeInProgress = false; cutText [localize "str_player_26", "PLAIN DOWN"]; };
if(player getVariable["combattimeout", 0] >= time) exitWith {CodeInProgress = false; cutText ["Canceled Fishing.", "PLAIN DOWN"];};

_isOk = true;
_counter = 0;

// swing fishingpole
player playActionNow "GestureSwing";
// Alert zeds
[player,10,true,(getPosATL player)] spawn player_alertZombies;

r_interrupt = false;

while {_isOk} do {

	if (r_interrupt or (player getVariable["combattimeout", 0] >= time)) then {
		_isOk = false;
		cutText ["Canceled Fishing.", "PLAIN DOWN"];
	} else {
		
		sleep 2;

		_rnd = 100;

		// check if player is in boat
		_vehicle = vehicle player;
		_inVehicle = (_vehicle != player);
		if(_inVehicle) then {
			if(_vehicle isKindOf "Ship") then {
				_rnd = 50;
			};
		};
		

		// 1% chance to catch anything
		if((random _rnd) <= 1) then {
			// Just the one fish for now
			_itemOut = ["ItemTrout","ItemTrout","ItemTrout","ItemTrout","ItemTrout","ItemTrout","ItemTrout","ItemSeaBass","ItemSeaBass","ItemTuna"] call BIS_fnc_selectRandom;
			
			if(_inVehicle) then { 
				_item = _vehicle;
				_itemtodrop = _itemOut;
				_item addMagazineCargoGlobal [_itemtodrop,1];
			} else {
				player addMagazine _itemOut;
			};
			
			
			cutText ["You caught a fish.", "PLAIN DOWN"];
			_isOk = false;
		} else {
			cutText ["Nibble... Nibble...", "PLAIN DOWN"];
			_counter = _counter + 1;
			if(_counter == 5) then {
				_isOk = false;
				sleep 2;
				cutText ["You didn't catch anything.", "PLAIN DOWN"];
			};
		};
	};
};
CodeInProgress = false;