##Full Run
use romaniastage;
Drop table stg_sp_gv_player_first_last;
CREATE TABLE `stg_sp_gv_player_first_last` ( 
 PlayerId bigint(20) NOT NULL
,BetTime datetime NOT NULL
,Channel varchar(20)
,BetClass varchar(20)
,BetType varchar(20)
,BetslipId bigint(20) NOT NULL
,BetId bigint(20) NOT NULL
,BetSlipStatus varchar(20)
,LiveYN varchar(20)
,SelectionName varchar(500)
,MarketName varchar(500)
,EventName varchar(500)
,TypeName varchar(500)
,ClassName varchar(500)
,Sport varchar(500)
,Odds varchar(20)
,StakeAmt decimal(18,6) DEFAULT NULL
,CashStakeAmt decimal(18,6) DEFAULT NULL
,BonusStakeAmt decimal(18,6) DEFAULT NULL
,BonusBalanceStake decimal(18,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_sgl.csv'
INTO TABLE romaniastage.stg_sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_combi.csv'
INTO TABLE romaniastage.stg_sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

commit;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_gv_player_first_last.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniamain.sp_gv_player_first_last;

use romaniamain;
Drop table sp_gv_player_first_last;
CREATE TABLE `sp_gv_player_first_last` ( 
 PlayerId bigint(20) NOT NULL
,SglLvFirstBetTime datetime DEFAULT NULL
,SglLvFirstChannel varchar(20) DEFAULT NULL
,SglLvFirstSelectionName varchar(500) DEFAULT NULL
,SglLvFirstMarketName varchar(500) DEFAULT NULL
,SglLvFirstEventName varchar(500) DEFAULT NULL
,SglLvFirstTypeName varchar(500) DEFAULT NULL
,SglLvFirstClassName varchar(500) DEFAULT NULL
,SglLvFirstSport varchar(500) DEFAULT NULL
,SglLvFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglPmFirstBetTime datetime DEFAULT NULL
,SglPmFirstChannel varchar(20) DEFAULT NULL
,SglPmFirstSelectionName varchar(500) DEFAULT NULL
,SglPmFirstMarketName varchar(500) DEFAULT NULL
,SglPmFirstEventName varchar(500) DEFAULT NULL
,SglPmFirstTypeName varchar(500) DEFAULT NULL
,SglPmFirstClassName varchar(500) DEFAULT NULL
,SglPmFirstSport varchar(500) DEFAULT NULL
,SglPmFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,CmbFirstBetTime datetime DEFAULT NULL
,CmbFirstChannel varchar(20) DEFAULT NULL
,CmbFirstSelectionName varchar(500) DEFAULT NULL
,CmbFirstMarketName varchar(500) DEFAULT NULL
,CmbFirstEventName varchar(500) DEFAULT NULL
,CmbFirstTypeName varchar(500) DEFAULT NULL
,CmbFirstClassName varchar(500) DEFAULT NULL
,CmbFirstSport varchar(500) DEFAULT NULL
,CmbFirstCashStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglLvLastBetTime datetime DEFAULT NULL
,SglLvLastChannel varchar(20) DEFAULT NULL
,SglLvLastSelectionName varchar(500) DEFAULT NULL
,SglLvLastMarketName varchar(500) DEFAULT NULL
,SglLvLastEventName varchar(500) DEFAULT NULL
,SglLvLastTypeName varchar(500) DEFAULT NULL
,SglLvLastClassName varchar(500) DEFAULT NULL
,SglLvLastSport varchar(500) DEFAULT NULL
,SglLvLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglPmLastBetTime datetime DEFAULT NULL
,SglPmLastChannel varchar(20) DEFAULT NULL
,SglPmLastSelectionName varchar(500) DEFAULT NULL
,SglPmLastMarketName varchar(500) DEFAULT NULL
,SglPmLastEventName varchar(500) DEFAULT NULL
,SglPmLastTypeName varchar(500) DEFAULT NULL
,SglPmLastClassName varchar(500) DEFAULT NULL
,SglPmLastSport varchar(500) DEFAULT NULL
,SglPmLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,CmbLastBetTime datetime DEFAULT NULL
,CmbLastChannel varchar(20) DEFAULT NULL
,CmbLastSelectionName varchar(500) DEFAULT NULL
,CmbLastMarketName varchar(500) DEFAULT NULL
,CmbLastEventName varchar(500) DEFAULT NULL
,CmbLastTypeName varchar(500) DEFAULT NULL
,CmbLastClassName varchar(500) DEFAULT NULL
,CmbLastSport varchar(500) DEFAULT NULL
,CmbLastCashStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_gv_player_first_last.csv'
INTO TABLE sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

insert into sp_gv_player_first_last
(
 PlayerId
,SglLvFirstBetTime
,SglLvFirstChannel
,SglLvFirstSelectionName
,SglLvFirstMarketName
,SglLvFirstEventName
,SglLvFirstTypeName
,SglLvFirstClassName
,SglLvFirstSport
,SglLvFirstCashStkAmt
,SglLvFirstBonusStkAmt
,SglLvFirstBonusBalStkAmt
,SglPmFirstBetTime
,SglPmFirstChannel
,SglPmFirstSelectionName
,SglPmFirstMarketName
,SglPmFirstEventName
,SglPmFirstTypeName
,SglPmFirstClassName
,SglPmFirstSport
,SglPmFirstCashStkAmt
,SglPmFirstBonusStkAmt
,SglPmFirstBonusBalStkAmt
,CmbFirstBetTime
,CmbFirstChannel
,CmbFirstSelectionName
,CmbFirstMarketName
,CmbFirstEventName
,CmbFirstTypeName
,CmbFirstClassName
,CmbFirstSport
,CmbFirstCashStkAmt
,CmbFirstBonusStkAmt
,CmbFirstBonusBalStkAmt
,SglLvLastBetTime
,SglLvLastChannel
,SglLvLastSelectionName
,SglLvLastMarketName
,SglLvLastEventName
,SglLvLastTypeName
,SglLvLastClassName
,SglLvLastSport
,SglLvLastCashStkAmt
,SglLvLastBonusStkAmt
,SglLvLastBonusBalStkAmt
,SglPmLastBetTime
,SglPmLastChannel
,SglPmLastSelectionName
,SglPmLastMarketName
,SglPmLastEventName
,SglPmLastTypeName
,SglPmLastClassName
,SglPmLastSport
,SglPmLastCashStkAmt
,SglPmLastBonusStkAmt
,SglPmLastBonusBalStkAmt
,CmbLastBetTime
,CmbLastChannel
,CmbLastSelectionName
,CmbLastMarketName
,CmbLastEventName
,CmbLastTypeName
,CmbLastClassName
,CmbLastSport
,CmbLastCashStkAmt
,CmbLastBonusStkAmt
,CmbLastBonusBalStkAmt
)

select
 PlayerId
,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end

,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end

,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end

from
romaniastage.stg_sp_gv_player_first_last as src

on duplicate key update 

  SglLvFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Channel,SglLvFirstChannel)
, SglLvFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.SelectionName,SglLvFirstSelectionName)
, SglLvFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.MarketName,SglLvFirstMarketName)
, SglLvFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.EventName,SglLvFirstEventName)
, SglLvFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.TypeName,SglLvFirstTypeName)
, SglLvFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.ClassName,SglLvFirstClassName)
, SglLvFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Sport,SglLvFirstSport)
, SglLvFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashStakeAmt,SglLvFirstCashStkAmt)
, SglLvFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusStakeAmt,SglLvFirstBonusStkAmt)
, SglLvFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceStake,SglLvFirstBonusBalStkAmt)

, SglPmFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Channel,SglPmFirstChannel)
, SglPmFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.SelectionName,SglPmFirstSelectionName)
, SglPmFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.MarketName,SglPmFirstMarketName)
, SglPmFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.EventName,SglPmFirstEventName)
, SglPmFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.TypeName,SglPmFirstTypeName)
, SglPmFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.ClassName,SglPmFirstClassName)
, SglPmFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Sport,SglPmFirstSport)
, SglPmFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashStakeAmt,SglPmFirstCashStkAmt)
, SglPmFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusStakeAmt,SglPmFirstBonusStkAmt)
, SglPmFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceStake,SglPmFirstBonusBalStkAmt)

, CmbFirstChannel = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Channel,CmbFirstChannel)
, CmbFirstSelectionName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.SelectionName,CmbFirstSelectionName)
, CmbFirstMarketName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.MarketName,CmbFirstMarketName)
, CmbFirstEventName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.EventName,CmbFirstEventName)
, CmbFirstTypeName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.TypeName,CmbFirstTypeName)
, CmbFirstClassName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.ClassName,CmbFirstClassName)
, CmbFirstSport = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Sport,CmbFirstSport)
, CmbFirstCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashStakeAmt,CmbFirstCashStkAmt)
, CmbFirstBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusStakeAmt,CmbFirstBonusStkAmt)
, CmbFirstBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceStake,CmbFirstBonusBalStkAmt)

, SglLvLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Channel,SglLvLastChannel)
, SglLvLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.SelectionName,SglLvLastSelectionName)
, SglLvLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.MarketName,SglLvLastMarketName)
, SglLvLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.EventName,SglLvLastEventName)
, SglLvLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.TypeName,SglLvLastTypeName)
, SglLvLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.ClassName,SglLvLastClassName)
, SglLvLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Sport,SglLvLastSport)
, SglLvLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashStakeAmt,SglLvLastCashStkAmt)
, SglLvLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusStakeAmt,SglLvLastBonusStkAmt)
, SglLvLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceStake,SglLvLastBonusBalStkAmt)

, SglPmLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Channel,SglPmLastChannel)
, SglPmLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.SelectionName,SglPmLastSelectionName)
, SglPmLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.MarketName,SglPmLastMarketName)
, SglPmLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.EventName,SglPmLastEventName)
, SglPmLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.TypeName,SglPmLastTypeName)
, SglPmLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.ClassName,SglPmLastClassName)
, SglPmLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Sport,SglPmLastSport)
, SglPmLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashStakeAmt,SglPmLastCashStkAmt)
, SglPmLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusStakeAmt,SglPmLastBonusStkAmt)
, SglPmLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceStake,SglPmLastBonusBalStkAmt)

, CmbLastChannel = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Channel,CmbLastChannel)
, CmbLastSelectionName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.SelectionName,CmbLastSelectionName)
, CmbLastMarketName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.MarketName,CmbLastMarketName)
, CmbLastEventName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.EventName,CmbLastEventName)
, CmbLastTypeName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.TypeName,CmbLastTypeName)
, CmbLastClassName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.ClassName,CmbLastClassName)
, CmbLastSport = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Sport,CmbLastSport)
, CmbLastCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashStakeAmt,CmbLastCashStkAmt)
, CmbLastBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusStakeAmt,CmbLastBonusStkAmt)
, CmbLastBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceStake,CmbLastBonusBalStkAmt)


, SglLvFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BetTime,SglLvFirstBetTime)
, SglPmFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BetTime,SglPmFirstBetTime)
, CmbFirstBetTime = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BetTime,CmbFirstBetTime)
, SglLvLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BetTime,SglLvLastBetTime)
, SglPmLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BetTime,SglPmLastBetTime)
, CmbLastBetTime = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BetTime,CmbLastBetTime)

;

commit;


#select count(*) from sp_gv_player_first_last;