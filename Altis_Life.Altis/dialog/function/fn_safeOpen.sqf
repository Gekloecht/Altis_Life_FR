/*	
	File: fn_safeOpen.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the safe inventory menu.
*/
if(dialog) exitWith {}; //A dialog is already open.
life_safeObj = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull life_safeObj) exitWith {};
if(playerSide != civilian) exitWith {};
if((life_safeObj getVariable["safe",-1]) < 1) exitWith {hint "Le coffre est vide!";};
if((life_safeObj getVariable["inUse",false])) exitWith {hint "Quelqu'un accède deja au code.."};
if({side _x == west} count playableUnits < 4) exitWith {hint "Il doit y avoir plus de 4 policiers en ligne pour continuer."};
if(!createDialog "Federal_Safe") exitWith {"Impossible de créer le dialogue, signalez-le.."};
disableSerialization;
ctrlSetText[3501,"Inventaire du Coffre"];
[life_safeObj] call life_fnc_safeInventory;
life_safeObj setVariable["inUse",true,true];
[life_safeObj] spawn
{
	waitUntil {isNull (findDisplay 3500)};
	(_this select 0) setVariable["inUse",false,true];
};