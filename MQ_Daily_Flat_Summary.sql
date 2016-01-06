use romaniastage;
drop table `stg_dim_player`;
CREATE TABLE `stg_dim_player` (
  `PlayerID` bigint(20),
  `Username` varchar(100),
  `Gender` varchar(5) DEFAULT NULL,
  `Balance` decimal(18,6) DEFAULT NULL,
  `GlobalFirstDepositDate` datetime,
  `SignupDate` datetime,
  `RomDummy` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\mysql_dim_player.csv'
INTO TABLE romaniastage.stg_dim_player FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
;

select
p.*,
gv.*,
cv.*,
eg.*
from
romaniastage.stg_dim_player as p
left outer join romaniamain.sp_gv_player_first_last as gv on p.PlayerID = gv.PlayerId
left outer join romaniamain.sp_cv_player_first_last_totals as cv on p.PlayerID = cv.PlayerId
left outer join romaniamain.eg_player_first_last_totals as eg on p.PlayerID = eg.PlayerId
;