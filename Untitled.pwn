//============================================================================//
//                       Apocalypse Role Play By. Leehi                       //
//  1. MySQL 구축 - (2016. 10. 08)
//  2. 관리자 명령어 소량 추가 - (2016. 10. 12)
//============================================================================//
//============================================================================//
//                                  Includes                                  //
//============================================================================//

#include <a_samp>
#include <sscanf2>
#include <foreach>
#include <a_mysql>
#include <float>

//============================================================================//
//                                  Defines                                  //
//============================================================================//

#define SERVER_NAME     "The Apocalypse Role Play MySQL TEST"
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

#define DIALOG_REGISTER         100
#define DIALOG_LOGIN            101
#define DIALOG_INVENTORY_MAIN      	200
#define DIALOG_INVENTORY_USEDROP    201
#define maxobj 200 // Gun Object Limit
#define M_P 100
#define WEAPON_HACK 46

//============================================================================//
//                                  New's                                     //
//============================================================================//

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
    pInterior
}
//------------------------------------------------------------------------------
#define ITEM_TYPE_NONE 		0
#define ITEM_TYPE_WEAPON 	1
#define ITEM_TYPE_AMMO  	2

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
enum piInfo
{
	piItemID,
	piItemAmount
};

new PlayerInventoryInfo[MAX_PLAYERS][15][piInfo];
new PlayerInvIndex[MAX_PLAYERS];
//------------------------------------------------------------------------------
new PlayerInfo[MAX_PLAYERS][pInfo];
new MoneyGiven[MAX_PLAYERS];
new IsRegistered[MAX_PLAYERS];
new Logged[MAX_PLAYERS];
new JustLogged[MAX_PLAYERS];
new Text:Textdraw1;
new CheckIP[MAX_PLAYERS][16];
new Vint[MAX_VEHICLES];
new AcceptAdmin[MAX_PLAYERS];
new AdminChannel[MAX_PLAYERS];
new	g_VehTime[MAX_PLAYERS];
new bool:WeaponHack[MAX_PLAYERS][WEAPON_HACK];
new GWeapon[M_P];
new noooc = 0;
new gOoc[M_P];
new bool:Logined[MAX_PLAYERS] = { false, ... };
new bool:AutoSave = false;

main(){}

//============================================================================//
//                                  Forwards                                  //
//============================================================================//

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

//============================================================================//
//                                  Publics                                   //
//============================================================================//
public OnGameModeInit()
{
	Textdraw1 = TextDrawCreate(13.000000, 150.000000, "First Message");
	TextDrawBackgroundColor(Textdraw1, 255);
	TextDrawFont(Textdraw1, 1);
	TextDrawLetterSize(Textdraw1, 0.370000, 1.100000);
	TextDrawColor(Textdraw1, -1);
	TextDrawSetOutline(Textdraw1, 0);
	TextDrawSetProportional(Textdraw1, 1);
	TextDrawSetShadow(Textdraw1, 1);
	TextDrawUseBox(Textdraw1, 1);
	TextDrawBoxColor(Textdraw1, 255);
	TextDrawTextSize(Textdraw1, 278.000000, 36.000000);

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
    //                              Timer part                        //
    //================================================================//
	SetTimer("AutoSaveTimer", 30000, 1);
    //================================================================//
    //                              MySQL part                        //
    //================================================================//
    mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
    mysql_debug(1);
    mysql_set_charset("euckr");
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
    mysql_query("ALTER TABLE playerdata ADD IF NOT EXISTS (posX Float(20), posY Float(20), posZ Float(20),\
	vworld INT(10), interior INT(10))");
	//================================================================//
	new query[256];
	mysql_query("CREATE TABLE IF NOT EXISTS itemdata(user VARCHAR(24))");
	for (new a = 1; a <= 15; a++)
	{
	    format(query, 256, "ALTER TABLE itemdata ADD IF NOT EXISTS ( itemid_%d INT(10), amount_%d INT(10) )", a, a);
		mysql_query(query);
	}
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS bandata(admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS kickdata(year INT(20), month INT(20), day INT(20), hour INT(20), minute INT(20), second INT(20),\
	admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), kicked INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS spawndata(year INT(20), month INT(20), day INT(20), hour INT(20), minute INT(20), second INT(20),\
	admin VARCHAR(20), player VARCHAR(20), IP VARCHAR(16), Spawned INT(10))");
	//================================================================//
	mysql_query("CREATE TABLE IF NOT EXISTS hackdata(player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
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
	}
	print(" ");
	
	for (new i = 0; i < 300; i++)
	{
	    DroppedItem[i][diOjnum] = INVALID_OBJECT_ID;
		DroppedItem[i][diItemID] = 0;
		DroppedItem[i][diAmount] = 0;
		DroppedItem[i][diPos][0] = 0.0000;
		DroppedItem[i][diPos][1] = 0.0000;
		DroppedItem[i][diPos][2] = 0.0000;
		DroppedItem[i][diTime] = 0;
	}
	
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
public Tuto1(playerid)
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
}

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
	   	SetPlayerPos(playerid, 127.5622,-254.7439,1.5781);
		SetPlayerVirtualWorld(playerid, 1234);
		TogglePlayerControllable(playerid, 0);
	    SetTimerEx("Tuto1", 5000, false, "i", playerid);
		return 1;
	}
}

public OnPlayerConnect(playerid)
{
    new string[256];
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
	SetPlayerColor(playerid, 0xFFFFFFAA);//탭키 0xBFC0C200
    MySQL_BanCheck(playerid);
    RemoveUnderScore(playerid);
    TextDrawHideForPlayer(playerid, Textdraw1);
    Logined[playerid] = false;
    PlayerInvIndex[playerid] = -1;
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

public OnPlayerExitVehicle(playerid, vehicleid)
{
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
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
	if(weaponid > 0)
	{
	    if(WeaponHack[playerid][weaponid] == true)
	    {
	        SettimerEx("CheckAmount", 100, true, "iii",
	    }
		else
		{
			new string[154];
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

public CheckAmount(playerid, itemid, amount)
{
	new ammo = GetPlayerAmmo(playerid);
	new itemid = PlayerInventoryInfo[playerid][slot][piItemID];
	new index = -1;
	for (new i = 0; i < 15; i++)
	{
	    if (PlayerInventoryInfo[playerid][i][piItemID] == 4 && PlayerInventoryInfo[playerid][i][piItemAmount] > 0)
		{
		    index = i;
		    break;
		}
	}
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
		//ShowInventoryForPlayer(playerid, playerid);
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
    /*
	if(strcmp(cmd, "/버리기", true) == 0 || strcmp(cmd, "/떨구기", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, -1, "/버리기 슬롯번호");
		    return 1;
		}
		new slot = strval(tmp) - 1;
		if (slot < 0 || slot >= 15)
		{
			SendClientMessage(playerid, -1, "슬롯은 최대 15번까지 존재합니다.");
		    return 1;
		}
		
		new amount = 0;
		if (PlayerInventoryInfo[playerid][slot][piItemAmount] == 1)
		{
		    amount = 1;
		}
		else if (PlayerInventoryInfo[playerid][slot][piItemAmount] > 1)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/버리기 슬롯번호 수량");
			    return 1;
			}
			amount = strval(tmp);
		}
		
		if (PlayerInventoryInfo[playerid][slot][piItemID] > 0 && PlayerInventoryInfo[playerid][slot][piItemAmount] > 0)
		{
		    new itemid = PlayerInventoryInfo[playerid][slot][piItemID];
		    //new amount = PlayerInventoryInfo[playerid][slot][piAmount];
		    new modelid = ItemInfo[itemid][iModel];
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			
			new index = -1;
			for (new a = 0; a < 300; a ++)
			{
			    if (DroppedItem[a][diOjnum] == INVALID_OBJECT_ID)
			    {
			        index = a;
			        break;
			    }
			}
			if (index == -1)
			{
			    // 서버 최대 개수 초과
			    return 1;
			}
			else
			{
			    new result = DropItem(playerid, itemid, amount);
			    if (result == 1)
				{
				    DroppedItem[index][diOjnum] = CreateObject(modelid, X, Y, Z, 0.0000, 0.0000, 0.0000);
				    DroppedItem[index][diPos][0] = X;
				    DroppedItem[index][diPos][1] = Y;
				    DroppedItem[index][diPos][2] = Z;
				    DroppedItem[index][diItemID] = itemid;
				    DroppedItem[index][diAmount] = amount;
				    DroppedItem[index][diTime] = 1;
				    return 1;
			    }
			    else
			    {
			        return 1;
				}
			}
		}
	}
	if(strcmp(cmd, "/줍기", true) == 0 || strcmp(cmd, "/얻기", true) == 0)
	{
	    new index = -1;
		for (new a = 0; a < sizeof(DroppedItem); a++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3.0, DroppedItem[a][diPos][0], DroppedItem[a][diPos][1], DroppedItem[a][diPos][2]))
			{
			    index = a;
			    break;
			}
		}
		if(index == -1)
		{
			return SendClientMessage(playerid, C_WHITE, "바닥에 물건이 없음");
		}
		else
		{
		    new buffer[512];

			DestroyObject(DroppedItem[index][diOjnum]);
			GiveItem(playerid, DroppedItem[index][diItemID], DroppedItem[index][diAmount]);
			format(buffer, sizeof(buffer), "얻은 아이템: %s", DroppedItem[index][diItemID]);
			SendClientMessage(playerid, C_WHITE, buffer);
			
			DroppedItem[index][diOjnum] = INVALID_OBJECT_ID;
			DroppedItem[index][diPos][0] = 0.0;
			DroppedItem[index][diPos][1] = 0.0;
			DroppedItem[index][diPos][2] = 0.0;
			DroppedItem[index][diItemID] = 0;
			DroppedItem[index][diAmount] = 0;
			DroppedItem[index][diTime] = 0;

		}
		return 1;
	}
	*/
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
			//format(bquery, sizeof(bquery),"INSERT INTO kickdata(year, month, day, hour, minute, second, admin, player, reason, IP, kicked) VALUES('%d', '%d', '%d', '%d', '%d', '%d', '%s', '%s', '%s', 1)", year, month, day, hour, minute, second, PlayerName(playerid), PlayerName(targetid), reason, IP);
			/*
			
				1. 위의 쿼리문은 정수형 데이터에 [ ' ], 즉 작은따옴표를 사용한 부분에서 문제가 발생하였고 정정햇습니다.
				
				2. 쿼리에 필요한 문자열 데이터는 4개인데, 위의 쿼리문에 적힌 문자열 데이터는 3개였기 때문에 문제가 발생하였고 정정했습니다.
				
				3. 이후 저장된 데이터에 문자열에는 한글이 표시되지 않는 문제가 있으니 고려하시기 바랍니다.
				
				* 1번과 2번이 이해가 되지 않는다면, 위에 있는 주석으로 처리한 문장과 아래 새로 입력된 문장을 비교해보시기 바랍니다.
			
			*/
			format(bquery, sizeof(bquery),"INSERT INTO kickdata(year, month, day, hour, minute, second, admin, player, reason, IP, kicked) VALUES(%d, %d, %d, %d, %d, %d, '%s', '%s', '%s', '%s', 1)", year, month, day, hour, minute, second, PlayerName(playerid), PlayerName(targetid), reason, IP);
			mysql_query(bquery);
			format(string, sizeof(string),"%s 가 어드민 %s 에 의해 서버 종료 처리 되었습니다. [사유: %s]", PlayerName(targetid), PlayerName(playerid), reason);
			SendClientMessageToAll(C_RED, string);
			//mysql_free_result();
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
		SendClientMessage(playerid, -1, "/엠포, /관리자, /신고"); // /버리기, /줍기
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
//                                  Admin Commands                            //
//============================================================================//



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
	Vint[vehicleid] = intid;
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

/*
stock GiveItem(playerid, itemid, amount)
{
	new slot = -1;
	for (new i = 0; i < 15; i++)
	{
		if ((PlayerInventoryInfo[playerid][i][piItemID] == 0 && PlayerInventoryInfo[playerid][i][piItemAmount] == 0) ||
			(PlayerInventoryInfo[playerid][i][piItemID] == itemid && PlayerInventoryInfo[playerid][i][piItemAmount] > 0))
		{
		    slot = i;
		    break;
		}
	}
	if (slot == -1)
	{
	    SendClientMessage(playerid, -1, "인벤토리에 공간이 없음");
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
	for (new i = 0; i < 15; i++)
	{
		if (PlayerInventoryInfo[playerid][i][piItemID] == itemid && PlayerInventoryInfo[playerid][i][piItemAmount] >= amount)
		{
		    slot = i;
		    break;
		}
	}
	if (slot == -1)
	{
	    SendClientMessage(playerid, -1, "인벤토리에 없거나 버리려는 수량이 더 많아 버릴 수 없음");
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

stock ShowInventoryForPlayer(playerid, showplayerid)
{
	new info[2048], str[256];
	new tmp[256];
	new itmp = -1;
	for (new i = 0; i < 15; i++)
	{
		if (PlayerInventoryInfo[playerid][i][piItemID] != 0) // 0번은 없는 아이템
		{
			itmp ++;
			format(tmp, 256, "InventoryListID_%d", itmp); // 이부분 쿼리로 교체해야 하지 않아요? 그런 기능으로 작동하는 문장이 아닙니다
			SetPVarInt(playerid, tmp, i);
			format(
				str, 256, "[이름] %s [수량] %d\n",
				ItemInfo[PlayerInventoryInfo[playerid][i][piItemID]][iName],
				PlayerInventoryInfo[playerid][i][piItemAmount]
			);
			strcat(info, str);
	    }
	}
	if (itmp == -1)
	{
	    ShowPlayerDialog(showplayerid, 0, DIALOG_STYLE_MSGBOX, "인벤토리", "인벤토리가 비어있습니다.", "닫기", "");
	}
	else
	{
		ShowPlayerDialog(showplayerid, DIALOG_INVENTORY_MAIN, DIALOG_STYLE_LIST, "인벤토리", info, "선택하기", "닫기");
	}
	return 1;
}
*/
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
	/*
	if (items > 0)
	{
	    ShowPlayerDialog(playerid, DIALOG_INVENTORY_MAIN, DIALOG_STYLE_LIST, "인벤토리", info, "선택하기", "닫기");
	}
	else
	{
	    ShowPlayerDialog(playerid, DIALOG_INVENTORY_MAIN, DIALOG_STYLE_MSGBOX, "인벤토리", "인벤토리가 비어있습니다.", "닫기", "");
	}
	*/
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
	WeaponHack[playerid][weaponid] = true; // 해당 weaponid번호의 값을 WeaponHack변수에 true값을 해줌.
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
    //format(query, sizeof(query), "INSERT INTO playerdata (user, password, score, money, level, admin, vip, tutorial, kma, rank, kills, deaths, muted, jailed, frozen, mutedtimes, jailedtimes, frozentimes, banned, bannedby, logins, PosX, PosY, PosZ, vworld, interior, IP) VALUES('%s', SHA1('%s'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '%s', 0, 0, 0, 0, 0, 0, '%s')", pname, passwordstring, Bannedby, IP);
    format(query, sizeof(query), "INSERT INTO playerdata (user, password, score, money, level, admin, vip, tutorial, kma, rank, kills, deaths, jailedtimes, frozentimes, banned, bannedby, logins, PosX, PosY, PosZ, vworld, interior, IP) VALUES('%s', SHA1('%s'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '%s', 0, 0, 0, 0, 0, 0, '%s')", pname, passwordstring, Bannedby, IP);
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
        format(query, sizeof(query), "UPDATE playerdata SET score=%d, admin=%d, money=%d, level=%d, vip=%d, kma=%d, rank=%d, kills=%d, deaths=%d, muted=%d, jailed=%d, frozen=%d, mutedtimes=%d, jailedtimes=%d, frozentimes=%d, banned=%d, bannedby='%s', logins=%d, posX=%f, posY=%f, posZ=%f, vworld=%d, interior=%d WHERE user='%s'",
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
    format(query, sizeof(query), "SELECT score, money, level, admin, vip, tutorial, kma, rank, kills, deaths, muted, jailed, frozen, mutedtimes, jailedtimes, frozentimes, banned, bannedby, logins, posX, posY, posZ, vworld, interior FROM playerdata WHERE user = '%s'", pname);
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
    }
    mysql_free_result();
    JustLogged[playerid] = 1;
    Logged[playerid] = 1;
    PlayerInfo[playerid][pLogins]++;
    return 1;
}

stock LoadPlayerInventories(playerid) // 쿼리로 바꿀 것
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

stock SavePlayerInventories(playerid) // 쿼리로 바꿀 것
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

stock RemovePlayerWeapon(playerid, weaponid);
public RemovePlayerWeapon(playerid, weaponid)
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


