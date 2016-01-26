##Full run
use romaniastage;
drop table fd_csc_eg_player_product_info_summ;
CREATE TABLE `fd_csc_eg_player_product_info_summ` (
  `PlayerId` int(11) DEFAULT NULL,
  `SummaryDate` date DEFAULT NULL,
  `GameDate` datetime DEFAULT NULL,
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
  `ClientPlatform` varchar(100) DEFAULT NULL,
  `ClientType` varchar(100) DEFAULT NULL,
  `CasinoType` varchar(100) DEFAULT NULL,
  `GameType` varchar(100) DEFAULT NULL,
  `GameName` varchar(100) DEFAULT NULL,
  `RomDummy` int(11) DEFAULT NULL
) ENGINE=innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\mysql_fd_csc_eg_player_product_info_summ.csv'
INTO TABLE fd_csc_eg_player_product_info_summ FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\eg_player_first_last_totals.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniamain.eg_player_first_last_totals;

use romaniamain;
drop table eg_player_first_last_totals;
create table `eg_player_first_last_totals`(
	`PlayerId` bigint(20),
    `FirstCashBetDate` datetime DEFAULT NULL,
    `FirstCashBetAmt` decimal(18,4) DEFAULT NULL,
    `FirstCashBetChannel` varchar(20) DEFAULT NULL,
	`FirstBonusBetDate` datetime DEFAULT NULL,
    `FirstBonusBetAmt` decimal(18,4) DEFAULT NULL,
    `FirstBonusBetChannel` varchar(20) DEFAULT NULL,
    
	`FirstCashWinDate` datetime DEFAULT NULL,
    `FirstCashWinAmt` decimal(18,4) DEFAULT NULL,
    `FirstCashWinChannel` varchar(20) DEFAULT NULL,
	`FirstBonusWinDate` datetime DEFAULT NULL,
    `FirstBonusWinAmt` decimal(18,4) DEFAULT NULL,
    `FirstBonusWinChannel` varchar(20) DEFAULT NULL,
    
	`LastCashBetDate` datetime DEFAULT NULL,
    `LastCashBetAmt` decimal(18,4) DEFAULT NULL,
    `LastCashBetChannel` varchar(20) DEFAULT NULL,
	`LastBonusBetDate` datetime DEFAULT NULL,
    `LastBonusBetAmt` decimal(18,4) DEFAULT NULL,
    `LastBonusBetChannel` varchar(20) DEFAULT NULL,
    
	`LastCashWinDate` datetime DEFAULT NULL,
    `LastCashWinAmt` decimal(18,4) DEFAULT NULL,
    `LastCashWinChannel` varchar(20) DEFAULT NULL,
	`LastBonusWinDate` datetime DEFAULT NULL,
    `LastBonusWinAmt` decimal(18,4) DEFAULT NULL,
    `LastBonusWinChannel` varchar(20) DEFAULT NULL,
    
    `TotalBetAmt` decimal(18,4) DEFAULT NULL,
    `TotalCashBetAmount` decimal(18,4) DEFAULT NULL,
    `TotalBonusBetAmount` decimal(18,4) DEFAULT NULL,
    
	`TotalWinAmt` decimal(18,4) DEFAULT NULL,
    `TotalCashWinAmount` decimal(18,4) DEFAULT NULL,
    `TotalBonusWinAmount` decimal(18,4) DEFAULT NULL,
    
    `LastChannel` varchar(20) default null,
    `LastGamePlayDate` datetime default null,
    `LastPlayedCasinoType` varchar(100) default null,
    `LastPlayedGameType` varchar(100) default null,
    `LastPlayedGameName` varchar(100) default null,
    
    PRIMARY KEY (`PlayerId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\eg_player_first_last_totals.csv'
INTO TABLE eg_player_first_last_totals FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

commit;

insert into eg_player_first_last_totals
(
 PlayerId
,FirstCashBetDate
,FirstCashBetAmt
,FirstCashBetChannel
,FirstBonusBetDate
,FirstBonusBetAmt
,FirstBonusBetChannel
,FirstCashWinDate
,FirstCashWinAmt
,FirstCashWinChannel
,FirstBonusWinDate
,FirstBonusWinAmt
,FirstBonusWinChannel
,LastCashBetDate
,LastCashBetAmt
,LastCashBetChannel
,LastBonusBetDate
,LastBonusBetAmt
,LastBonusBetChannel
,LastCashWinDate
,LastCashWinAmt
,LastCashWinChannel
,LastBonusWinDate
,LastBonusWinAmt
,LastBonusWinChannel
,TotalBetAmt
,TotalCashBetAmount
,TotalBonusBetAmount
,TotalWinAmt
,TotalCashWinAmount
,TotalBonusWinAmount
,LastChannel
,LastGamePlayDate
,LastPlayedCasinoType
,LastPlayedGameType
,LastPlayedGameName
)
select
Playerid,
(case when CashBet > 0 then GameDate end) ,
(case when CashBet > 0 then CashBet else 0 end) ,
(case when CashBet > 0 then ClientPlatform end),
(case when BonusBet > 0 then GameDate end) ,
(case when BonusBet > 0 then BonusBet else 0 end) ,
(case when BonusBet > 0 then ClientPlatform end) ,

(case when CashWin > 0 then GameDate end) ,
(case when CashWin > 0 then CashWin else 0 end) ,
(case when CashWin > 0 then ClientPlatform end) ,
(case when BonusWin > 0 then GameDate end) ,
(case when BonusWin > 0 then BonusWin else 0 end) ,
(case when BonusWin > 0 then ClientPlatform end) ,

(case when CashBet > 0 then GameDate end) ,
(case when CashBet > 0 then CashBet else 0 end) ,
(case when CashBet > 0 then ClientPlatform end) ,
(case when BonusBet > 0 then GameDate end) ,
(case when BonusBet > 0 then BonusBet else 0 end) ,
(case when BonusBet > 0 then ClientPlatform end) ,

(case when CashWin > 0 then GameDate end) ,
(case when CashWin > 0 then CashWin else 0 end) ,
(case when CashWin > 0 then ClientPlatform end) ,
(case when BonusWin > 0 then GameDate end) ,
(case when BonusWin > 0 then BonusWin else 0 end) ,
(case when BonusWin > 0 then ClientPlatform end) ,

Bet,
CashBet,
BonusBet,
Win,
CashWin,
BonusWin,

ClientPlatform,
GameDate,
CasinoType,
GameType,
GameName
from romaniastage.fd_csc_eg_player_product_info_summ as src

on duplicate key update 

  FirstCashBetAmt = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0) , src.CashBet, FirstCashBetAmt)
, FirstCashBetChannel = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0), src.ClientPlatform, FirstCashBetChannel)
, FirstBonusBetAmt = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0) , src.BonusBet, FirstBonusBetAmt)
, FirstBonusBetChannel = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0) , src.ClientPlatform, FirstBonusBetChannel)

, FirstCashWinAmt = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0), src.CashWin, FirstCashWinAmt)
, FirstCashWinChannel = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0) , src.ClientPlatform, FirstCashWinChannel)
, FirstBonusWinAmt = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0), src.BonusWin, FirstBonusWinAmt)
, FirstBonusWinChannel = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0) , src.ClientPlatform, FirstBonusWinChannel)

, LastCashBetAmt = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0), src.CashBet, LastCashBetAmt)
, LastCashBetChannel = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0), src.ClientPlatform, LastCashBetChannel)
, LastBonusBetAmt = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0) , src.BonusBet, LastBonusBetAmt)
, LastBonusBetChannel = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0), src.ClientPlatform, LastBonusBetChannel)

, LastCashWinAmt = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0), src.CashWin, LastCashWinAmt)
, LastCashWinChannel = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0) , src.ClientPlatform, LastCashWinChannel)
, LastBonusWinAmt = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0), src.BonusWin, LastBonusWinAmt)
, LastBonusWinChannel = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0), src.ClientPlatform, LastBonusWinChannel)

, TotalBetAmt = TotalBetAmt + src.Bet
, TotalCashBetAmount = TotalCashBetAmount + src.CashBet
, TotalBonusBetAmount = TotalBonusBetAmount + src.BonusBet
, TotalWinAmt = TotalWinAmt + src.Win
, TotalCashWinAmount = TotalCashWinAmount + src.CashWin
, TotalBonusWinAmount = TotalBonusWinAmount + src.BonusWin

, LastChannel = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.ClientPlatform, LastChannel)
, LastPlayedCasinoType = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.CasinoType, LastPlayedCasinoType)
, LastPlayedGameType = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.GameType, LastPlayedGameType)
, LastPlayedGameName = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.GameName, LastPlayedGameName)

, FirstCashBetDate = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0), src.GameDate, FirstCashBetDate)
, FirstBonusBetDate = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0),src.GameDate,FirstBonusBetDate)
, FirstCashWinDate = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0),src.GameDate,FirstCashWinDate)
, FirstBonusWinDate = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0),src.GameDate,FirstBonusWinDate)
, LastCashBetDate = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0),src.GameDate,LastCashBetDate)
, LastBonusBetDate = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0),src.GameDate,LastBonusBetDate)
, LastCashWinDate = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0),src.GameDate,LastCashWinDate)
, LastBonusWinDate = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0),src.GameDate,LastBonusWinDate)
, LastGamePlayDate =  IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null),src.GameDate,LastGamePlayDate)

;

commit;

#select count(*) from eg_player_first_last_totals;
