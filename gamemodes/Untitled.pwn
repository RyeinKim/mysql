//============================================================================//
//                       Apocalypse Role Play By. Leehi                       //
//  1. MySQL 구축 - (2016. 10. 08)
//  2. 관리자 명령어 소량 추가 - (2016. 10. 12)
//============================================================================//
//============================================================================//
//                                  Includes                                  //
//============================================================================//

#include <a_samp.inc>
#include <a_mysql.inc>

//============================================================================//
//                                  Defines                                  //
//============================================================================//

#define SERVER_NAME     "Apocalypse Role Play Serer TEST"
#define SERVER_TIME     "12"
#define SERVER_MAP      "Apocalypse Role Play"
#define SERVER_WEBSITE  "cafe.daum.net/Tarp"

#define SQL_HOST "localhost"
#define SQL_USER "root"
#define SQL_PASS ""
#define SQL_DB 	 "battle"

#define Blue    "{003DF5}"
#define Red     "{FF0000}"
#define Green   "{66FF00}"
#define White   "{FFFFFF}"
#define C_RED 				0xFF0000FF
#define C_GREY 				0xAFAFAFFF
#define C_BLUE 				0x0000BBFF
#define C_WHITE 			0xFFFFFFFF
#define COLOR_PURPLE 		0xC2A2DAAA
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_FADE5 		0x6E6E6E6E

#define DIALOG_REGISTER         	100
#define DIALOG_LOGIN            	101
#define DIALOG_INVENTORY_MAIN      	200
#define DIALOG_INVENTORY_USEDROP    201
#define DIALOG_CAR_BUY              300
#define DIALOG_BUILD                400

#define M_P 100
#define WEAPON_HACK 46

#define VEHICLE_SPEED_NONE 	(0)
#define VEHICLE_SPEED_MPH 	(1)
#define VEHICLE_SPEED_KMPH 	(2)


//============================================================================//
//                                  Forwards                                  //
//============================================================================//

forward MySQL_CreateVehicle(modelid, Float:X, Float:Y, Float:Z, Float:angle, color1, color2, paintjobid, interiorid, worldid);
forward MySQL_SaveVehicle(vehicleid);
forward MySQL_LoadVehicle(numberplate[]);
forward MySQL_LoadVehicles();
forward MySQL_RemoveVehicle(numberplate[]);

forward CreateFaction(type, name[]);
forward SaveFaction(factionid);
forward LoadFactions();
forward RemoveFaction(factionid);

forward HideMessage1(playerid);
forward AutoSaveTimer();

forward SetVehicleInterior(vehicleid, intid);

forward SendAdminMessage(color,string[]);

forward OnPlayerChangeVehicle(playerid, vehicleid);
forward SafeGivePlayerWeapon(playerid, weaponid, ammo);
forward OOCOff(color,const string[]);
forward ResetPlayerVariable(playerid);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

forward TutorialEnd(playerid);
forward Tuto1(playerid);
forward Tuto2(playerid);
forward Tuto3(playerid);
forward Tuto4(playerid);

forward IsABike(vehicleid);
forward StartingTheVehicle(playerid);

//============================================================================//
//                                  New's                                     //
//============================================================================//

new VehicleName[][] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Fire truck",
   "Sweepmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer",
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer",
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer",
   "Hotring Racer",
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker",
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Fire Ladder",
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck",
   "Monster Truck",
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight",
   "Trailer",
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer",
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer",
   "Trailer",
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "LSPD Cruiser",
   "SFPD Cruiser",
   "LVPD Cruiser",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer",
   "Luggage Trailer",
   "Stair Trailer",
   "Boxville",
   "Farm Plow",
   "Utility Trailer"
};

enum pInfo
{
    pScore,
    pMoney,
    pLevel,
    pVIP,
    pKMA,
    pRank,
    pKills,
    pDeaths,
    pMuted,
    pJailed,
    pFrozen,
    pMutedTimes,
    pJailedTimes,
    pFrozenTimes,
    pBanned,
    pBannedBy[24],
    pLogins,
    pCookies,
    pAdmin,
    pTutorial,
    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    pVWorld,
    pInterior,
    pBank
};

new
	Text:SpeedoName[MAX_PLAYERS],
	Text:SpeedoSpeed[MAX_PLAYERS],
	Text:SpeedoHealth[MAX_PLAYERS],
	Text:SpeedoGas[MAX_PLAYERS]
;

new
	Text:HealthText[MAX_PLAYERS],
	Text:ArmourText[MAX_PLAYERS]
;
//------------------------------------------------------------------------------
// Bank System
#define INVALID_BANK_ID     -1

new Float:BankPos[][3] = {
{0.0000, 0.0000, 0.0000}
};

stock IsPlayerAtBank(playerid)
{
	new bankid = INVALID_BANK_ID;
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		for (new i = 0; i < sizeof(BankPos); i++)
		{
		    if (BankPos[i][0] != 0.0000 && BankPos[i][1] != 0.0000 && BankPos[i][2] != 0.0000)
		    {
			    if (IsPlayerInRangeOfPoint(playerid, 1.0000, BankPos[i][0], BankPos[i][1], BankPos[i][2]))
			    {
					bankid = i;
			        break;
			    }
		    }
		}
	}
	return bankid;
}
//------------------------------------------------------------------------------
// Item System
#define ITEM_TYPE_NONE 		0
#define ITEM_TYPE_WEAPON 	1
#define ITEM_TYPE_AMMO  	2
#define ITEM_TYPE_FOOD      3

enum iInfo
{
	iName[64],
	iType,
	iModel,
};

new ItemInfo[][iInfo] = {
	{"없음", 			ITEM_TYPE_NONE, 	0},
	{"Desert-Eagle", 	ITEM_TYPE_WEAPON, 	348},
	{"M4A1",			ITEM_TYPE_WEAPON, 	356},
	{"35.4 Magnum", 	ITEM_TYPE_AMMO, 	2969},
	{"5.56x 45mm NATO", ITEM_TYPE_AMMO,     2969}
};

enum diInfo
{
    diOjnum,
	diItemID,
	diAmount,
	Float:diPos[3],
	diTime
};

new DroppedItem[300][diInfo];
//------------------------------------------------------------------------------
// Inventory System
enum piInfo
{
	piItemID,
	piItemAmount
};

new PlayerInventoryInfo[MAX_PLAYERS][15][piInfo];
new PlayerInvIndex[MAX_PLAYERS];
//------------------------------------------------------------------------------
// Vehicle System

enum vInfo
{
	vModel,
	vNumberplate[24],
	Float:vPos[4],
	vColor1,
	vColor2,
	vPaintjob,
	vInterior,
	vWorld,
	vLock,
	vOwner[MAX_PLAYER_NAME],
};

new SCAR[20];

new VehicleInfo[MAX_VEHICLES][vInfo];

stock GetVehicleModelPrice(modelid)
{
	new query[512], price = 0;
	format(query, 512, "SELECT price FROM vehpricedata WHERE modelid = %d", modelid);
	mysql_query(query);
	mysql_store_result();
	price = mysql_fetch_int();
	mysql_free_result();
	return price;
}

stock SetVehicleModelPrice(modelid, price)
{
	new query[512];
	format(query, 512, "UPDATE vehpricedata SET price = %d WHERE modelid = %d", price, modelid);
	mysql_query(query);
	return 1;
}

public MySQL_CreateVehicle(modelid, Float:X, Float:Y, Float:Z, Float:angle, color1, color2, paintjobid, interiorid, worldid)
{
    new
		query[512],
		numberplate[24],
		vehicleid = 0
	;
    while (strlen(numberplate) == 0)
    {
    
	    new num = random(9999);
	    new tmp[24];
	    format(tmp, 24, "LS%04d", num);
	    format(query, 512, "SELECT * FROM vehicledata WHERE numberplate = '%s'", tmp);
		mysql_query(query);
		mysql_store_result();
		new numrows = mysql_num_rows();
		mysql_free_result();
		if (numrows <= 0)
		{
		    strmid(numberplate, tmp, 0, 24, 24);
		}
    }
    if (strlen(numberplate) > 0)
    {
		vehicleid = CreateVehicle(modelid, X, Y, Z, angle, color1, color2, -1);
		if (vehicleid > 0)
		{
			VehicleInfo[vehicleid][vModel] = modelid;
			strmid(VehicleInfo[vehicleid][vNumberplate], numberplate, 0, 24, 24);
			VehicleInfo[vehicleid][vPos][0] = X;
			VehicleInfo[vehicleid][vPos][1] = Y;
			VehicleInfo[vehicleid][vPos][2] = Z;
			VehicleInfo[vehicleid][vPos][3] = angle;
			VehicleInfo[vehicleid][vColor1] = color1;
			VehicleInfo[vehicleid][vColor2] = color2;
			VehicleInfo[vehicleid][vPaintjob] = paintjobid;
			VehicleInfo[vehicleid][vInterior] = interiorid;
			VehicleInfo[vehicleid][vWorld] = worldid;
			strmid(VehicleInfo[vehicleid][vOwner], "None", 0, 24, 24);
		
		    format(
				query, 512,
				"INSERT INTO vehicledata (model, numberplate, X, Y, Z, angle, color1, color2, paintjob, interior, world, door, owner) VALUES (%d, '%s', %0.4f, %0.4f, %0.4f, %0.4f, %d, %d, 0, %d, %d, 0, 'None')",
				modelid, numberplate, X, Y, Z, angle, color1, color2, paintjobid, interiorid, worldid
			);
			mysql_query(query);
		}
	}
	return vehicleid;
}

public MySQL_SaveVehicle(vehicleid)
{
    new query[512];
    if (GetVehicleModel(vehicleid) > 0 && VehicleInfo[vehicleid][vModel] > 0 && strlen(VehicleInfo[vehicleid][vNumberplate]) > 0 && vehicleid != SCAR[0])
    {
		format(
			query, 512,
			"UPDATE vehicledata SET X = %0.4f, Y = %0.4f, Z = %0.4f, angle = %0.4f, color1 = %d, color2 = %d, paintjob = %d, interior = %d, world = %d, door = %d, owner = '%s' WHERE numberplate = '%s'",
			VehicleInfo[vehicleid][vPos][0], VehicleInfo[vehicleid][vPos][1], VehicleInfo[vehicleid][vPos][2], VehicleInfo[vehicleid][vPos][3],
			VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2], VehicleInfo[vehicleid][vPaintjob],
			VehicleInfo[vehicleid][vInterior], VehicleInfo[vehicleid][vWorld],
			VehicleInfo[vehicleid][vLock], VehicleInfo[vehicleid][vOwner],
			VehicleInfo[vehicleid][vNumberplate]
		);
		mysql_query(query);
	}
	return 1;
}

public MySQL_LoadVehicle(numberplate[])
{
	new
		query[512],
		savestring[256],
		vehicleid = 0
	;
	format(query, 512, "SELECT * FROM vehicledata WHERE numberplate = '%s' LIMIT 1", numberplate);
	mysql_query(query);
	mysql_store_result();
    while (mysql_fetch_row_format(query, "|"))
    {
        new
			modelid,
			Float:X, Float:Y, Float:Z, Float:angle,
			color1, color2, paintjobid,
			interiorid, worldid,
			lock, owner[24]
		;
        mysql_fetch_field_row(savestring, "model"); modelid = strval(savestring);
		mysql_fetch_field_row(savestring, "X"); X = floatstr(savestring);
        mysql_fetch_field_row(savestring, "Y"); Y = floatstr(savestring);
        mysql_fetch_field_row(savestring, "Z"); Z = floatstr(savestring);
        mysql_fetch_field_row(savestring, "angle"); angle = floatstr(savestring);
        mysql_fetch_field_row(savestring, "color1"); color1 = strval(savestring);
        mysql_fetch_field_row(savestring, "color2"); color2 = strval(savestring);
        mysql_fetch_field_row(savestring, "paintjob"); paintjobid = strval(savestring);
        mysql_fetch_field_row(savestring, "interior"); interiorid = strval(savestring);
        mysql_fetch_field_row(savestring, "world"); worldid = strval(savestring);
		mysql_fetch_field_row(savestring, "door"); lock = strval(savestring);
		mysql_fetch_field_row(savestring, "owner"); strmid(owner, savestring, 0, 24, 24);

        vehicleid = CreateVehicle(modelid, 0.0000, 0.0000, 0.0000, 0.0000, 0, 0, -1);
		SetVehicleNumberPlate(vehicleid, numberplate);
		SetVehiclePos(vehicleid, X, Y, Z);
		SetVehicleZAngle(vehicleid, angle);
		ChangeVehicleColor(vehicleid, color1, color2);
		ChangeVehiclePaintjob(vehicleid, paintjobid);
		LinkVehicleToInterior(vehicleid, interiorid);
		SetVehicleVirtualWorld(vehicleid, worldid);
		SetVehicleParamsEx(vehicleid, 0, 0, 0, lock, 0, 0, 0);

		VehicleInfo[vehicleid][vModel] = modelid;
		strmid(VehicleInfo[vehicleid][vNumberplate], numberplate, 0, 24, 24);
		VehicleInfo[vehicleid][vPos][0] = X;
		VehicleInfo[vehicleid][vPos][1] = Y;
		VehicleInfo[vehicleid][vPos][2] = Z;
		VehicleInfo[vehicleid][vPos][3] = angle;
		VehicleInfo[vehicleid][vColor1] = color1;
		VehicleInfo[vehicleid][vColor2] = color2;
		VehicleInfo[vehicleid][vPaintjob] = paintjobid;
		VehicleInfo[vehicleid][vInterior] = interiorid;
		VehicleInfo[vehicleid][vWorld] = worldid;
		strmid(VehicleInfo[vehicleid][vOwner], owner, 0, 24, 24);
    }
    mysql_free_result();
    return vehicleid;
}

public MySQL_LoadVehicles()
{
	new
		query[512],
		savestring[256],
		vehs = 0
	;
    new
		modelid, numberplate[24],
		Float:X, Float:Y, Float:Z, Float:angle,
		color1, color2, paintjob,
		interiorid, worldid
	;
	format(query, 512, "SELECT * FROM vehicledata");
	mysql_query(query);
	mysql_store_result();
	while (mysql_retrieve_row())
	{
	    mysql_fetch_field_row(savestring, "model"); modelid = strval(savestring);
	    mysql_fetch_field_row(savestring, "numberplate"); strmid(numberplate, savestring, 0, 24, 24);
	    mysql_fetch_field_row(savestring, "X"); X = floatstr(savestring);
	    mysql_fetch_field_row(savestring, "Y"); Y = floatstr(savestring);
	    mysql_fetch_field_row(savestring, "Z"); Z = floatstr(savestring);
	    mysql_fetch_field_row(savestring, "angle"); angle = floatstr(savestring);
	    mysql_fetch_field_row(savestring, "color1"); color1 = strval(savestring);
	    mysql_fetch_field_row(savestring, "color2"); color2 = strval(savestring);
	    mysql_fetch_field_row(savestring, "paintjob"); paintjob = strval(savestring);
	    mysql_fetch_field_row(savestring, "interior"); interiorid = strval(savestring);
	    mysql_fetch_field_row(savestring, "world"); worldid = strval(savestring);

	    new vehicleid = CreateVehicle(modelid, 0.0000, 0.0000, 0.0000, 0.0000, 0, 0, -1);
	    SetVehiclePos(vehicleid, X, Y, Z);
	    SetVehicleZAngle(vehicleid, angle);
		ChangeVehicleColor(vehicleid, color1, color2);
		ChangeVehiclePaintjob(vehicleid, paintjob);
		LinkVehicleToInterior(vehicleid, interiorid);
		SetVehicleVirtualWorld(vehicleid, worldid);

		VehicleInfo[vehicleid][vModel] = modelid;
		strmid(VehicleInfo[vehicleid][vNumberplate], numberplate, 0, 24, 24);
		VehicleInfo[vehicleid][vPos][0] = X;
		VehicleInfo[vehicleid][vPos][1] = Y;
		VehicleInfo[vehicleid][vPos][2] = Z;
		VehicleInfo[vehicleid][vPos][3] = angle;
        VehicleInfo[vehicleid][vColor1] = color1;
        VehicleInfo[vehicleid][vColor2] = color2;
        VehicleInfo[vehicleid][vPaintjob] = paintjob;
        VehicleInfo[vehicleid][vInterior] = interiorid;
        VehicleInfo[vehicleid][vWorld] = worldid;
        
        vehs ++;
	}
	mysql_free_result();
	return vehs;
}

public MySQL_RemoveVehicle(numberplate[])
{
	new vehicleid = 0;
	for (new i = 1; i <= MAX_VEHICLES; i++)
	{
	    if (GetVehicleModel(i) > 0 && VehicleInfo[i][vModel] > 0)
	    {
	        if (strlen(VehicleInfo[i][vNumberplate]) > 0 && strcmp(numberplate, VehicleInfo[i][vNumberplate], true) == 0)
	        {
	            vehicleid = i;
	            break;
	        }
	    }
	}
	if (vehicleid > 0)
	{
		VehicleInfo[vehicleid][vModel] = 0;
		VehicleInfo[vehicleid][vPos][0] = 0.0000;
		VehicleInfo[vehicleid][vPos][1] = 0.0000;
		VehicleInfo[vehicleid][vPos][2] = 0.0000;
		VehicleInfo[vehicleid][vPos][3] = 0.0000;
		VehicleInfo[vehicleid][vColor1] = 0;
		VehicleInfo[vehicleid][vColor2] = 0;
		VehicleInfo[vehicleid][vPaintjob] = 0;
		VehicleInfo[vehicleid][vInterior] = 0;
		VehicleInfo[vehicleid][vWorld] = 0;
	}
	
	new query[512];
	format(query, 512, "DELETE FROM vehicledata WHERE numberplate = '%s'", numberplate);
	mysql_query(query);
	return 1;
}
//------------------------------------------------------------------------------
// Factions

#define MAX_FACTIONS 128

#define INVALID_FACTION_ID      	0

#define FACTION_TYPE_NONE   		0
#define FACTION_TYPE_POLICE 		1
#define FACTION_TYPE_HOSPITAL   	2
#define FACTION_TYPE_GANG       	3

#define MAX_FACTION_RANKS   		20

#define INVALID_FACTION_RANK_ID     0

enum fInfo
{
	fName[64],
	fType,
	Float:fSpawnPos[3],
	fSpawnInt,
	fSpawnWorld,
};

new FactionInfo[MAX_FACTIONS + 1][fInfo];
new FactionRankInfo[MAX_FACTIONS + 1][MAX_FACTION_RANKS + 1][64];
//------------------------------------------------------------------------------
public CreateFaction(type, name[])
{
	new factionid = 0;
	for (new i = 1; i <= MAX_FACTIONS; i++)
	{
	    if (FactionInfo[i][fType] == 0)
	    {
			factionid = i;
	        break;
	    }
	}
	if (factionid > 0)
	{
	    new query[512];
		format(query, 512, "INSERT INTO factiondata (id, name, type, spawn_X, spawn_Y, spawn_Z, spawn_interior, spawn_world) VALUES (%d, '%s', %d, 0.0000, 0.0000, 0.0000, 0, 0)", factionid, name, type);
	    mysql_query(query);
	    
	    strmid(FactionInfo[factionid][fName], name, 0, 64, 64);
		FactionInfo[factionid][fType] = type;
		FactionInfo[factionid][fSpawnPos][0] = 0.0000;
		FactionInfo[factionid][fSpawnPos][1] = 0.0000;
		FactionInfo[factionid][fSpawnPos][2] = 0.0000;
		FactionInfo[factionid][fSpawnInt] = 0;
		FactionInfo[factionid][fSpawnWorld] = 0;
		
		for (new r = 1; r <= MAX_FACTION_RANKS; r++)
		{
		    format(query, 512, "UPDATE factiondata SET rank_%02d = 'None' WHERE id = %d", r, factionid);
			mysql_query(query);
		    strmid(FactionRankInfo[factionid][r], "None", 0, 64, 64);
		}
	}
	return factionid;
}

public SaveFaction(factionid)
{
	new query[512];
	format(query, 512, "UPDATE factiondata SET name = '%s', type = %d, spawn_X = %0.4f, spawn_Y = %0.4f, spawn_Z = %0.4f, spawn_interior = %d, spawn_world = %d WHERE id = %d",
	FactionInfo[factionid][fName], FactionInfo[factionid][fType], FactionInfo[factionid][fSpawnPos][0], FactionInfo[factionid][fSpawnPos][1], FactionInfo[factionid][fSpawnPos][2], FactionInfo[factionid][fSpawnInt], FactionInfo[factionid][fSpawnWorld], factionid);
	mysql_query(query);
	for (new r = 1; r <= MAX_FACTION_RANKS; r++)
	{
	    format(query, 512, "UPDATE factiondata SET rank_%02d = '%s' WHERE id = %d", r, FactionRankInfo[factionid][r], factionid);
		mysql_query(query);
	}
	return 1;
}

public LoadFactions()
{
	new
		savestring[256],
		tmp[256],
		factionid = 0,
		facs = 0
	;
	mysql_query("SELECT * FROM factiondata");
	mysql_store_result();
	while (mysql_retrieve_row())
    {
        mysql_fetch_field_row(savestring, "id"); factionid = strval(savestring);
		mysql_fetch_field_row(savestring, "name"); strmid(FactionInfo[factionid][fName], savestring, 0, 64, 64);
		mysql_fetch_field_row(savestring, "type"); FactionInfo[factionid][fType] = strval(savestring);
		mysql_fetch_field_row(savestring, "spawn_X"); FactionInfo[factionid][fSpawnPos][0] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "spawn_Y"); FactionInfo[factionid][fSpawnPos][1] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "spawn_Z"); FactionInfo[factionid][fSpawnPos][2] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "spawn_interior"); FactionInfo[factionid][fSpawnInt] = strval(savestring);
        mysql_fetch_field_row(savestring, "spawn_world"); FactionInfo[factionid][fSpawnWorld] = strval(savestring);
        for (new r = 1; r <= MAX_FACTION_RANKS; r++)
        {
            format(tmp, 256, "rank_%02d", r);
            mysql_fetch_field_row(savestring, tmp); strmid(FactionRankInfo[factionid][r], savestring, 0, 64, 64);
        }
        facs ++;
    }
	mysql_free_result();
	return facs;
}

public RemoveFaction(factionid)
{
	new query[512];
	format(query, 512, "DELETE FROM factiondata WHERE id = %d", factionid);
	mysql_query(query);

	strmid(FactionInfo[factionid][fName], "", 0, 64, 64);
	FactionInfo[factionid][fType] = 0;
	FactionInfo[factionid][fSpawnPos][0] = 0.0000;
	FactionInfo[factionid][fSpawnPos][1] = 0.0000;
	FactionInfo[factionid][fSpawnPos][2] = 0.0000;
	FactionInfo[factionid][fSpawnInt] = 0;
	FactionInfo[factionid][fSpawnWorld] = 0;
    for (new r = 1; r <= MAX_FACTION_RANKS; r++)
    {
		strmid(FactionRankInfo[factionid][r], "", 0, 64, 64);
    }
	
	return 1;
}
//------------------------------------------------------------------------------
#define MAX_BUILDINGS 128

#define BUILDING_TYPE_NONE 			0
#define BUILDING_TYPE_HOME 			1
#define BUILDING_TYPE_BUSINESS 		2
#define BUILDING_TYPE_GOVERNMENT 	3

enum bInfo
{
	bName[64],
	bType,
	bPrice,
	Float:bEnt[3],
	Float:bEx[3],
	bInt,
	bLocked,
};

new BuildingInfo[MAX_BUILDINGS][bInfo];

forward CreateBuilding(name[], type);
forward RemoveBuilding(buildingid);
forward LoadBuildings();
forward SaveBuilding(buildingid);

public CreateBuilding(name[], type)
{
	new
		query[512],
		buildingid = 0
	;
	format(query, 512, "INSERT INTO buildingdata (name, type, price, ent_X, ent_Y, ent_Z, ex_X, ex_Y, ex_Z, interior, locked) VALUES ('%s', %d, 0, 0, 0, 0, 0, 0, 0, 0, 0)", name, type);
	mysql_query(query);
	buildingid = mysql_insert_id();
	return buildingid;
}

public RemoveBuilding(buildingid)
{
	new query[512];
	format(query, 512, "DELETE FROM buildingdata WHERE id = %d", buildingid);
	mysql_query(query);
	strmid(BuildingInfo[buildingid][bName], "", 0, 64, 64);
	BuildingInfo[buildingid][bType] = 0;
	BuildingInfo[buildingid][bPrice] = 0;
	BuildingInfo[buildingid][bEnt][0] = 0.0000;
	BuildingInfo[buildingid][bEnt][1] = 0.0000;
	BuildingInfo[buildingid][bEnt][2] = 0.0000;
	BuildingInfo[buildingid][bEx][0] = 0.0000;
	BuildingInfo[buildingid][bEx][1] = 0.0000;
	BuildingInfo[buildingid][bEx][2] = 0.0000;
	BuildingInfo[buildingid][bInt] = 0;
	BuildingInfo[buildingid][bLocked] = 0;
	return 1;
}

public LoadBuildings()
{
	new
		savestring[256],
		buildingid = 0,
		buildings = 0
	;
	mysql_query("SELECT * FROM buildingdata");
	mysql_store_result();
	while (mysql_retrieve_row())
    {
        mysql_fetch_field_row(savestring, "id"); buildingid = strval(savestring);
		mysql_fetch_field_row(savestring, "name"); strmid(BuildingInfo[buildingid][bName], savestring, 0, 64, 64);
		mysql_fetch_field_row(savestring, "type"); BuildingInfo[buildingid][bType] = strval(savestring);
		mysql_fetch_field_row(savestring, "price"); BuildingInfo[buildingid][bPrice] = strval(savestring);
		mysql_fetch_field_row(savestring, "ent_X"); BuildingInfo[buildingid][bEnt][0] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "ent_Y"); BuildingInfo[buildingid][bEnt][1] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "ent_Z"); BuildingInfo[buildingid][bEnt][2] = floatstr(savestring);
		mysql_fetch_field_row(savestring, "ex_X"); BuildingInfo[buildingid][bEx][0] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "ex_Y"); BuildingInfo[buildingid][bEx][1] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "ex_Z"); BuildingInfo[buildingid][bEx][2] = floatstr(savestring);
        mysql_fetch_field_row(savestring, "interior"); BuildingInfo[buildingid][bInt] = strval(savestring);
        mysql_fetch_field_row(savestring, "locked"); BuildingInfo[buildingid][bLocked] = strval(savestring);
        buildings ++;
    }
	mysql_free_result();
	return buildings;
}

public SaveBuilding(buildingid)
{
	new query[512];
	format(
		query,
		512,
		"UPDATE buildingdata SET name = '%s', type = %d, price = %d, ent_X = %0.4f, ent_Y = %0.4f, ent_Z = %0.4f, ex_X = %0.4f, ex_Y = %0.4f, ex_Z = %0.4f, interior = %d, locked = %d WHERE id = %d",
		BuildingInfo[buildingid][bName], BuildingInfo[buildingid][bType], BuildingInfo[buildingid][bPrice],
		BuildingInfo[buildingid][bEnt][0], BuildingInfo[buildingid][bEnt][1], BuildingInfo[buildingid][bEnt][2],
		BuildingInfo[buildingid][bEx][0], BuildingInfo[buildingid][bEx][1], BuildingInfo[buildingid][bEx][2],
		BuildingInfo[buildingid][bInt], BuildingInfo[buildingid][bLocked], buildingid
	);
	mysql_query(query);
	return 1;
}
//------------------------------------------------------------------------------
new PlayerInfo[MAX_PLAYERS][pInfo];
new MoneyGiven[MAX_PLAYERS];
new IsRegistered[MAX_PLAYERS];
new Logged[MAX_PLAYERS];
new JustLogged[MAX_PLAYERS];
new Text:Textdraw1;
new CheckIP[MAX_PLAYERS][16];
//new Vint[MAX_VEHICLES];
new AcceptAdmin[MAX_PLAYERS];
new AdminChannel[MAX_PLAYERS];
new	g_VehTime[MAX_PLAYERS];
new bool:WeaponHack[MAX_PLAYERS][WEAPON_HACK];
new GWeapon[M_P];
new noooc = 0;
new gOoc[M_P];
new bool:Logined[MAX_PLAYERS] = { false, ... };
new bool:AutoSave = false;

main()
{
}

//============================================================================//
//                                  Publics                                   //
//============================================================================//
public OnGameModeInit()
{
    ManualVehicleEngineAndLights();
	
	
	new stuff[128];
	AutoSave = false;

	format(stuff, 128, "hostname %s", SERVER_NAME);
	SendRconCommand(stuff);
	
	format(stuff, 128, "mapname %s", SERVER_MAP);
	SendRconCommand(stuff);

	format(stuff, 128, "worldtime %s", SERVER_WEBSITE);
	SendRconCommand(stuff);
	
	SetGameModeText("TEST");

    //================================================================//
    //                              MySQL part                        //
    //================================================================//
    mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
	//================================================================//
    print(" ");
	if (mysql_ping() == 1)
	{
	    printf("=====================");
	    printf("MySQL Connected!");
	    printf("UserData Loaded!");
	    printf("BanData Loaded!");
	    printf("Kickdata Loaded!");
	    printf("Spawndata Loaded!");
	    printf("hackdata Loaded!");
	    printf("=====================");
	}
	else
	{
	    print("MySQL Disconnect");
		GameModeExit();
		return 1;
	}
	print(" ");
	//================================================================//
    mysql_debug(1);
    mysql_set_charset("euckr");
    
    new query[512];
    //================================================================//
    mysql_query("CREATE TABLE IF NOT EXISTS playerdata(user VARCHAR(24), password VARCHAR(40), admin INT(10),\
	score INT(20), money INT(20), level INT(20), vip INT(20), tutorial INT(20), kma INT(20), rank INT(20), kills INT(20), deaths INT(20))");
	//================================================================//
	mysql_query("ALTER TABLE playerdata ADD IF NOT EXISTS (\
	muted INT(20) NOT NULL,\
	jailed INT(20) NOT NULL,\
	frozen INT(20) NOT NULL,\
	mutedtimes INT(20) NOT NULL,\
	jailedtimes INT(20) NOT NULL,\
	frozentimes INT(20) NOT NULL,\
	banned INT(20) NOT NULL,\
	bannedby VARCHAR(24) NOT NULL,\
	logins INT(20) NOT NULL,\
	IP VARCHAR(15) NOT NULL)");
	//================================================================//
    mysql_query("ALTER TABLE playerdata ADD IF NOT EXISTS (posX Float(20), posY Float(20), posZ Float(20), vworld INT(10), interior INT(10), bank INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS itemdata(user VARCHAR(24))");
	for (new a = 1; a <= 15; a++)
	{
	    format(query, 256, "ALTER TABLE itemdata ADD IF NOT EXISTS (itemid_%d INT(10), amount_%d INT(10))", a, a);
		mysql_query(query);
	}
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS bandata(admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS kickdata(year INT(20), month INT(20), day INT(20), hour INT(20), minute INT(20), second INT(20), admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), kicked INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS spawndata(year INT(20), month INT(20), day INT(20), hour INT(20), minute INT(20), second INT(20), admin VARCHAR(20), player VARCHAR(20), IP VARCHAR(16), Spawned INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS hackdata(player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS vehicledata (model INT(10), numberplate VARCHAR(24), X FLOAT(10), Y FLOAT(10), Z FLOAT(10), angle FLOAT(10), color1 INT(10), color2 INT(10), paintjob INT(10), interior INT(10), world INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS vehpricedata (modelid INT(10), price INT(10)");
	
	mysql_query("CREATE TABLE IF NOT EXISTS buildingdata (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(64), type INT(10), price INT(10), ent_X FLOAT(10), ent_Y FLOAT(10), ent_Z FLOAT(10), ex_X FLOAT(10), ex_Y FLOAT(10), ex_Z FLOAT(10), interior INT(10), locked INT(10))");
	
	mysql_query("SELECT * FROM vehpricedata");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	if (rows == 0)
	{
		for (new model = 400; model <= 611; model++)
		{
		    format(query, 512, "INSERT INTO vehpricedata (modelid, price) VALUES (%d, 0)", model);
		    mysql_query(query);
		}
	}
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS factiondata (id INT(10), name VARCHAR(64), type INT(10), spawn_X FLOAT(10), spawn_Y FLOAT(10), spawn_Z FLOAT(10), spawn_interior INT(10), spawn_world INT(10))");
	for (new r = 1; r <= MAX_FACTION_RANKS; r++)
	{
		format(query, 512, "ALTER TABLE factiondata ADD IF NOT EXISTS (rank_%02d VARCHAR(64))", r);
		mysql_query(query);
	}
	// 차량 로드
	new vehs = MySQL_LoadVehicles();
	if (vehs == 0)
	{
		print("[vehicle] No vehicle loaded");
	}
	else
	{
	    printf("[vehicle] %d vehicles loaded", vehs);
	}
	// 팩션 로드
	new facs = LoadFactions();
	if (facs == 0)
	{
		print("[faction] No faction loaded");
	}
	else
	{
	    printf("[faction] %d factions loaded", facs);
	}
	// 은행 생성
	new banks = 0;
	for (new i = 0; i < sizeof(BankPos); i++)
	{
	    if (BankPos[i][0] != 0.0000 && BankPos[i][1] != 0.0000 && BankPos[i][2] != 0.0000)
	    {
			AddStaticPickup(1318, 1, BankPos[i][0], BankPos[i][1], BankPos[i][2]);
			banks ++;
		}
	}
	printf("[bank] %d banks created", banks);
	//================================================================//
    //                              Timer part                        //
    //================================================================//
	SetTimer("AutoSaveTimer", 30000, 1);
	//================================================================//
	SCAR[0] = CreateVehicle(400, 122.1120, -265.3829, 1.6705, 354.6739, 0, 0, 0);
    return 1;
}

public OnGameModeExit()
{
	mysql_close();
	return 1;
}

public ResetPlayerVariable(playerid)
{
	gOoc[playerid] = 0;
	return 1;
}

//================================================================//
//                              Tutorial                          //
//================================================================//
/*public Tuto1(playerid)
{
	SendClientMessage(playerid, -1, "아포칼립스 롤 플레잉에 오신걸 환영합니다."); // 5초
	SetTimerEx("Tuto2", 5000, false, "i", playerid);
	return 1;
}

public Tuto2(playerid)
{
    SendClientMessage(playerid, -1, "아포칼립스 롤 플레잉은 다른 역할연기와 많이 차이점을 보이기 때문에"); // 5초 이런싱으로
  	SendClientMessage(playerid, -1, "튜토리얼을 필수적으로 진행해야 합니다.");
  	SetTimerEx("Tuto3", 5000, false, "i", playerid);
	return 1;
}

public Tuto3(playerid)
{
    SendClientMessage(playerid, -1, "가장 먼저 생존을 위한 파밍에 대해 튜토리얼을 시작합니다.");
    SetTimerEx("Tuto4", 5000, false, "i", playerid);
	return 1;
}

public Tuto4(playerid)
{
    TutorialEnd(playerid);
	return 1;
}*/

public OnPlayerRequestSpawn(playerid)
{
    //================================================================//
    //                              MySQL part                        //
    //================================================================//
    if(!Logged[playerid])
    {
        if(!IsRegistered[playerid])
        {
            ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "-","회원가입", "가입", "취소");
            return 0;
        }
        if(IsRegistered[playerid] == 1)
        {
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "-", "로그인", "로그인", "취소");
		    return 0;
        }
    }
    return 1;
}


public OnPlayerSpawn(playerid)
{
    //================================================================//
    //                              MySQL part                        //
    //================================================================//
    if(MoneyGiven[playerid] != -1)
    {
        GivePlayerMoney(playerid, MoneyGiven[playerid]);
        MoneyGiven[playerid] = -1;
    }
    if(JustLogged[playerid] == 1)
    {
		JustLogged[playerid] = 0;
	}
	if (PlayerInfo[playerid][pTutorial] >= 1)
	{
	    SetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosX]);
	    return 1;
	}
	else
	{
	   	SetPlayerPos(playerid, 1475.4899,-1741.7511,13.5469);
		SetPlayerVirtualWorld(playerid, 0);
	    GivePlayerWeapon(playerid, 5, 99999);
	    SetTimerEx("Tuto1", 5000, false, "i", playerid);
		return 1;
	}
}

public OnPlayerConnect(playerid)
{
    new string[256];
    SetPlayerColor(playerid, 0xFFFFFFAA);
	if(!IsPlayerNPC(playerid))
	{
	    format(string,sizeof(string),"! %s (%d)connected.", PlayerName(playerid), playerid);
	    SendClientMessageToAll(C_WHITE, string);
    }
    for(new w = 1; w < WEAPON_HACK; w++)
	{
		WeaponHack[playerid][w] = false;
	}
	AcceptAdmin[playerid] = INVALID_PLAYER_ID;
	AdminChannel[playerid] = 0;
	PlayAudioStreamForPlayer(playerid, "http://dl.bgms.kr/download/yzYhl/mp3/18%20My%20Alias"); 
    SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
    MySQL_BanCheck(playerid);
    RemoveUnderScore(playerid);
    TextDrawHideForPlayer(playerid, Textdraw1);
    Logined[playerid] = false;
    PlayerInvIndex[playerid] = -1;
    SpeedoName[playerid] = TextDrawCreate(53.799999, 436, "Vehicle: ~g~");
	TextDrawLetterSize(SpeedoName[playerid], 0.2, 0.999);
	TextDrawAlignment(SpeedoName[playerid], 2);
	TextDrawColor(SpeedoName[playerid], -1);
	TextDrawSetOutline(SpeedoName[playerid], 1);
	TextDrawFont(SpeedoName[playerid], 1);
	TextDrawUseBox(SpeedoName[playerid], 1);
	TextDrawBoxColor(SpeedoName[playerid], 0x00000088);

	SpeedoSpeed[playerid] = TextDrawCreate(128.799999, 436, "Speed: ~y~0 ~g~KM/H");
	TextDrawLetterSize(SpeedoSpeed[playerid], 0.2, 0.999);
	TextDrawAlignment(SpeedoSpeed[playerid], 2);
	TextDrawColor(SpeedoSpeed[playerid], -1);
	TextDrawSetOutline(SpeedoSpeed[playerid], 1);
	TextDrawFont(SpeedoSpeed[playerid], 1);

	SpeedoHealth[playerid] = TextDrawCreate(175.799999, 436, "Vehicle Health: ~g~0");
	TextDrawBackgroundColor(SpeedoHealth[playerid], 255);
	TextDrawFont(SpeedoHealth[playerid], 1);
	TextDrawLetterSize(SpeedoHealth[playerid], 0.2, 0.999);
	TextDrawColor(SpeedoHealth[playerid], -1);
	TextDrawSetOutline(SpeedoHealth[playerid], 1);
	TextDrawSetProportional(SpeedoHealth[playerid], 1);

	SpeedoGas[playerid] = TextDrawCreate(330.799999, 436, "Vehicle Gas: ~g~0");
	TextDrawBackgroundColor(SpeedoGas[playerid], 255);
	TextDrawFont(SpeedoGas[playerid], 1);
	TextDrawLetterSize(SpeedoGas[playerid], 0.2, 0.999);
	TextDrawColor(SpeedoGas[playerid], -1);
	TextDrawSetOutline(SpeedoGas[playerid], 1);
	TextDrawSetProportional(SpeedoGas[playerid], 1);

  	HealthText[playerid] = TextDrawCreate(502.000000,112.000000,"~r~HEALTH : ~w~1000");
	TextDrawAlignment(HealthText[playerid],0);
	TextDrawBackgroundColor(HealthText[playerid],0x000000ff);
	TextDrawFont(HealthText[playerid],2);
	TextDrawLetterSize(HealthText[playerid],0.420000,1.830000);
	TextDrawColor(HealthText[playerid],0xffffffff);
	TextDrawSetOutline(HealthText[playerid],1);
	TextDrawSetProportional(HealthText[playerid],1);
	TextDrawSetShadow(HealthText[playerid],1);

	ArmourText[playerid] = TextDrawCreate(502.000000,98.000000,"~b~~h~~h~~h~ARMOUR : ~w~1000");
	TextDrawAlignment(ArmourText[playerid],0);
	TextDrawBackgroundColor(ArmourText[playerid],0x000000ff);
	TextDrawFont(ArmourText[playerid],2);
	TextDrawLetterSize(ArmourText[playerid],0.420000,1.830000);
	TextDrawColor(ArmourText[playerid],0xffffffff);
	TextDrawSetOutline(ArmourText[playerid],1);
	TextDrawSetProportional(ArmourText[playerid],1);
	TextDrawSetShadow(ArmourText[playerid],1);

    //================================================================//
    //                              MySQL part                        //
    //================================================================//
    MoneyGiven[playerid] = -1;
    JustLogged[playerid] = 0;
	GetPlayerIp(playerid,CheckIP[playerid],16);
    new query[300], pname[24];
    GetPlayerName(playerid, pname, 24);
    format(query, sizeof(query), "SELECT IP FROM `playerdata` WHERE user = '%s' LIMIT 1", pname);
    mysql_query(query);
    mysql_store_result();
    new rows = mysql_num_rows();
    if (Logined[playerid] == false)
	{
	    if (!rows)
	    {
	        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "-","회원가입", "가입", "취소");
	    }
	    if (rows == 1)
	    {
	        new IP[2][15];
	        mysql_fetch_field_row(IP[0], "IP");
	        GetPlayerIp(playerid, IP[1], 15);
	        if(strlen(IP[0]) != 0 && !strcmp(IP[0], IP[1], true))
	        {
	            MySQL_Login(playerid);
	        }
	        else if(!strlen(IP[0]) || strcmp(IP[0], IP[1], true))
	        {
	            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "-","로그인", "로그인", "취소");
	            IsRegistered[playerid] = 1;
	        }
	    }
	}
	SpawnPlayer(playerid);
    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
    new string[256];
	if(!IsPlayerNPC(playerid))
	{
	    switch(reason)
    	{
		    case 0: format(string,sizeof(string),"! %s(%d) disconnected. (Ping)", PlayerName(playerid), playerid);
		    case 1: format(string,sizeof(string),"! %s(%d) disconnected.", PlayerName(playerid), playerid);
		    case 2: format(string,sizeof(string),"! %s(%d) disconnected (Kick/Ban)", PlayerName(playerid), playerid);
		}
		SendClientMessageToAll(C_WHITE,string);
    }
    TextDrawDestroy(SpeedoName[playerid]);
	TextDrawDestroy(SpeedoSpeed[playerid]);
	TextDrawDestroy(SpeedoHealth[playerid]);
	TextDrawDestroy(SpeedoGas[playerid]);

	TextDrawDestroy(HealthText[playerid]);
	TextDrawDestroy(ArmourText[playerid]);
	for(new i = 0; i < M_P; i++)
	{
		if (AcceptAdmin[i] != INVALID_PLAYER_ID)
		{
			if (AcceptAdmin[i] == playerid)
			{
			    AdminChannel[i] = 0;
			    AcceptAdmin[i] = INVALID_PLAYER_ID;
			    SendClientMessage(playerid,C_WHITE, "오류가 발생했습니다. 관리자 요청을 다시 시도해주세요.");
			}
		}
	}
	if (AcceptAdmin[playerid] != INVALID_PLAYER_ID)
	{
		SendClientMessage(AcceptAdmin[playerid], -1, "담당 중인 플레이어가 접속을 종료했습니다.");
		AcceptAdmin[playerid] = INVALID_PLAYER_ID;
		AdminChannel[playerid] = 0;
	}
	if (Logged[playerid] == 1) SavePlayer(playerid);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    return 1;
}

public OnPlayerText(playerid, text[])
{
    return 1;
}

public OnPlayerChangeVehicle(playerid, vehicleid)
{
    new string[256];
	new PlayerIP[256];
	GetPlayerIp(playerid,PlayerIP,sizeof(PlayerIP));
	#pragma unused vehicleid
	if((GetTickCount() - g_VehTime[ playerid ]) < 500)
	{

	    format(string,sizeof(string),"[ IP : %s 이름 : %s 번호 : %d ] 가 차량 클레오 사용으로 영구 밴 처리 됩니다.",PlayerIP, PlayerName(playerid), playerid);
		SendAdminMessage(C_WHITE,string);
	    SendClientMessage(playerid, C_RED, "차량 클레오를 사용 하여 서비스 블럭 처리됩니다.");
		new bquery[200], IP[16];
		format(bquery, sizeof(bquery),"INSERT INTO hackdata(player, reason, IP, banned) VALUES('%s', '차량클레오','%s', 1)", PlayerName(playerid), IP);
		mysql_query(bquery);
		format(string, sizeof(string),"%s 가 서비스 블럭처리 되었습니다. [사유: 차량클레오]", PlayerName(playerid));
		SendClientMessageToAll(C_RED, string);
		mysql_free_result();
		Kick(playerid);
	}
	g_VehTime[playerid] = GetTickCount();
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new string[128];
	if (newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
		if (vehicleid == SCAR[0])
		{
		    format(string, sizeof(string), "차량 이름 : %s\n차량 가격 : %d\n 구매 하시겠습니까?", VehicleName[GetVehicleModel(vehicleid) - 400], 0);
			ShowPlayerDialog(playerid, DIALOG_CAR_BUY, DIALOG_STYLE_MSGBOX, "CAR BUY", string, "예", "아니요");
		}
	}
	new getvname[50];
    if (oldstate-1 && newstate)
	{
		TextDrawHideForPlayer(playerid, SpeedoName[playerid]);
	}
	else if (newstate-1)
	{
		TextDrawShowForPlayer(playerid, SpeedoName[playerid]);
		format(getvname, sizeof(getvname), "Vehicle: ~g~%s", VehicleName[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]);
		TextDrawSetString(SpeedoName[playerid], getvname);
	}
	if (oldstate-1 && newstate)
	{
		TextDrawHideForPlayer(playerid, SpeedoSpeed[playerid]);
	}
	else if (newstate-1)
	{
		TextDrawShowForPlayer(playerid, SpeedoSpeed[playerid]);
	}
	if (oldstate-1 && newstate)
	{
		TextDrawHideForPlayer(playerid, SpeedoHealth[playerid]);
 	}
	else if (newstate-1)
	{
		TextDrawShowForPlayer(playerid, SpeedoHealth[playerid]);
	}
	if (oldstate-1 && newstate)
	{
		TextDrawHideForPlayer(playerid, SpeedoGas[playerid]);
 	}
	else if (newstate-1)
	{
		TextDrawShowForPlayer(playerid, SpeedoGas[playerid]);
	}
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
    return 1;
}

public OnRconCommand(cmd[])
{
    return 1;
}

public OnObjectMoved(objectid)
{
    return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    return 1;
}

public OnPlayerExitedMenu(playerid)
{
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    if (newkeys == KEY_SECONDARY_ATTACK)
	    {
	        new index = -1;
			for (new i = 0; i < 300; i++)
			{
				if (DroppedItem[i][diOjnum] != INVALID_OBJECT_ID)
				{
				    if (IsPlayerInRangeOfPoint(playerid, 2.0000, DroppedItem[i][diPos][0], DroppedItem[i][diPos][1], DroppedItem[i][diPos][2]))
				    {
						index = i;
				    	break;
				    }
				}
			}
			if (index == -1)
			{
			}
			else
			{
			    new itemid = DroppedItem[index][diItemID];
			    new amount = DroppedItem[index][diAmount];
				new result = GiveItem(playerid, itemid, amount);
				if (result == 1)
				{
				    DestroyPickup(DroppedItem[index][diOjnum]);

					DroppedItem[index][diOjnum] = INVALID_OBJECT_ID;
					DroppedItem[index][diItemID] = 0;
					DroppedItem[index][diAmount] = 0;
					DroppedItem[index][diPos][0] = 0.0000;
					DroppedItem[index][diPos][1] = 0.0000;
					DroppedItem[index][diPos][2] = 0.0000;
					DroppedItem[index][diTime] = 0;

					return 1;
				}
				else
				{
			    	return 1;
			    }
			}
	    }
	}
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    return 1;
}

public OnPlayerUpdate(playerid)
{
    new weaponid = GetPlayerWeapon(playerid);
    new vehicleid = GetPlayerVehicleID(playerid);
	if (weaponid > 0)
	{
	    if (WeaponHack[playerid][weaponid] == false)
	    {
		    new string[128];
			ResetPlayerWeapons(playerid);
			format(string, sizeof(string), "%s 님이 무기핵을 사용하여 자동으로 서비스 블럭 처리 되었습니다.", PlayerName(playerid));
			SendClientMessageToAll(0xFC595AFF, string);
			new bquery[200], IP[16];
			format(bquery, sizeof(bquery),"INSERT INTO hackdata(player, reason, IP, banned) VALUES('%s', '무기핵사용','%s', 1)", PlayerName(playerid), IP);
			mysql_query(bquery);
			format(string, sizeof(string),"%s 가 서비스 블럭처리 되었습니다. [사유: 무기핵사용]", PlayerName(playerid));
			SendClientMessageToAll(C_RED, string);
			mysql_free_result();
			Kick(playerid);
		}
	}
	new vspeed[25];
	format(vspeed, sizeof(vspeed), "Speed: ~y~%d ~g~KM/H", GetVehicleSpeed(vehicleid, VEHICLE_SPEED_KMPH));
	TextDrawSetString(SpeedoSpeed[playerid], vspeed);

	new vhealthtd[32], Float:vHealth;
	GetVehicleHealth(GetPlayerVehicleID(playerid), vHealth);
	new Float:percentage = (((vHealth - 250.0) / (1000.0 - 250.0)) * 100.0);
	format(vhealthtd, sizeof(vhealthtd), "Vehicle Health: ~g~%.0f", percentage);
	TextDrawSetString(SpeedoHealth[playerid], vhealthtd);


    new Float:health, Float:Armour;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, Armour);

	new healthText[68];
	format(healthText, sizeof(healthText), "~r~HEALTH : ~w~%d", floatround(health, floatround_round));
	TextDrawSetString(HealthText[playerid], healthText);
	TextDrawShowForPlayer(playerid, HealthText[playerid]);

	if (Armour > 0)
	{
		new armourText[68];
		format(armourText, sizeof(armourText), "~b~~h~~h~~h~ARMOUR : ~w~%d", floatround(Armour, floatround_round));
		TextDrawSetString(ArmourText[playerid], armourText);
		TextDrawShowForPlayer(playerid, ArmourText[playerid]);
	}
  	else
  	{
  	    TextDrawHideForPlayer(playerid, ArmourText[playerid]);
  	}
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
    return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
    return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//================================================================//
    //                              MySQL part                        //
    //================================================================//
    if(dialogid == DIALOG_REGISTER)
    {
        if(response)
        {
            if(!strlen(inputtext) || strlen(inputtext) > 100)
            {
            	SendMessage(playerid, "Error:1~100자");
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "-","회원가입", "가입", "취소");
            }
            else if(strlen(inputtext) > 0 && strlen(inputtext) < 100)
            {
                new escpass[100];
                mysql_real_escape_string(inputtext, escpass);
                MySQL_Register(playerid, escpass);
            }
        }
        if(!response)
        {
        		SendMessage(playerid, "Error: 먼저가입");
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "-","회원가입", "가입", "취소");
        }
    }
    if(dialogid == DIALOG_LOGIN)
    {
        if(!response)
        {
                SendMessage(playerid, "Error: 스폰전 로그인");
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "-","로그인", "로그인", "취소");
        }
        if(response)
        {
            new query[200], pname[24], escapepass[100];
            GetPlayerName(playerid, pname, 24);
            mysql_real_escape_string(inputtext, escapepass);
            format(query, sizeof(query), "SELECT * FROM playerdata WHERE user = '%s' AND password = SHA1('%s')", pname, escapepass);
            mysql_query(query);
            mysql_store_result();
            new numrows = mysql_num_rows();
            if (numrows == 1)
			{
				MySQL_Login(playerid);
				LoadPlayerInventories(playerid);
                Logined[playerid] = true;
			}
            if (!numrows)
            {
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "-","로그인", "로그인", "취소");
                SendMessage(playerid, "Error: 비번확인");
            }
            mysql_free_result();
        }
    }
    
    if (dialogid == DIALOG_CAR_BUY)
    {
        if (response)
        {
	        new string[128];
			new vehicleid = GetPlayerVehicleID(playerid);
	        new modelid = GetVehicleModel(vehicleid);
	        new Float:X, Float:Y, Float:Z;
	        GetPlayerPos(playerid, X, Y, Z);
			new vehicle = MySQL_CreateVehicle(modelid, X + 5, Y + 5, Z + 5, 0.0000, 0, 0, 3, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			strmid(VehicleInfo[vehicle][vOwner], PlayerName(playerid), 0, 24, 24);
			MySQL_SaveVehicle(vehicle);
			format(string, 256, "Veh %d created", vehicle);
			SendClientMessage(playerid, -1, string);
		}
		RemovePlayerFromVehicle(playerid);
        return 1;
    }
    
	if (dialogid == DIALOG_INVENTORY_MAIN)
	{
		if (response)
		{
		    new itemid = PlayerInventoryInfo[playerid][listitem][piItemID];
		    new amount = PlayerInventoryInfo[playerid][listitem][piItemAmount];
		    if (itemid > 0 && amount > 0)
		    {
		        PlayerInvIndex[playerid] = listitem;
		        ShowPlayerDialog(playerid, DIALOG_INVENTORY_USEDROP, DIALOG_STYLE_LIST, "인뼨토리", "사용하기\n버리기", "선택하기", "뒤로");
		        return 1;
			}
			ShowInventoryForPlayer(playerid, playerid);
		}
		PlayerInvIndex[playerid] = -1;
		return 1;
	}
	else if (dialogid == DIALOG_INVENTORY_USEDROP)
	{
	    if (response)
	    {
	        new slot = PlayerInvIndex[playerid];
	        if (slot > -1)
	        {
			    new itemid = PlayerInventoryInfo[playerid][slot][piItemID];
			    new amount = PlayerInventoryInfo[playerid][slot][piItemAmount];
			    if (itemid > 0 && amount > 0)
			    {
		            if (listitem == 0) // 사용하기
		            {
		                new type = ItemInfo[itemid][iType];
		                if (type == ITEM_TYPE_WEAPON)
		                {
							if (itemid == 2)
							{
							    new index = -1;
								for (new i = 0; i < 15; i++)
								{
								    if (PlayerInventoryInfo[playerid][i][piItemID] == 4 && PlayerInventoryInfo[playerid][i][piItemAmount] > 0)
									{
									    index = i;
									    break;
									}
								}
								if (index != -1)
								{
									SafeGivePlayerWeapon(playerid, 31, PlayerInventoryInfo[playerid][index][piItemAmount]);
								}
								else // 없을때
								{
									SendClientMessage(playerid, -1, "그에 걸맞는 총알 없음");
								}
							}
		                }
		            }
		            else if (listitem == 1) // 버리기
		            {
						new index = -1;
						for (new i = 0; i < 300; i++)
						{
						    if (DroppedItem[i][diOjnum] == INVALID_OBJECT_ID)
							{
							    index = i;
							    break;
							}
						}
						if (index == -1)
						{
						    // 서버 최대 드랍 아이템 개수 초과
						}
						else
						{
			                PlayerInventoryInfo[playerid][slot][piItemID] = 0;
			                PlayerInventoryInfo[playerid][slot][piItemAmount] = 0;
			                new modelid = ItemInfo[itemid][iModel];
							new Float:X,
							    Float:Y,
							    Float:Z;
							GetPlayerPos(playerid, X, Y, Z);
			                DroppedItem[index][diOjnum] = CreatePickup(modelid, 1, X, Y, Z);
							DroppedItem[index][diItemID] = itemid;
							DroppedItem[index][diAmount] = amount;
							DroppedItem[index][diPos][0] = X;
							DroppedItem[index][diPos][1] = Y;
							DroppedItem[index][diPos][2] = Z;
							DroppedItem[index][diTime] = 1;
		                }
	                }
                }
		    }
		}
	    ShowInventoryForPlayer(playerid, playerid);
		PlayerInvIndex[playerid] = -1;
		return 1;
	}
    
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
}

//============================================================================//
//                                  Player Commands                           //
//============================================================================//
public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256], tmp[512], idx, string[256];
    cmd = strtok(cmdtext, idx);
//------------------------------------------------------------------------------
	// Bank System
	if (strcmp(cmd, "/은행도움말", true) == 0)
	{
		SendClientMessage(playerid, -1, "/잔액 /입금 /출금");
		return 1;
	}
	if (strcmp(cmd, "/잔액", true) == 0)
	{
		if (IsPlayerAtBank(playerid))
		{
		    format(string, 256, "잔액 %d", PlayerInfo[playerid][pBank]);
		    SendClientMessage(playerid, -1, string);
		    return 1;
		}
		SendClientMessage(playerid, -1, "은행이 아님");
		return 1;
	}
	if (strcmp(cmd, "/입금", true) == 0)
	{
		if (IsPlayerAtBank(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, -1, "/입금 [금액]");
				return 1;
			}
			new money = strval(tmp);
			if (0 < money <= GetPlayerMoney(playerid))
			{
			    GivePlayerMoney(playerid, -money);
			    PlayerInfo[playerid][pBank] += money;
			    SavePlayer(playerid);
			    format(string, 256, "%d 입금 완료", money);
				SendClientMessage(playerid, -1, string);
			    format(string, 256, "잔액 %d", PlayerInfo[playerid][pBank]);
				SendClientMessage(playerid, -1, string);
			    return 1;
			}
			SendClientMessage(playerid, -1, "금액 부족");
			return 1;
		}
		SendClientMessage(playerid, -1, "은행이 아님");
		return 1;
	}
	if (strcmp(cmd, "/출금", true) == 0)
	{
		if (IsPlayerAtBank(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/출금 [금액]");
			    return 1;
			}
			new money = strval(tmp);
			if (0 < money <= PlayerInfo[playerid][pBank])
			{
			    GivePlayerMoney(playerid, money);
			    PlayerInfo[playerid][pBank] -= money;
			    SavePlayer(playerid);
			    format(string, 256, "%d 출금 완료", money);
				SendClientMessage(playerid, -1, string);
			    format(string, 256, "잔액 %d", PlayerInfo[playerid][pBank]);
				SendClientMessage(playerid, -1, string);
			    return 1;
			}
			SendClientMessage(playerid, -1, "금액 부족");
			return 1;
		}
		SendClientMessage(playerid, -1, "은행이 아님");
		return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp(cmd, "/차", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if (!strlen(tmp))
	    {
	        SendClientMessage(playerid, -1, "/차 [구매/판매/폐차]");
	        return 1;
	    }
	    if (strcmp(tmp, "목록", true) == 0)
	    {
			new query[512];
			format(query, 512, "SELECT * FROM vehicledata WHERE owner = '%s'", PlayerName(playerid));
			mysql_query(query);
			mysql_store_result();
	        new vehs = mysql_num_rows();
			mysql_free_result();
			//------------------------------------------------------------------
			if (vehs <= 0) 		format(string, 256, "You have no vehicle");
			else if (vehs == 1) format(string, 256, "You have 1 vehicle");
			else 				format(string, 256, "You have %d vehicle", vehs);
			SendClientMessage(playerid, -1, string);
			return 1;
	    }
	    else if (strcmp(tmp, "관리자생성", true) == 0)
	    {
	        if (IsPlayerAdmin(playerid))
	        {
	            tmp = strtok(cmdtext, idx);
	            if (!strlen(tmp))
	            {
					return 1;
	            }
	            new modelid = strval(tmp);
	            new Float:X, Float:Y, Float:Z;
	            GetPlayerPos(playerid, X, Y, Z);
				new vehicleid = MySQL_CreateVehicle(modelid, X, Y, Z, 0.0000, 0, 0, 3, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
				strmid(VehicleInfo[vehicleid][vOwner], PlayerName(playerid), 0, 24, 24);
				MySQL_SaveVehicle(vehicleid);
				format(string, 256, "Veh %d created", vehicleid);
				SendClientMessage(playerid, -1, string);
				return 1;
	        }
	        return 1;
	    }
	    else if (strcmp(tmp, "구매", true) == 0)
	    {
	        return 1;
	    }
	    else if (strcmp(tmp, "판매", true) == 0)
	    {
	        return 1;
	    }
	    else if (strcmp(tmp, "폐차", true) == 0)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
			if (vehicleid > 0)
			{
			    if (strcmp(PlayerName(playerid), VehicleInfo[vehicleid][vOwner], true) == 0)
			    {
			        if (IsPlayerInRangeOfPoint(playerid, 1.0000, 0.0000, 0.0000, 0.0000))
			        {
						RemovePlayerFromVehicle(playerid);
						MySQL_RemoveVehicle(VehicleInfo[vehicleid][vNumberplate]);
						return 1;
			        }
			        SendClientMessage(playerid, -1, "You have to be at junkyard");
			        return 1;
				}
				SendClientMessage(playerid, -1, "You don't have any authority to junk this vehicle");
				return 1;
	        }
	        SendClientMessage(playerid, -1, "You have to be in vehicle to use this command");
	        return 1;
	    }
	    else if (strcmp(tmp, "주차", true) == 0)
	    {
			new vehicleid = GetPlayerVehicleID(playerid);
			if (vehicleid > 0)
			{
			    if (strcmp(PlayerName(playerid), VehicleInfo[vehicleid][vOwner], true) == 0 || IsPlayerAdmin(playerid))
			    {
				    GetVehiclePos(
						vehicleid,
						VehicleInfo[vehicleid][vPos][0],
						VehicleInfo[vehicleid][vPos][1],
						VehicleInfo[vehicleid][vPos][2]
					);
				    GetVehicleZAngle(
						vehicleid,
						VehicleInfo[vehicleid][vPos][3]
					);
					LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
					VehicleInfo[vehicleid][vInterior] = GetPlayerInterior(playerid);
					VehicleInfo[vehicleid][vWorld] = GetVehicleVirtualWorld(vehicleid);

					MySQL_SaveVehicle(vehicleid);

					SendClientMessage(playerid, -1, "You parked your vehicle");

			        return 1;
		        }
		        SendClientMessage(playerid, -1, "You don't have any authority to park this vehicle");
				return 1;
			}
			SendClientMessage(playerid, -1, "You have to be in vehicle to use this command");
			return 1;
	    }
	    else if (strcmp(tmp, "잠금", true ) == 0)
	    {
   			new vehicleid = GetPlayerVehicleID(playerid);
			if (vehicleid > 0)
			{
			    if (strcmp(PlayerName(playerid), VehicleInfo[vehicleid][vOwner], true) == 0 || IsPlayerAdmin(playerid))
			    {
			        new
			            engine, lights, alarm,
			            doors, bonnet, boot, objective
					;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if (doors == 1)
					{
					    SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
					}
					else
					{
					    SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
					}
					MySQL_SaveVehicle(vehicleid);
					return 1;
				}
			}
	    }
	    SendClientMessage(playerid, -1, "/차 [목록/구매/판매/폐차/주차]]");
		return 1;
	}
	if (strcmp(cmd, "/시동", true) == 0)
	{
        new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsPlayerInAnyVehicle(playerid))
		{
			if(SCAR[0] != vehicleid)
			{
		    	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid, -1, "당신은 운전석에 타고있지 않습니다.");
					return 1;
				}
				if(IsABike(vehicleid))
				{
					SendClientMessage(playerid, -1, "자전거는 시동을 걸수없는 차량입니다.");
					return 1;
				}
				new Float:vhealth;
   				GetVehicleHealth(vehicleid, vhealth);
				if(vhealth <= 300)
				{
					SendClientMessage(playerid, -1, "차량이 고장나서 시동을 걸 수 없습니다.");
					return 1;
				}
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(engine == 1)
				{

					format(string, sizeof(string), "* %s이(가) %s 에 시동을 끈다.", PlayerName(playerid),VehicleName[GetVehicleModel(vehicleid) - 400]);
					ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetVehicleParamsEx(vehicleid,0,0,alarm,doors,bonnet,boot,objective);
					return 1;
				}
				else
				{
					format(string, sizeof(string), "* %s이(가) %s 에 시동을 건다.", PlayerName(playerid),VehicleName[GetVehicleModel(vehicleid) - 400]);
					ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetTimerEx("StartingTheVehicle",1000+random(500),0, "i",playerid);
					format(string, sizeof(string), "* 시동이 걸렸다. (%s)", PlayerName(playerid));
					ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					return 1;
				}
			}
		}
		return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp(cmd, "/팩션", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if (!strlen(tmp))
	    {
	        SendClientMessage(playerid, -1, "/팩션[목록/생성/타입변경/이름변경/스폰변경]");
	        return 1;
	    }
	    if (strcmp(tmp, "목록", true) == 0)
	    {
			for (new i = 1; i <= MAX_FACTIONS; i++)
			{
				if (FactionInfo[i][fType] > 0)
				{
				    format(string, 256, "팩션 번호 : %d / 팩션 이름 : %s / 팩션 타입 : %d", i, FactionInfo[i][fName], FactionInfo[i][fType]);
					SendClientMessage(playerid, -1, string);
				}
			}
	        return 1;
	    }
	    if (strcmp(tmp, "생성", true) == 0)
	    {
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 생성 [타입] [이름]");
		        return 1;
		    }
		    new type = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new name[64];
			while ((idx < length) && ((idx - offset) < (sizeof(name) - 1)))
			{
				name[idx - offset] = cmdtext[idx];
				idx++;
			}
			name[idx - offset] = EOS;
			if (!strlen(name))
			{
		        SendClientMessage(playerid, -1, "/팩션 생성 [타입] [이름]");
		        return 1;
		    }
		    new factionid = CreateFaction(type, name);
		    if (factionid == 0)
		    {
				SendClientMessage(playerid, -1, "응 안돼");
		    }
		    else
		    {
			    GetPlayerPos(playerid, FactionInfo[factionid][fSpawnPos][0], FactionInfo[factionid][fSpawnPos][1], FactionInfo[factionid][fSpawnPos][2]);
			    FactionInfo[factionid][fSpawnInt] = GetPlayerInterior(playerid);
			    FactionInfo[factionid][fSpawnWorld] = GetPlayerVirtualWorld(playerid);
			    SaveFaction(factionid);
		    }
	        return 1;
	    }
	    else if (strcmp(tmp, "삭제", true) == 0)
	    {
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 삭제 [팩션 번호]");
		        return 1;
		    }
		    new factionid = strval(tmp);
		    RemoveFaction(factionid);
	        return 1;
	    }
	    else if (strcmp(tmp, "타입변경", true) == 0)
	    {
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 타입변경 [팩션 번호] [새로운 타입]");
		        return 1;
		    }
		    new factionid = strval(tmp);
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 타입변경 [팩션 번호] [새로운 타입]");
		        return 1;
		    }
		    new type = strval(tmp);
		    FactionInfo[factionid][fType] = type;
		    SaveFaction(factionid);
	        return 1;
	    }
	    else if (strcmp(tmp, "이름변경", true) == 0)
	    {
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 이름변경 [팩션 번호] [새로운 이름]");
		        return 1;
		    }
		    new factionid = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new name[64];
			while ((idx < length) && ((idx - offset) < (sizeof(name) - 1)))
			{
				name[idx - offset] = cmdtext[idx];
				idx++;
			}
			name[idx - offset] = EOS;
			if (!strlen(name))
			{
		        SendClientMessage(playerid, -1, "/팩션 이름변경 [팩션 번호] [새로운 이름]");
		        return 1;
		    }
		    strmid(FactionInfo[factionid][fName], name, 0, 64, 64);
		    SaveFaction(factionid);
	        return 1;
	    }
	    else if (strcmp(tmp, "스폰변경", true) == 0)
	    {
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp))
		    {
		        SendClientMessage(playerid, -1, "/팩션 스폰변경 [팩션 번호]");
		        return 1;
		    }
		    new factionid = strval(tmp);
		    GetPlayerPos(playerid, FactionInfo[factionid][fSpawnPos][0], FactionInfo[factionid][fSpawnPos][1], FactionInfo[factionid][fSpawnPos][2]);
		    FactionInfo[factionid][fSpawnInt] = GetPlayerInterior(playerid);
		    FactionInfo[factionid][fSpawnWorld] = GetPlayerVirtualWorld(playerid);
		    SaveFaction(factionid);
	        return 1;
	    }
	    return 1;
	}
	if(strcmp(cmd, "/me", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "/me [action]");
			return 1;
		}
		format(string, sizeof(string), "* %s 이(가) %s", PlayerName(playerid), result);
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
	}
	if(strcmp(cmd, "/do", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "/do [action]");
			return 1;
		}
		format(string, sizeof(string), "* %s (%s)", result, PlayerName(playerid));
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
	}
	if(strcmp(cmd, "/so", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "/so [action]");
			return 1;
		}
		format(string, sizeof(string), "* %s (%s)", result, PlayerName(playerid));
		ProxDetector(10.0, playerid, string, 0xDB7093FF,0xDB7093FF,0xDB7093FF,0xDB7093FF,0xDB7093FF);
		return 1;
	}
	if(strcmp(cmd, "/작은목소리", true) == 0 || strcmp(cmd, "/c", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "(작은 목소리) [내용]");
			return 1;
		}
	   	format(string, sizeof(string), "(작은 목소리) %s : %s", PlayerName(playerid), result);
		ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 1;
	}

	if(strcmp(cmd, "/local", true) == 0 || strcmp(cmd, "/l", true) == 0 || strcmp(cmd, "/say", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "(/l)ocal [할 말]");
			return 1;
		}
		format(string, sizeof(string), "%s : %s", PlayerName(playerid), result);
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
	        ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,0,1,1,1,1,1);
	    }
		ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 1;
	}

	if(strcmp(cmd, "/shout", true) == 0 || strcmp(cmd, "/s", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, -1, "(/s)hout [할 말]");
			return 1;
		}
		format(string, sizeof(string), "(외치기) %s: %s!", PlayerName(playerid), result);
		ProxDetector(10.0, playerid, string,C_WHITE,C_WHITE,C_WHITE,COLOR_FADE1,COLOR_FADE2);
		return 1;
	}
	//=================================관리패널================================//
	if(strcmp(cmd, "/gethere",true) == 0 || strcmp(cmd, "/소환",true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, -1, "소환 [플레이어번호/이름의 부분]");
				return 1;
			}
			new Float:targetidcx,Float:targetidcy,Float:targetidcz;
			new targetid;
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(targetid != INVALID_PLAYER_ID)
				{
					GetPlayerPos(playerid, targetidcx, targetidcy, targetidcz);
					if(GetPlayerState(targetid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(targetid);
						SetVehiclePos(tmpcar, targetidcx, targetidcy+4, targetidcz);
						SetVehicleVirtualWorld(tmpcar, GetPlayerVirtualWorld(playerid));
						SetVehicleInterior(tmpcar, GetPlayerInterior(playerid));
					}
					else
					{
						SetPlayerPos(targetid,targetidcx,targetidcy+2, targetidcz);
					}
					SendClientMessage(targetid, C_WHITE, "당신은 텔레포트되었다.");
					SetPlayerInterior(targetid,GetPlayerInterior(playerid));
					SetPlayerVirtualWorld(targetid,GetPlayerVirtualWorld(playerid));
					new year, month, day, hour, minute, second;
					new bquery[200], IP[16];
					GetPlayerIp(targetid, IP, 16);
					getdate(year, month, day);
					gettime(hour, minute, second);
					format(bquery, sizeof(bquery),"INSERT INTO spawndata(year, month, day, hour, minute, second, admin, player, IP, spawned) VALUES(%d, %d, %d, %d, %d, %d, '%s', '%s', '%s', 1)", year, month, day, hour, minute, second, PlayerName(playerid), PlayerName(targetid), IP);
					mysql_query(bquery);
				}
			}
			else
			{
				format(string, sizeof(string), "%d은(는) 활성화되어 있지 않은 플레이어 입니다.", targetid);
				SendClientMessage(playerid, C_WHITE, string);
			}
		}
		return 1;
	}
 	if (strcmp("/자동저장", cmdtext, true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if (AutoSave == false)
			{
				AutoSave = true;
				SendClientMessage(playerid, -1, "자동 저장 On");
			}
			else
			{
			    AutoSave = false;
			    SendClientMessage(playerid, -1, "자동 저장 Off");
			}
			return 1;
		}
		SendClientMessage(playerid, -1, "권한이 없습니다.");
		return 1;
	}
	if(strcmp(cmd, "/bds", true) == 0)
	{
		ShowPlayerDialog(playerid, DIALOG_BUILD, DIALOG_STYLE_LIST, "BDS", "건물 생성", "확인", "취소");
	    return 1;
	}
	if(strcmp(cmd, "/킥", true) == 0 || strcmp(cmd, "/kick", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) return SendClientMessage(playerid, C_WHITE,"/킥 [플번] [이유]");
			new reason[100], targetid = strval(tmp);
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, C_WHITE,"접속하지 않은 유저입니다.");
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason)) return SendClientMessage(playerid, C_WHITE,"/킥 [플번] [이유]");
			new year, month, day, hour, minute, second;
			new bquery[200], IP[16];
			GetPlayerIp(targetid, IP, 16);
			getdate(year, month, day);
			gettime(hour, minute, second);
			format(bquery, sizeof(bquery),"INSERT INTO kickdata(year, month, day, hour, minute, second, admin, player, reason, IP, kicked) VALUES(%d, %d, %d, %d, %d, %d, '%s', '%s', '%s', '%s', 1)", year, month, day, hour, minute, second, PlayerName(playerid), PlayerName(targetid), reason, IP);
			mysql_query(bquery);
			format(string, sizeof(string),"%s 가 어드민 %s 에 의해 서버 종료 처리 되었습니다. [사유: %s]", PlayerName(targetid), PlayerName(playerid), reason);
			SendClientMessageToAll(C_RED, string);
			Kick(targetid);
		}
		else
		{
			return SendClientMessage(playerid, C_RED,"당신은 권한이 없수!");
		}
		return 1;
	}
	if(strcmp(cmd, "/ban", true) == 0 || strcmp(cmd, "/밴", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) return SendClientMessage(playerid, C_WHITE,"/밴 [플번] [이유]");
			new reason[100], targetid = strval(tmp);
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, C_WHITE,"접속하지 않은 유저입니다.");
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason)) return SendClientMessage(playerid, C_WHITE,"/밴 [플번] [이유]");
			new bquery[200], IP[16];
			GetPlayerIp(targetid, IP, 16);
			format(bquery, sizeof(bquery),"INSERT INTO bandata(admin, player, reason, IP, banned) VALUES('%s', '%s', '%s','%s', 1)", PlayerName(playerid),PlayerName(targetid), reason, IP);
			mysql_query(bquery);
			format(string, sizeof(string),"%s 가 어드민 %s 에 의해 서비스 블럭처리 되었습니다. [사유: %s]", PlayerName(targetid), PlayerName(playerid), reason);
			SendClientMessageToAll(C_RED, string);
			mysql_free_result();
			Kick(targetid);
		}
		else
		{
			return SendClientMessage(playerid, C_RED,"당신은 권한이 없수!");
		}
		return 1;
	}
	if(strcmp(cmd, "/unban", true) == 0 || strcmp(cmd, "/밴해제", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new targetname[MAX_PLAYER_NAME+1];
			while ((idx < length) && ((idx - offset) < (sizeof(targetname) - 1)))
			{
				targetname[idx - offset] = cmdtext[idx];
				idx++;
			}
			targetname[idx - offset] = EOS;
			if(!strlen(targetname)) return SendClientMessage(playerid, C_WHITE,"/밴해제 [이름]");
			new query[200];
			format(query, sizeof(query),"SELECT * FROM `bandata` WHERE `player` = '%s' AND `banned` = '1' LIMIT 1", targetname);
			print(query);
			mysql_query(query);
			mysql_store_result();
			new rows = mysql_num_rows();
			if(rows > 0)
			{
				new uquery[200];
				format(uquery, sizeof(uquery),"DELETE FROM `bandata` WHERE `player` = '%s'", targetname);
				mysql_query(uquery);
				mysql_store_result();
				format(string, sizeof(string),"당신은 %s 의 서비스 블럭 상태를 변경하였습니다. (서비스 블럭 해제)", targetname);
				SendClientMessage(playerid, C_BLUE,string);
			}
			else if(!rows)
			{
				new str[128];
				format(str, sizeof(str),"%s 는 서비스 블럭 상태인 유저가 아닙니다.", targetname);
				SendClientMessage(playerid, C_RED, str);
				mysql_free_result();
			}
		}
		else
		{
			return SendClientMessage(playerid, C_RED,"넌 권한이 없어!");
		}
		return 1;
	}
	if(strcmp(cmd, "/밴찾기", true) == 0 || strcmp(cmd, "/sban", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    tmp = strtok(cmdtext, idx);
			new admin[50], player[50], reason[100], IP[16], targetname[MAX_PLAYER_NAME+1];
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(targetname) - 1)))
			{
				targetname[idx - offset] = cmdtext[idx];
				idx++;
			}
			targetname[idx - offset] = EOS;
			if(!strlen(targetname)) return SendClientMessage(playerid, C_WHITE,"/밴해제 [이름]");
			new query[200];
			format(query, sizeof(query),"SELECT * FROM `bandata` WHERE `player` = '%s' AND `banned` = '1' LIMIT 1", targetname);
			mysql_query(query);
			mysql_store_result();
			new rows = mysql_num_rows();
			if(rows == 1)
			{
				while(mysql_fetch_row(query))
				{
					mysql_fetch_field_row(admin, "admin");
					mysql_fetch_field_row(player, "player");
					mysql_fetch_field_row(IP, "IP");
					mysql_fetch_field_row(reason, "reason");
				}
				format(string, sizeof(string),"Admin: %s  | Player:%s | Reason:%s | IP:%s " , admin, player, reason, IP);
				SendClientMessage(playerid, C_RED, string);
			}
			if(!rows)
			{
				SendClientMessage(playerid, C_RED,"밴됀 사람 아님");
			}
		}
		else
		{
			return SendClientMessage(playerid, C_RED,"권한안됌");
		}
		return 1;
	}
	if (strcmp(cmd, "/문의채널", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] > 0)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, -1, "/문의채널 [승인/종료/강제열기]");
				return 1;
			}
		    if(strcmp(tmp, "승인", true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if (!strlen(tmp))
				{
					SendClientMessage(playerid, -1, "/문의채널 승인 [플레이어 번호]");
					return 1;
				}
				new targetid = strval(tmp);
				if (IsPlayerConnected(targetid))
				{
				    if (AcceptAdmin[targetid] == INVALID_PLAYER_ID)
				    {
				        if (AdminChannel[targetid] > 0)
				        {
				            AdminChannel[targetid] = 0;
				            AcceptAdmin[targetid] = playerid;
							format(string, 256, "당신은 %s의 담당 관리자로 배정되었으며, 문의 채널이 열렸습니다.", PlayerName(targetid));
							SendClientMessage(playerid, -1, string);
							format(string, 256, "당신에게 배정된 담당 관리자는 %s(이)며, 문의 채널이 열렸습니다. [/관리자]", PlayerName(playerid));
							SendClientMessage(targetid, -1, string);
				            return 1;
				        }
				        SendClientMessage(playerid, -1, "관리자를 요청하지 않은 플레이어입니다.");
				        return 1;
				    }
				    SendClientMessage(playerid, -1, "이미 다른 관리자가 요청을 승인했습니다.");
					return 1;
				}
				SendClientMessage(playerid, -1, "없는 플레이어입니다.");
				return 1;
  	 		}
		    if(strcmp(tmp, "종료", true) == 0)
			{
			    tmp = strtok(cmdtext, idx);
				if (!strlen(tmp))
				{
					SendClientMessage(playerid, -1, "/문의채널 종료 [플레이어 번호]");
					return 1;
				}
				new targetid = strval(tmp);
				if (IsPlayerConnected(targetid))
				{
				    if (AcceptAdmin[targetid] == playerid)
				    {
				        AcceptAdmin[targetid] = INVALID_PLAYER_ID;
			        	format(string, 256, "당신은 문의 채널을 닫았으며 더 이상 %s의 담당 관리자가 아닙니다.", PlayerName(targetid));
						SendClientMessage(playerid, -1, string);
						format(string, 256, "담당 관리자 %s이(가) 문의 채널을 닫았습니다.", PlayerName(playerid));
						SendClientMessage(targetid, -1, string);
				        return 1;
				    }
				}
			}
  			if(strcmp(tmp, "강제열기", true) == 0)
			{
			    tmp = strtok(cmdtext, idx);
				if (!strlen(tmp))
				{
					SendClientMessage(playerid, -1, "/문의채널 강제열기 [플레이어 번호]");
					return 1;
				}
				new targetid = strval(tmp);
				if (IsPlayerConnected(targetid))
				{
				    if (AcceptAdmin[targetid] == INVALID_PLAYER_ID)
				    {
			            AdminChannel[targetid] = 0;
			            AcceptAdmin[targetid] = playerid;
						format(string, 256, "당신은 %s의 문의 채널을 강제로 열었으며 자동적으로 담당 관리자가 됩니다.", PlayerName(targetid));
						SendClientMessage(playerid, -1, string);
						format(string, 256, "관리자 %s이(가) 문의 채널을 강제로 열었고 [/관리자] 를 이용해 대화를 나눌 수 있습니다.", PlayerName(playerid));
						SendClientMessage(targetid, -1, string);
			            return 1;
				    }
				    SendClientMessage(playerid, -1, "이미 담당 관리자가 배정되어 있는 플레이어 입니다.");
					return 1;
				}
				SendClientMessage(playerid, -1, "없는 플레이어입니다.");
				return 1;
			}

		}
	    SendClientMessage(playerid, -1, "권한이 없습니다.");
		return 1;
	}
	if(strcmp(cmd, "/noooc", true) == 0 || strcmp(cmd, "/질문채널잠금", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pAdmin] >= 1 && (!noooc))
			{
				noooc = 1;
				SendClientMessageToAll(C_RED, "관리자에 의해 질문채널이 잠겼습니다.");
			}
			else if(PlayerInfo[playerid][pAdmin] >= 2 && (noooc))
			{
				noooc = 0;
				SendClientMessageToAll(C_RED, "관리자에 의해 질문채널이 열렸습니다.");
			}
			else
			{
				SendClientMessage(playerid,-1,"당신은 이 명령어를 사용할 권한이 없습니다.");
			}
		}
		return 1;
	}
	//=========================================================================//
	//================================유저패널=================================//
	if(strcmp(cmd, "/help", true) == 0 || strcmp(cmd, "/도움말", true) == 0)
	{
		SendClientMessage(playerid, -1, "/엠포, /관리자, /신고");
		return 1;
	}
	if(strcmp(cmd, "/엠포", true) == 0 || strcmp(cmd, "/m4", true) == 0)
	{
		GiveItem(playerid, 2, 1);
		GiveItem(playerid, 4, 30);
		return 1;
	}
	if(strcmp(cmd, "/저장", true) == 0 || strcmp(cmd, "/sav", true) == 0)
	{
	    SavePlayer(playerid);
	    SendClientMessage(playerid, -1, "저장");
		return 1;
	}
	if(strcmp(cmd, "/인벤", true) == 0 || strcmp(cmd, "/inven", true) == 0)
	{
	    ShowInventoryForPlayer(playerid, playerid);
	    return 1;
	}
	if(strcmp(cmd, "/관리자가된다", true) == 0 || strcmp(cmd, "/뾰로롱", true) == 0)
	{
	    SendClientMessage(playerid, -1, "완료");
	    PlayerInfo[playerid][pAdmin] = 12;
		return 1;
	}
	if(strcmp(cmd, "/n", true) == 0||strcmp(cmd, "/질문", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if((noooc) && PlayerInfo[playerid][pAdmin] < 1)
			{
				SendClientMessage(playerid, -1,"관리자에 의해 질문/도움 채널이 잠겨 있는 상태입니다.");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[256];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,-1, "/n [내용]");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] == 0)
			{
			    if(PlayerInfo[playerid][pLevel] <= 4) // 30
			    {
					format(string, sizeof(string), "* 뉴비  %s(%d): %s", PlayerName(playerid), playerid, result);
			    }
				else if(PlayerInfo[playerid][pLevel] >= 5) // 9
				{
					format(string, sizeof(string), "* 올드비  %s(%d): %s", PlayerName(playerid), playerid, result);
				}
			}
			else
			{
				format(string, sizeof(string), "{41CDCD}* [관리자] %s: %s", PlayerName(playerid), result);
			}
			OOCOff(0x00FF00FF,string);
		}
		return 1;
	}
	if (strcmp(cmd, "/관리자",true) == 0)
	{
	    if (AcceptAdmin[playerid] == INVALID_PLAYER_ID)
	    {
			if (AdminChannel[playerid] == 0)
			{
			    AdminChannel[playerid] = 10;
				SendClientMessage(playerid, -1, "관리자에게 문의 요청을 합니다...");
				format(string, sizeof(string), "%s(%d) 유저가 관리자 문의를 요청합니다. (해당 요청을 받는 사람이 담당 관리진)", PlayerName(playerid), playerid);
				SendAdminMessage(C_WHITE, string);
				return 1;
  			}
			SendClientMessage(playerid, -1, "아직 관리자 요청을 할 수 없습니다.");
			return 1;
		}
		else
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[256];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
   			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,C_WHITE, "/관리자 [관리자]");
				return 1;
			}
			format(string, sizeof(string), "%s(%d) 의 질문: %s", PlayerName(playerid), playerid, (result));
			SendAdminMessage(C_WHITE, string);
			format(string, sizeof(string), "[ 관리자 문의 전달 ] - {FFFFFF}< %s >",(result));
			SendClientMessage(playerid, C_WHITE, string);
			return 1;
		}
	}
	if (strcmp(cmd, "/인벤토리", true) == 0)
	{
		ShowInventoryForPlayer(playerid, playerid);
	    return 1;
	}
	if(strcmp(cmd, "/신고", true) == 0 || strcmp(cmd, "/report", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    new year, month, day, hour, minute, second;
		    new giveplayerid;
			tmp = strtok(cmdtext, idx);
			giveplayerid = ReturnUser(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,C_WHITE, "/신고 [플레이어번호/이름의부분] [이유]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
					getdate(year, month, day);
					gettime(hour, minute, second);
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[256];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid,C_WHITE, ""#C_YELLOW"< ☞ >"#C_WHITE" /신고 [플레이어번호/이름의부분] [이유]");
						return 1;
					}
					format(string, sizeof(string), "제보자: %s(%d) , 신고대상: %s(%d) [이유: %s]",PlayerName(playerid), playerid, PlayerName(giveplayerid), giveplayerid, (result));
					SendAdminMessage(C_WHITE,string);
					format(string, sizeof(string), "제보자: %s , 신고대상: %s , 이유: %s (%d-%d-%d)", PlayerName(playerid), PlayerName(giveplayerid), (result), year, month, day);
					SendClientMessage(playerid,C_WHITE, "당신의 신고 요청은 관리자에게 전송되었습니다.");
				}
			}
			else
			{
				SendClientMessage(playerid,C_WHITE, "그 플레이어는 존재하지 않는 플레이어입니다.");
			}
		}
		return 1;
	}
	return 1;
}

//============================================================================//
//                                  Stocks /  Publics                         //
//============================================================================//

public HideMessage1(playerid)
{
	TextDrawHideForPlayer(playerid, Textdraw1);
	return 1;
}

public ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		if(col1 == COLOR_FADE1 && col2 == COLOR_FADE2 && col3 == COLOR_FADE3 && col4 == COLOR_FADE4 && col5 == COLOR_FADE5)
		{
			new ch[2] = { -1, ... };
			for(new i = 0; i < strlen(string); i++)
			{
				if(string[i] == '*')
				{
					if(ch[0] == -1)
					{
						ch[0] = i;
					}
					else if(ch[1] == -1)
					{
						ch[1] = i;
						break;
					}
				}
			}
			if(ch[0] != -1 && ch[1] != -1)
			{
				new string2[4][256];
				strmid(string2[0], string, 0, ch[0]-1, 256);
				strmid(string2[1], string, ch[0], ch[1]+1, 256);
				strmid(string2[2], string, ch[1]+1, strlen(string), 256);
				for(new i = 0; i < M_P; i++)
				{
					if(IsPlayerConnected(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
					{
						GetPlayerPos(i, posx, posy, posz);
						tempposx = (oldposx -posx);
						tempposy = (oldposy -posy);
						tempposz = (oldposz -posz);
						if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							format(string2[3], 256, "%s{C2A2DA}%s{E6E6E6}%s", string2[0], string2[1], string2[2]);
							SendClientMessage(i, col1, string2[3]);
						}
						else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							format(string2[3], 256, "%s{C2A2DA}%s{C8C8C8}%s", string2[0], string2[1], string2[2]);
							SendClientMessage(i, col2, string2[3]);
						}
						else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							format(string2[3], 256, "%s{C2A2DA}%s{AAAAAA}%s", string2[0], string2[1], string2[2]);
							SendClientMessage(i, col3, string2[3]);
						}
						else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							format(string2[3], 256, "%s{C2A2DA}%s{8C8C8C}%s", string2[0], string2[1], string2[2]);
							SendClientMessage(i, col4, string2[3]);
						}
						else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							format(string2[3], 256, "%s{C2A2DA}%s{6E6E6E}%s", string2[0], string2[1], string2[2]);
							SendClientMessage(i, col5, string2[3]);
						}
					}
				}
				return 1;
			}
		}
		for(new i = 0; i < M_P; i++)
		{
			if(IsPlayerConnected(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, string);
				}
				else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, string);
				}
				else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, string);
				}
				else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, string);
				}
				else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, string);
				}
			}
		}
	}
	return 1;
}

public SetVehicleInterior(vehicleid, intid)
{
	LinkVehicleToInterior(vehicleid, intid);
	VehicleInfo[vehicleid][vInterior] = intid;
	return 1;
}

public AutoSaveTimer()
{
	if (AutoSave == true)
	{
		for (new i; i < GetMaxPlayers(); i++)
		{
		    if (IsPlayerConnected(i))
		    {
		        if (Logined[i] == true)
		        {
		            SavePlayer(i);
		        }
		    }
		}
	}
}

public StartingTheVehicle(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid,1,lights,alarm,doors,bonnet,boot,objective);
		}
	}
	return 1;
}

public SendAdminMessage(color,string[])
{
	for(new i = 0; i < M_P; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] >= 1)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

public IsABike(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
	{
		return 1;
	}
	return 0;
}

stock ShowInventoryForPlayer(playerid, showplayerid)
{
	new itemid = 0,
		amount = 0,
		tmp[256], info[1024];
	for (new i = 0; i < 10; i++)
	{
        itemid = PlayerInventoryInfo[playerid][i][piItemID];
        amount = PlayerInventoryInfo[playerid][i][piItemAmount];
	    if (itemid > 0 && amount > 0)
	    {
	        format(tmp, 256, "[이름] %s [수량] %d\n", ItemInfo[itemid][iName], amount);
	    }
	    else
	    {
	        format(tmp, 256, "[이름] 비어있음 [수량] 비어있음\n");
	    }
	    strcat(info, tmp);
	}
	ShowPlayerDialog(showplayerid, DIALOG_INVENTORY_MAIN, DIALOG_STYLE_LIST, "인벤토리", info, "선택하기", "닫기");
	return 1;
}

stock GiveItem(playerid, itemid, amount)
{
	if (itemid < 0 || ItemInfo[itemid][iType] == ITEM_TYPE_NONE || amount <= 0)
	{
	    return 0;
	}
	new slot = -1;
	for (new i = 0; i < 10; i++)
	{
	    if ((PlayerInventoryInfo[playerid][i][piItemID] == 0 && PlayerInventoryInfo[playerid][i][piItemAmount] == 0) ||
			(PlayerInventoryInfo[playerid][i][piItemID] == itemid && PlayerInventoryInfo[playerid][i][piItemAmount] > 0))
	    {
	        slot = i;
	        break;
	    }
	    continue;
	}
	if (slot == -1)
	{
	    return 0;
	}
	else
	{
		PlayerInventoryInfo[playerid][slot][piItemID] = itemid;
		PlayerInventoryInfo[playerid][slot][piItemAmount] += amount;
	    return 1;
	}
}

stock DropItem(playerid, itemid, amount)
{
	new slot = -1;
	for (new i = 0; i < 10; i++)
	{
	    if (PlayerInventoryInfo[playerid][i][piItemID] == itemid && PlayerInventoryInfo[playerid][i][piItemAmount] >= amount)
	    {
	        slot = i;
	        break;
	    }
	    continue;
	}
	if (slot == -1)
	{
	    return 0;
	}
	else
	{
		PlayerInventoryInfo[playerid][slot][piItemAmount] =- amount;
		if (PlayerInventoryInfo[playerid][slot][piItemAmount] == 0)
		{
		    PlayerInventoryInfo[playerid][slot][piItemID] = 0;
		}
	    return 1;
	}
}

public TutorialEnd(playerid)
{
	SendClientMessage(playerid, -1, "튜토리얼이 끝났습니다.");
    SetPlayerVirtualWorld(playerid, 0);
    TogglePlayerControllable(playerid, 1);
	PlayerInfo[playerid][pTutorial] = 1;
	return 1;
}

public OOCOff(color,const string[])
{
	for(new i = 0; i < M_P; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(!gOoc[i])
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}

public SafeGivePlayerWeapon(playerid, weaponid, ammo)
{
	GWeapon[playerid] = 5;
	WeaponHack[playerid][weaponid] = true;
	if (GetPlayerWeapon(playerid) == weaponid)
	{
	    ammo += GetPlayerAmmo(playerid);
	}
	GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if (userid >=0 && userid < M_P)
		{
			if(!IsPlayerConnected(userid))
			{

				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid;
			}
		}

	}
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < M_P; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0)
			{
				if (len == strlen(name))
				{
					return i;
				}
				else
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock RemoveUnderScore(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if(name[i] == '_') name[i] = ' ';
    }
    return name;
}

stock SendMessage(playerid, message[])
{
	TextDrawHideForPlayer(playerid, Textdraw1);
	TextDrawSetString(Textdraw1, message);
	TextDrawShowForPlayer(playerid, Textdraw1);
	SetTimer("HideMessage1", 5000, false);
	return 1;
}



stock ErrorMessage(playerid, message[])
{
	new string[128];
	format(string, sizeof string, ""Red"[Error] "White"%s", message);
	SendClientMessage(playerid, -1, string);
	return 1;
}

stock MySQL_Register(playerid, passwordstring[])
{
    new query[350], pname[24], IP[15];
    new Bannedby[20];
    format(Bannedby, 20, "Not Banned");
    GetPlayerName(playerid, pname, 24);
    GetPlayerIp(playerid, IP, 15);
    format(query, sizeof(query), "INSERT INTO playerdata (user, password, score, money, level, admin, vip, tutorial, kma, rank, kills, deaths, jailedtimes, frozentimes, banned, bannedby, logins, PosX, PosY, PosZ, vworld, interior, bank, IP) VALUES('%s', SHA1('%s'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '%s', 0, 0, 0, 0, 0, 0, 0, '%s')", pname, passwordstring, Bannedby, IP);
    mysql_query(query);
    Logged[playerid] = 1;
    return 1;
}

stock SavePlayer(playerid)
{
	if(Logged[playerid] == 1)
    {
        new score = GetPlayerScore(playerid);
        new money = GetPlayerMoney(playerid);
		GetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
		PlayerInfo[playerid][pVWorld] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
        new query[300], pname[24];
        GetPlayerName(playerid, pname, 24);
        format(query, sizeof(query), "UPDATE playerdata SET score=%d, admin=%d, money=%d, level=%d, vip=%d, kma=%d, rank=%d, kills=%d, deaths=%d, muted=%d, jailed=%d, frozen=%d, mutedtimes=%d, jailedtimes=%d, frozentimes=%d, banned=%d, bannedby='%s', logins=%d, posX=%f, posY=%f, posZ=%f, vworld=%d, interior=%d, bank=%d WHERE user='%s'",
		score,
		money,
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pVIP],
		PlayerInfo[playerid][pKMA],
		PlayerInfo[playerid][pRank],
		PlayerInfo[playerid][pKills],
		PlayerInfo[playerid][pDeaths],
		PlayerInfo[playerid][pMuted],
		PlayerInfo[playerid][pJailed],
		PlayerInfo[playerid][pFrozen],
		PlayerInfo[playerid][pMutedTimes],
		PlayerInfo[playerid][pJailedTimes],
		PlayerInfo[playerid][pFrozenTimes],
		PlayerInfo[playerid][pBanned],
		PlayerInfo[playerid][pAdmin],
		PlayerInfo[playerid][pBannedBy],
		PlayerInfo[playerid][pLogins],
		PlayerInfo[playerid][pPosX],
		PlayerInfo[playerid][pPosY],
		PlayerInfo[playerid][pPosZ],
		PlayerInfo[playerid][pVWorld],
		PlayerInfo[playerid][pInterior],
		PlayerInfo[playerid][pBank],
		pname);
        mysql_query(query);
        SavePlayerInventories(playerid);
    }
	return 1;
}

stock MySQL_Login(playerid)
{
    new query[300], pname[24], savingstring[20];
    GetPlayerName(playerid, pname, 24);
    format(query, sizeof(query), "SELECT score, money, level, admin, vip, tutorial, kma, rank, kills, deaths, muted, jailed, frozen, mutedtimes, jailedtimes, frozentimes, banned, bannedby, logins, posX, posY, posZ, vworld, interior, bank FROM playerdata WHERE user = '%s'", pname);
    mysql_query(query);
    mysql_store_result();
    while(mysql_fetch_row_format(query,"|"))
    {
        mysql_fetch_field_row(savingstring, "score"); SetPlayerScore(playerid, strval(savingstring));
        mysql_fetch_field_row(savingstring, "money"); MoneyGiven[playerid] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "level"); PlayerInfo[playerid][pLevel] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "admin"); PlayerInfo[playerid][pAdmin] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "vip"); PlayerInfo[playerid][pVIP] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "tutorial"); PlayerInfo[playerid][pTutorial] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "kma"); PlayerInfo[playerid][pKMA] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "rank"); PlayerInfo[playerid][pRank] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "kills"); PlayerInfo[playerid][pKills] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "deaths"); PlayerInfo[playerid][pDeaths] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "muted"); PlayerInfo[playerid][pMuted] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "jailed"); PlayerInfo[playerid][pJailed] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "frozen"); PlayerInfo[playerid][pFrozen] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "mutedtimes"); PlayerInfo[playerid][pMutedTimes] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "jailedtimes"); PlayerInfo[playerid][pJailedTimes] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "frozentimes"); PlayerInfo[playerid][pFrozenTimes] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "banned"); PlayerInfo[playerid][pBanned] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "bannedby"); PlayerInfo[playerid][pBannedBy] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "logins"); PlayerInfo[playerid][pLogins] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "posX"); PlayerInfo[playerid][pPosX] = floatstr(savingstring);
        mysql_fetch_field_row(savingstring, "posY"); PlayerInfo[playerid][pPosY] = floatstr(savingstring);
        mysql_fetch_field_row(savingstring, "posZ"); PlayerInfo[playerid][pPosZ] = floatstr(savingstring);
        mysql_fetch_field_row(savingstring, "vworld"); PlayerInfo[playerid][pVWorld] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "interior"); PlayerInfo[playerid][pInterior] = strval(savingstring);
        mysql_fetch_field_row(savingstring, "bank"); PlayerInfo[playerid][pBank] = strval(savingstring);
    }
    mysql_free_result();
    JustLogged[playerid] = 1;
    Logged[playerid] = 1;
    PlayerInfo[playerid][pLogins]++;
    return 1;
}

stock LoadPlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new query[256];
	format(query, 256, "SELECT * FROM itemdata WHERE user = '%s'", playername);
	mysql_query(query);
	mysql_store_result();
	new numrows = mysql_num_rows();
	mysql_free_result();
	if (numrows == 0)
	{
	    format(query, 256, "INSERT INTO itemdata (user) VALUES ('%s')", playername);
	    mysql_query(query);
	    for (new i = 1; i <= 15; i++)
	    {
		    format(query, 256, "UPDATE itemdata SET itemid_%d = 0, amount_%d = 0 WHERE user = '%s'", i, i, playername);
		    mysql_query(query);
	    }
	}
	new string[256], tmp[256];
	for (new i = 1; i <= 15; i++)
	{
		format(query, 256, "SELECT itemid_%d, amount_%d FROM itemdata WHERE user = '%s'", i, i, playername);
		mysql_query(query);
		mysql_store_result();
	    while (mysql_fetch_row_format(query, "|"))
	    {
	        format(string, 256, "itemid_%d", i); mysql_fetch_field_row(tmp, string); PlayerInventoryInfo[playerid][i - 1][piItemID] = strval(tmp);
			format(string, 256, "amount_%d", i); mysql_fetch_field_row(tmp, string); PlayerInventoryInfo[playerid][i - 1][piItemAmount] = strval(tmp);
	    }
	    mysql_free_result();
	}
	return 1;
}

stock SavePlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new query[256];
	format(query, 256, "SELECT * FROM itemdata WHERE user = '%s'", playername);
	mysql_query(query);
	mysql_store_result();
	new numrows = mysql_num_rows();
	mysql_free_result();
	if (numrows == 0)
	{
	    format(query, 256, "INSERT INTO itemdata (user) VALUES ('%s')", playername);
	    mysql_query(query);
	}
    for (new i = 1; i <= 15; i++)
    {
	    format(query, 256, "UPDATE itemdata SET itemid_%d = %d, amount_%d = %d WHERE user = '%s'",
			i, PlayerInventoryInfo[playerid][i - 1][piItemID],
			i, PlayerInventoryInfo[playerid][i - 1][piItemAmount],
			playername
		);
	    mysql_query(query);
    }
	return 1;
}

stock GetName(playerid)
{
	new pname[24];
	GetPlayerName(playerid, pname, 24);
	return pname;
}

stock GetWeaponNameEx(id, name[], len)
{
	return format(name,len, "%s", GunNames[id]);
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0) GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++)
	{
	    if(plyAmmo[sslot] != 0) GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock escpname(playerid)
{
    new escname[24], Pname[24];
    GetPlayerName(playerid, Pname, 24);
    mysql_real_escape_string(Pname, escname);
    return escname;
}

stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

stock GetVehicleSpeed(vehicleid, mph_kmph)
{
	new
		Float:X,
		Float:Y,
		Float:Z
	;
	GetVehicleVelocity(vehicleid, X, Y, Z);
	new Float:value = floatsqroot(floatpower(X, 2) + floatpower(Y, 2) + floatpower(Z, 2)) * 160.45714284;
	new speed;
	if (mph_kmph == VEHICLE_SPEED_MPH)
		speed = floatround(value / 1.60934);
	else if (mph_kmph == VEHICLE_SPEED_KMPH)
		speed = floatround(value);
	return speed;
}

stock MySQL_BanCheck(playerid)
{
	new query[200], admin[50], pname[50], IP[16], string1[100];
	GetPlayerIp(playerid, IP, 16);
	format(query, sizeof(query),"SELECT * FROM `bandata` WHERE(`player`='%s' OR `IP`='%s') AND `banned`=1 LIMIT 1", escpname(playerid), IP);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows() != 0)
	{
		while(mysql_fetch_row(query))
		{
			mysql_fetch_field_row(admin, "admin");
			mysql_fetch_field_row(pname, "player");
			mysql_fetch_field_row(string1, "reason");
		}
		new string[50], str[50], str1[100];
		format(string, sizeof(string),"Admin: %s", admin);
		format(str, sizeof(str),"Player: %s", pname);
		format(str1, sizeof(str1),"Reason: %s", string1);
		SendClientMessage(playerid, C_RED, "너 밴이야");
		SendClientMessage(playerid, C_RED, "___________________");
		SendClientMessage(playerid, C_RED, str);
		SendClientMessage(playerid, C_RED, string);
		SendClientMessage(playerid, C_RED, str1);
		SendClientMessage(playerid, C_RED, "___________________");
		Kick(playerid);
	}
	mysql_free_result();
	return 1;
}
