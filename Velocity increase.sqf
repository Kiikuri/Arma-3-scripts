// Set a static velocity to any vehicle. The vehicle moves where the player is looking at, so doesn't work well while in a turret of a tank for example.
// The vehicle must be moving at first before the speed can be set.
// By changing the value of NewVelocity, you can set the velocity of the vehicle in km/h. ie. 5000 = 5000 km/h ≈ 1389 m/s 
// Works well with jets and other planes.
// By placing another trigger that changes the value of Cease to 1, you can stop the script from running
// variables:
// NewVelocity = Wanted speed in km/h
// Cease = check to stop the script, 0 = false, 1 = true

0=[] spawn  
{  
   NewVelocity = 5000;

   Cease = 0;
   _VelocityMultiplier = 2; 
   _veh = vehicle player; 
   if(speed _veh == 0) exitWith {};
   while{Cease <= 0} do
   {
      if(speed _veh < NewVelocity) then{
         _Direction = eyeDirection player; 
         _InitialVelo = velocity _veh; 
         _veh setVelocity [ 
           (_InitialVelo select 0) + (_Direction select 0)*_VelocityMultiplier, 
           (_InitialVelo select 1) + (_Direction select 1)*_VelocityMultiplier, 
           (_InitialVelo select 2) + (_Direction select 2)*_VelocityMultiplier 
         ];
      };
   };
}