// This script will go through all the markers with the same name, check their area, 
// and if there are units that match the desired class name, changes their faction to what you want. i.e opfor/blufor.
// <variables>
//_varName = Variable name of the trigger, i.e "marker";
//_configName = Class name of the desired unit, i.e "C_man_1";
//_group = The group to which they will be attached to. i.e west for blufor and east for opfor;
//_NoT = Number of triggers;
//_DamageTo = What health the unit will be when he changes factions, from 0 - 1;
//</variables>


_varName = 'variable name';
_configName = 'Class name of the unit';
_group = 'faction';
_NoT = 'number of triggers';
_damageTo = 'Unit health, from 0 - 1';


_number = 0;
_varName = _varName + "_";
while{_number <= _NoT} 
do 
{
	_number = _number +1;
    _trigName = _varName + str _number;  
    _trigNumb = call compile _trigName; 

    _objects = getPosATL _trigNumb nearEntities ((triggerArea _trigNumb) select 0);
    _i = 0;
    while {_i < count _objects} 
    do
    {
    	if(TypeOf (_objects select _i) == _configName) 
    	then
	    {
			_changed = (_objects select _i);
	    	[_changed] join createGroup _group;
	    	if(getDammage _changed <= _damageTo) 
			then
			{
				_changed setDamage _damageTo;
			};
	    	_changed setBehaviour "careless";
	    };
        _i = _i + 1;
    };
};
