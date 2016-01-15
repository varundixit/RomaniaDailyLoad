use romaniastage;
drop table stg_player_lifetime_apd;
CREATE TABLE `stg_player_lifetime_apd` (
  `PlayerID` bigint(20) DEFAULT NULL,
  `SystemAPD` int DEFAULT NULL,
  `SportsAPD` int DEFAULT NULL,
  `EGamingAPD` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerAPD_Daily.csv'
INTO TABLE romaniastage.stg_player_lifetime_apd FIELDS TERMINATED BY ';'  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*use romaniamain;
drop table f_player_lifetime_apd;
CREATE TABLE `f_player_lifetime_apd` (
  `PlayerID` bigint(20) ,
  `LTSystemAPD` int DEFAULT NULL,
  `LTSportsAPD` int DEFAULT NULL,
  `LTEGamingAPD` int DEFAULT NULL,
  PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;*/


insert into romaniamain.f_player_lifetime_apd
(
 PlayerID
,LTSystemAPD
,LTSportsAPD
,LTEGamingAPD
)
select 
PlayerID,
SystemAPD,
SportsAPD,
EGamingAPD
from romaniastage.stg_player_lifetime_apd as src
on duplicate key update 
LTSystemAPD = LTSystemAPD + src.SystemAPD,
LTSportsAPD = LTSportsAPD + src.SportsAPD,
LTEGamingAPD = LTEGamingAPD + src.EGamingAPD;


commit;