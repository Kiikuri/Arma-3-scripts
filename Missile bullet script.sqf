Pistä scripti jonkun ajoneuvon/unitin init kohtaan attribuuteista.

this addeventhandler ["fired", { 
  _bullet = nearestObject [_this select 0,_this select 4]; 
  _bulletpos = getPosASL _bullet; 
  _o = "BombCluster_02_Ammo_F" createVehicle _bulletpos; 
  _weapdir = player weaponDirection currentWeapon player; 
  _dist = 10; 
  _BulletSpeed = 100;
  _o setPosASL [ 
    (_bulletpos select 0) + (_weapdir select 0)*_dist, 
    (_bulletpos select 1) + (_weapdir select 1)*_dist, 
    (_bulletpos select 2) + (_weapdir select 2)*_dist 
  ]; 
  _up = vectorUp _bullet; 
  _o setVectorDirAndUp[_weapdir,_up];
  _bulletVelo = velocity _bullet;  
  _bulletDir = direction _bullet;
  _o setVelocity [
    (_bulletVelo select 0) + (_weapdir select 0)*_BulletSpeed,
    (_bulletVelo select 1) + (_weapdir select 1)*_BulletSpeed,
    (_bulletVelo select 2) + (_weapdir select 2)*_BulletSpeed
    ];
  deleteVehicle _bullet;
}];



vaihda yllä olevassa koodissa tästä rivistä <> sisällä oleva osa jollakin alla olevista, vaihtaakesi sen, mitä ase ampuu.
_o = <jokin alla olevista> createVehicle _bulletpos; 

_dist = etäisyys, kuinka kauas uusi ammus tehdään aseen piipusta. kannattaa olla suurempi kuin 0.
_bulletVelo = lisätty nopeus ammukselle. Esim. 100 lisää ammuksen nopeutta jollain määrällä. Kokeilin lukua 1000000 ja ammukset menivät erittäin suurella nopeudella, 
              mutta lähelle osunut kaatoi pelin. Ei vielä mitään hajua miten toimii, mutta toimii kuitenkin. luku 0 = aseen oman patruunan lähtönopeus. kun luku < 0, hidastaa luotia (oletettavasti).
voit etsiä esim wikistä tai pelin omista config/ammo tiedostoista ammuksia, mitä käyttää. Huom. Pitää olla Ammo tyyppiä, ei Magazine tai Weapon. Voi olla mahdollista kuitenkin ampua esim. autoja
vaihtamalla yllä olevan koodin rivistä <> sisällä oleva kohta jonkin ajoneuvon class nimellä. Löytyy esim "hoveraamalla" ajoneuvojen yllä, ja tooltipin alapuolella on esim. B_MBT_01_cannon_F.

"rhs_ammo_30x165mm_base"       /// ball 30mm (Vaatii modin)
"LIB_B_37mm_AP"                /// 37mm HE AP (Vaatii modin) 
"FIR_GAU8_ammo_API"            /// 30mm API (Vaatii modin)
"CUP_B_30mm_AP_Red_Tracer"     /// 30mm AP tracer (Vaatii modin)
"BombCluster_02_Ammo_F"        /// 1100lb cluster bomb (vanilla)
(currentMagazine this)         /// Aseen omat patruunat (vanilla) (ei vaadi heittomerkkejä)
"RPG7_F"                       /// RPG-7V


this addeventhandler ["fired", {  
  _bullet = nearestObject [_this select 0,_this select 4];  
  _bulletpos = getPosASL _bullet;  
  _o = "USAF_bo_B61" createVehicle _bulletpos;  
  _weapdir = player weaponDirection currentWeapon player;  
  _dist = 0; 
  _distance = this distance getPosATL laserTarget player; 
  _BulletSpeed = 50; 
  _o setPosASL [  
    (_bulletpos select 0) + (_weapdir select 0)*_dist,  
    (_bulletpos select 1) + (_weapdir select 1)*_dist,  
    (_bulletpos select 2) + (_weapdir select 2)*_dist  
  ];  
  _up = vectorUp _bullet;  
  _o setVectorDirAndUp[_weapdir,_up]; 
  _bulletVelo = velocity _bullet;   
  _bulletDir = direction _bullet; 
  _o setVelocity [ 
    (_bulletVelo select 0) + (_weapdir select 0)*_BulletSpeed, 
    (_bulletVelo select 1) + (_weapdir select 1)*_BulletSpeed, 
    (_bulletVelo select 2) + (_weapdir select 2)*_BulletSpeed 
    ]; 
  deleteVehicle _bullet; 
}]; 
