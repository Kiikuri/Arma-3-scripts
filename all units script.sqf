/// The script Makes every unit with the same variable name with and underscore and a number to do the same thing. ie 
/// Change the _name and _lkm values to those of your units. ie. _name = "enemy_"; _lkm = 100;
/// Tell the units what to do in the 'do something' slot using the _obj variable as the unit. ie. _obj doMove getPosATL position;

0= [] spawn { 
_name = ('name of unit' + _);  
_lkm = 'Number of units';


_numero = 0;  
while{_numero <= _lkm} 
do 
{ 
_numero = _numero +1; 
_numb = str _numero; 
_nimi = _name + _numb;  
_obj = call compile _nimi; 
'do something';
} 
}