// Ifrit target
// (n = muuttuja)
// Käytännössä mitä scripti tekee on, Luo Ifritin n metriä pelaajasta, ja alkaa tarkistamaan ensinnäkin, onko Ifrit tai sen kuljettaja elossa. Jos ei, luo uuden, ja jatkaa mistä jäikin.
// Luonnin jälkeen annetaan käsky Ifritille mennä X,Y,Z akseliston Y akselilla n metriä pelaajasta, josta miinustetaan n metriä tarkistus etäisyyttä varten, eli käytännössä antaa pelivaraa pelaajan liikkeille.
// Esim. sanotaan Ifritille: mene 100m tuohon suuntaan, tarkistukselle annetaan 10m. 100-10 = 90. 90 metrin kohdalla pelaajasta Ifrit alkaa muuttaa reittiään. 
// Pelaajalla on siis 10 metriä pelivaraa liikkua Ifrittiä päin, jonka jälkeen koodi menee "rikki" siksi aikaa, kunnes pelaaja palaa takaisin tarpeeksi kauas Ifritistä.
// Huomioi kuitenkin, että jos pelaaja lähtee poispäin Ifritistä, se lähtee takaisinpäin nopeammin.
// Koodille pitää antaa aikaa "nukkua" suunnan vaihtojen aikana. Jos intervalli on 0, suunta vaihtuu jatkuvasti, eikä Ifrit lähde liikkeelle, sillä se saa jatkuvasti eri komentoja.
// Pitemmillä matkoilla huomasin, että n. 20sec on tarpeeksi. Lyhyemmillä 20sec on liikaa, ja Ifrit pysähtyy hetkeksi.
// Voit myös vaihtaa mitä luodaan laittamalla esim. Panssarivaunun Class nimen Ifritin tilalle. Löytyy eden editorista hoveraamalla vaunun päällä, tai Unitin vaihtoehtojen Find in Asset Browser kohdasta.
// Jälkimmäinen laittaa hakukenttään Ifritistä tuloksen Class O_MRAP_02_F. Muista laittaa luokkanimi "tuumamerkkien" sisään Esim Ifrit: "O_MRAP_02_F".
// JOKAINEN KOODIPÄTKÄ PITÄÄ LOPETTAA PILKKUPISTEELLÄ!!!!!!! (;)
// Ei siinä mitään, Jos tulee ongelmia niin pistä viestiä.

// Kontrollit:
// _Mdist    = Kuinka pitkälle Ifrit saa mennä pelaajasta.
// _Rmdist   = Pelaajan "pelivara", missä kohtaa Ifrit oikeasti lähtee takaisin. Esim. _Mdist = 100, _Rmdist = 10, 100-10 = 90, Ifrit lähtee oikeasti takaisin 90m jälkeen. Voit liikkua max 10m Ifrittiä päin.
// _Interval = Aika, jonka Ifrit odottaa ennen kuin seuraava komento voidaan antaa suunnan vaihdon jälkeen. Huom. Pitemmillä matkoilla väh. 20 sekunttia. ilman tätä, koodi ei toimi.
// _Crdist   = Kuinka kauas pelaajasta Ifrit aluksi luodaan.
// _Veh      = Mikä esine luodaan.

// Voit asettaa koodin esim. Triggeriin, tai pelaajan Init kohtaan.
// Koodi:
0=[] spawn
{
    _Mdist = 30;
    _Rmdist = 10;
    _Interval = 5;
	_Crdist = 10;
	_Veh = "O_MRAP_02_F";



    _Plpos = getPosASL player;
    _Car = _Veh createVehicle _Plpos;
    _dir = player weaponDirection currentWeapon player;  
    _Carpos = getPosASL _Car;
    _Car setPosASL [  
        (_Carpos select 0),  
        (_Carpos select 1) +_Crdist,  
        (_Carpos select 2) +(_Crdist/10)  
    ];    
    _Crew = createVehicleCrew _Car;
    _Carpos = getPosASL _Car;
    _Driver = units _Crew select 0;
    _MP = [  
        (_Plpos select 0),  
        (_Plpos select 1) +_Mdist,  
        (_Plpos select 2)  
    ];    
    _Car doMove _MP;
    _Neg = 0;
    _Chkdist = _Mdist - _Rmdist;


    while{true} do{
	    _Carpos = getPosASL _Car;
	    _Plpos = getPosASL player;
	    if (damage _Driver == 1) 
	    then {
	    	deleteVehicle _Car;
	    	_Car = "O_MRAP_02_F" createVehicle _Carpos;
	    	_Crew = createVehicleCrew _Car;
	    	_Driver = units _Crew select 0;
	    	_Car doMove _MP;
	    };
	    if (damage _Car == 1) 
	    then {
	    	deleteVehicle _Car;
	    	_Car = "O_MRAP_02_F" createVehicle _Carpos;
	    	_Crew = createVehicleCrew _Car;
	    	_Driver = units _Crew select 0;
	    	_Car doMove _MP;
	    };
	    if (_Car distance player > _Chkdist && _Neg == 0) 
	    then {
	    	_Neg = 1;
	    	hint str[_Neg];
	    	_MP =  [  
                (_Plpos select 0),  
                (_Plpos select 1) -_Mdist,  
                (_Plpos select 2)  
            ];
	    	_Car doMove _MP;
	    	sleep _Interval;
    	};
	    	if (_Car distance player > _Chkdist && _Neg == 1) 
	    then {
	    	_Neg = 0;
	    	hint str[_Neg];
	    	_MP =  [  
                (_Plpos select 0),  
                (_Plpos select 1) +_Mdist,  
                (_Plpos select 2)  
            ];
		    _Car doMove _MP;
		    sleep _Interval;
	    };
    };
};
