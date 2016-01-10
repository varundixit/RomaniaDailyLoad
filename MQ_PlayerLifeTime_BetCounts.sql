use romaniastage;
drop table stg_player_daily_betcount;
CREATE TABLE `stg_player_daily_betcount` (
  `PlayerID` bigint(20) DEFAULT NULL,
  `SportsBetCount` int DEFAULT NULL,
  `EgBetCount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerBetCounts_Daily.csv'
INTO TABLE romaniastage.stg_player_daily_betcount FIELDS TERMINATED BY ';'  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;


#use romaniamain;
#drop table f_player_lifetime_betcounts;
CREATE TABLE `f_player_lifetime_betcounts` (
  `PlayerID` bigint(20) ,
  `LTSportsBetCount` int DEFAULT NULL,
  `LTEgBetCount` int DEFAULT NULL,
  PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into romaniamain.f_player_lifetime_betcounts
(
 PlayerID
,LTSportsBetCount
,LTEgBetCount
)
select 
PlayerID,
SportsBetCount,
EgBetCount
from romaniastage.stg_player_daily_betcount as src
on duplicate key update 
LTSportsBetCount = LTSportsBetCount + src.SportsBetCount,
LTEgBetCount = LTEgBetCount + src.EgBetCount;

commit;