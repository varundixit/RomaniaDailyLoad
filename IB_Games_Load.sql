##date change 2016-01-05
use romaniastg;

select count(*) from romaniamain.DIM_CLIENT_PARAMETER;#165
select count(*) from romaniamain.dim_game_list;#2030

use romaniamain;
drop table DIM_CLIENT_PARAMETER;
create table `DIM_CLIENT_PARAMETER` (
  ClientPlatform varchar(200)
, ClientType varchar(200)
, ClientParameterCode int
, UsedInAdRevenue int
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\DIM_CLIENT_PARAMETER.csv' 
INTO TABLE  romaniamain.DIM_CLIENT_PARAMETER
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

use romaniastg;
drop table `stg_game_list`;
CREATE TABLE `stg_game_list` (
 ATTRIBUTES varchar(200)
,COIN varchar(200)
,DESCRIPTION varchar(500)
,EARNINGPOTENTIAL decimal(18,6)
,FROZEN int
,GAMEGROUP varchar(200)
,GAMETYPE varchar(200)
,HASMARVELJACKPOT varchar(10)
,HASSIDEGAMES varchar(10)
,JACKPOTRATIO decimal(18,0)
,JACKPOTSEED decimal(18,0)
,LIVEGAME int
,LIVEGAMEGROUP varchar(50)
,LONGNAME varchar(500)
,MOBILEGAME int 
,MPGAMEGROUP varchar(50)
,NAME varchar(500)
,NMGAMECODE  bigint(20)
,PHPCLASSNAME varchar(500)
,SHORTNAME varchar(50)
,SIDEGAME int
,SLOTLINES int
,TYPE varchar(20)
,USEBONUS int
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\DIM_GAME_LIST.csv' 
INTO TABLE  stg_game_list
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
 ATTRIBUTES
,COIN
,DESCRIPTION
,EARNINGPOTENTIAL
,FROZEN
,GAMEGROUP
,GAMETYPE
,HASMARVELJACKPOT
,HASSIDEGAMES
,JACKPOTRATIO
,JACKPOTSEED
,LIVEGAME
,LIVEGAMEGROUP
,LONGNAME
,MOBILEGAME
,MPGAMEGROUP
,NAME
,NMGAMECODE
,PHPCLASSNAME
,SHORTNAME
,SIDEGAME
,SLOTLINES
,TYPE
,USEBONUS
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\dim_game_list.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_game_list;

use romaniamain;
drop table `dim_game_list`;
CREATE TABLE `dim_game_list` (
 ATTRIBUTES varchar(200)
,COIN varchar(200)
,DESCRIPTION varchar(500)
,EARNINGPOTENTIAL decimal(18,6)
,FROZEN int
,GAMEGROUP varchar(200)
,GAMETYPE varchar(200)
,HASMARVELJACKPOT varchar(10)
,HASSIDEGAMES varchar(10)
,JACKPOTRATIO decimal(18,0)
,JACKPOTSEED decimal(18,0)
,LIVEGAME int
,LIVEGAMEGROUP varchar(50)
,LONGNAME varchar(500)
,MOBILEGAME int 
,MPGAMEGROUP varchar(50)
,NAME varchar(500)
,NMGAMECODE  bigint(20)
,PHPCLASSNAME varchar(500)
,SHORTNAME varchar(50)
,SIDEGAME int
,SLOTLINES int
,TYPE varchar(20)
,USEBONUS int
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\dim_game_list.csv' 
INTO TABLE  romaniamain.dim_game_list
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


use romaniastg;
DROP TABLE STG_GAMES_CSV;
CREATE TABLE `STG_GAMES_CSV` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `GameDate` varchar(200) DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerCode` int(11) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\Curl_Games2016-01-05.csv' 
INTO TABLE STG_GAMES_CSV
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select 
 coalesce(AccumulatedBetRefund,0)
,coalesce(Autoplay,0)
,coalesce(Balance,0)
,coalesce(Bet,0)
,coalesce((Bet - BonusBet),0)
,coalesce(BetExcludingTie,0)
,coalesce(BetRefund,0)
,BGType
,coalesce(BonusBalance,0)
,coalesce(BonusBet,0)
,coalesce(BonusCode,0)
,coalesce(BonusFG,0)
,coalesce(BonusJackpotWin,0)
,BonusType
,coalesce(BonusWageringAmount,0)
,coalesce(BonusWin,0)
,coalesce(ChannelCode,0)
,coalesce(ClientParameterCode,0)
,coalesce(Code,0)
,CoinSize
,coalesce(CompPointsBalance,0)
,coalesce(CompsAmount,0)
,coalesce(CurrentBet,0)
,coalesce(CurrentBonusBet,0)
,coalesce(DealerCode,0)
,coalesce(DEVICEContextCode,0)
,coalesce(FGWinAmount,0)
,str_to_date(GameDate, '%Y-%m-%d %H:%i:%s')
,GameID
,Info
,coalesce(InitialBet,0)
,coalesce(JackpotBet,0)
,coalesce(JackpotWin,0)
,coalesce(LiveGameTableCode,0)
,coalesce(LiveNetworkCode,0)
,coalesce(LPWin,0)
,coalesce(MPGameCode,0)
,coalesce(ParentGameCode,0)
,ParentGameDate
,coalesce(PendingBonusCode,0)
,coalesce(PlayerCode,0)
,RecordID
,RemoteIP
,SessionID
,SlotLines
,SPWin
,coalesce(TurnoverCommissionAllocation,0)
,TurnoverCommissionType
,Type
,coalesce(WageringBonusCode,0)
,coalesce(WageringPendingBonusCode,0)
,coalesce(Win,0)
,coalesce((Win - BonusWin),0)
,coalesce(WindowCode,0)
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\STG_Games_MySQL.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from STG_GAMES_CSV;

DROP TABLE STG_GAMES;
CREATE TABLE `STG_GAMES` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `CashBet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `GameDate` datetime DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerId` int(11) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `CashWin` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\STG_Games_MySQL.csv' 
INTO TABLE STG_GAMES
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select count(1) from STG_GAMES where date(GameDate) = '2016-01-05';

#use romaniamain;
#DROP TABLE FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM;
CREATE TABLE `FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `CashBet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `SummaryDate` date default null,
   `GameDate` datetime DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerId` int(11) DEFAULT NULL,
   `CurrencyCode` varchar(50) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `CashWin` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL,
   `ClientPlatform` varchar(100) default null,
   `ClientType` varchar(100) default null,
   `CasinoType` varchar(100) default null,
   `GameType` varchar(100) default null,
   `GameName` varchar(100) default null,
   `RomDummy` int
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
 use romaniastg;
 select 
  stg.AccumulatedBetRefund
, stg.Autoplay
, stg.Balance
, stg.Bet
, stg.CashBet
, stg.BetExcludingTie
, stg.BetRefund
, stg.BGType
, stg.BonusBalance
, stg.BonusBet
, stg.BonusCode
, stg.BonusFG
, stg.BonusJackpotWin
, stg.BonusType
, stg.BonusWageringAmount
, stg.BonusWin
, stg.ChannelCode
, stg.ClientParameterCode
, stg.Code
, stg.CoinSize
, stg.CompPointsBalance
, stg.CompsAmount
, stg.CurrentBet
, stg.CurrentBonusBet
, stg.DealerCode
, stg.DEVICEContextCode
, stg.FGWinAmount
, date(stg.GameDate)
, stg.GameDate
, stg.GameID
, stg.Info
, stg.InitialBet
, stg.JackpotBet
, stg.JackpotWin
, stg.LiveGameTableCode
, stg.LiveNetworkCode
, stg.LPWin
, stg.MPGameCode
, stg.ParentGameCode
, stg.ParentGameDate
, stg.PendingBonusCode
, stg.PlayerId
, p.CurrencyCode
, stg.RecordID
, stg.RemoteIP
, stg.SessionID
, stg.SlotLines
, stg.SPWin
, stg.TurnoverCommissionAllocation
, stg.TurnoverCommissionType
, stg.Type
, stg.WageringBonusCode
, stg.WageringPendingBonusCode
, stg.Win
, stg.CashWin
, stg.WindowCode
, cp.ClientPlatform
, cp.ClientType
, dgt.Description as CasinoType
, dgt.GameType as GameType
, dgt.Name as GameName
, 1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from STG_Games as stg
join romaniamain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join romaniamain.dim_game_list as dgt on stg.Type = dgt.Type
join romaniamain.dim_player as p on stg.PlayerId = p.PlayerID
#join romaniamain.dd_exchange_rate as ex on p.CurrencyCode = ex.CurrencyCode
where date(stg.GameDate) <= '2016-01-05';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#use romaniamain;
#DROP TABLE FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM;
CREATE TABLE `FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM` (
   `PlayerId` int(11) DEFAULT NULL,
   `SummaryDate` date default null,
   `GameDate` datetime DEFAULT NULL,
   `CurrencyCode` varchar(50) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `CashBet` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `CashWin` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `BonusFreeGamesCount` decimal(18,4) DEFAULT NULL,
   `FreeGamesCount` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `ClientPlatform` varchar(100) default null,
   `ClientType` varchar(100) default null,
   `CasinoType` varchar(100) default null,
   `GameType` varchar(100) default null,
   `GameName` varchar(100) default null,
   `RomDummy` int
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

use romaniastg;
select 
 stg.PlayerId
,date(stg.GameDate)
,stg.GameDate
, p.CurrencyCode
,stg.Bet
,stg.CashBet
,stg.BonusBet
,stg.Win
,stg.CashWin
,stg.BonusWin
,stg.BonusFG as BonusFreeGamesCount
,stg.FGWinAmount as FreeGamesCount
,stg.JackpotBet
,stg.JackpotWin
,cp.ClientPlatform
,CP.ClientType
,dgt.Description
,dgt.GameType
,dgt.Name
, 1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from STG_Games as stg
join romaniamain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join romaniamain.dim_game_list as dgt on stg.Type = dgt.Type
join romaniamain.dim_player as p on stg.PlayerId = p.PlayerID
where date(stg.GameDate) <= '2016-01-05';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
PlayerId,
SummaryDate,
CurrencyCode,
SUM(Bet),
SUM(CashBet),
SUM(BonusBet),
SUM(Win),
SUM(CashWin),
SUM(BonusWin),
SUM(BonusFreeGamesCount),
SUM(FreeGamesCount),
SUM(JackpotBet),
SUM(JackpotWin)
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\sd_cv_eg_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
where SummaryDate = '2016-01-05'
group by
PlayerId,
SummaryDate,
CurrencyCode;


#use romaniamain;
#drop table sd_eg_daily_player_summary;
create table `sd_eg_daily_player_summary` (
	PlayerId bigint(20) DEFAULT NULL
,	SummaryDate date DEFAULT NULL
,	CurrencyCode varchar(10) DEFAULT NULL
,	Bet decimal(18,4) DEFAULT NULL
,	CashBet decimal(18,4) DEFAULT NULL
,	BonusBet decimal(18,4) DEFAULT NULL
,	Win decimal(18,4) DEFAULT NULL
,	CashWin decimal(18,4) DEFAULT NULL
,	BonusWin decimal(18,4) DEFAULT NULL
,	BonusFreeGamesCount decimal(18,4) DEFAULT NULL
,	FreeGamesCount decimal(18,4) DEFAULT NULL
,	JackpotBet decimal(18,4) DEFAULT NULL
,	JackpotWin decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\sd_cv_eg_daily_player_summary.csv' 
INTO TABLE romaniamain.sd_eg_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select  
 PlayerId
,SummaryDate
,GameDate
,coalesce(Bet,0)
,coalesce(CashBet,0)
,coalesce(BonusBet,0)
,coalesce(Win,0)
,coalesce(CashWin,0)
,coalesce(BonusWin,0)
,coalesce(BonusFreeGamesCount,0)
,coalesce(FreeGamesCount,0)
,coalesce(JackpotBet,0)
,coalesce(JackpotWin,0)
,ClientPlatform
,ClientType
,CasinoType
,GameType
,GameName
,RomDummy 
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\mysql_fd_csc_eg_player_product_info_summ.csv' 
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
from  romaniamain.fd_csc_eg_player_product_info_summ 
where SummaryDate = '2016-01-05';
