use romaniastage;
Drop table stg_sp_cv_player_first_last;
CREATE TABLE `stg_sp_cv_player_first_last` ( 
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
,TotalStakeAmt decimal(18,6) DEFAULT NULL
,CashStakeAmt decimal(18,6) DEFAULT NULL
,BonusStakeAmt decimal(18,6) DEFAULT NULL
,BonusBalanceStake decimal(18,6) DEFAULT NULL
,TotalReturn decimal(18,6) DEFAULT NULL
,CashReturn decimal(18,6) DEFAULT NULL
,BonusBalanceReturn decimal(18,6) DEFAULT NULL
,CashRefund decimal(18,6) DEFAULT NULL
,BonusBalanceRefund decimal(18,6) DEFAULT NULL
,TokenRefund decimal(18,6) DEFAULT NULL
,CashOutStake decimal(18,6) DEFAULT NULL
,CashOutWin decimal(18,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_sgl.csv'
INTO TABLE romaniastage.stg_sp_cv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_combi.csv'
INTO TABLE romaniastage.stg_sp_cv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;


select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_cv_player_first_last_totals.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.sp_cv_player_first_last_totals;

use romaniamain;
Drop table sp_cv_player_first_last_totals;
CREATE TABLE `sp_cv_player_first_last_totals` ( 
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
,SglLvFirstCashReturn decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,SglLvFirstCashRefund decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,SglLvFirstTokenRefund decimal(18,6) DEFAULT NULL
,SglLvFirstCashOutStk decimal(18,6) DEFAULT NULL
,SglLvFirstCashOutWin decimal(18,6) DEFAULT NULL

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
,SglPmFirstCashReturn decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,SglPmFirstCashRefund decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,SglPmFirstTokenRefund decimal(18,6) DEFAULT NULL
,SglPmFirstCashOutStk decimal(18,6) DEFAULT NULL
,SglPmFirstCashOutWin decimal(18,6) DEFAULT NULL

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
,CmbFirstCashReturn decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,CmbFirstCashRefund decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,CmbFirstTokenRefund decimal(18,6) DEFAULT NULL
,CmbFirstCashOutStk decimal(18,6) DEFAULT NULL
,CmbFirstCashOutWin decimal(18,6) DEFAULT NULL

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
,SglLvLastCashReturn decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalReturn decimal(18,6) DEFAULT NULL
,SglLvLastCashRefund decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalRefund decimal(18,6) DEFAULT NULL
,SglLvLastTokenRefund decimal(18,6) DEFAULT NULL
,SglLvLastCashOutStk decimal(18,6) DEFAULT NULL
,SglLvLastCashOutWin decimal(18,6) DEFAULT NULL

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
,SglPmLastCashReturn decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalReturn decimal(18,6) DEFAULT NULL
,SglPmLastCashRefund decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalRefund decimal(18,6) DEFAULT NULL
,SglPmLastTokenRefund decimal(18,6) DEFAULT NULL
,SglPmLastCashOutStk decimal(18,6) DEFAULT NULL
,SglPmLastCashOutWin decimal(18,6) DEFAULT NULL

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
,CmbLastCashReturn decimal(18,6) DEFAULT NULL
,CmbLastBonusBalReturn decimal(18,6) DEFAULT NULL
,CmbLastCashRefund decimal(18,6) DEFAULT NULL
,CmbLastBonusBalRefund decimal(18,6) DEFAULT NULL
,CmbLastTokenRefund decimal(18,6) DEFAULT NULL
,CmbLastCashOutStk decimal(18,6) DEFAULT NULL
,CmbLastCashOutWin decimal(18,6) DEFAULT NULL

,TotalCashStkAmt decimal(18,6) DEFAULT NULL
,TotalBonusStkAmt decimal(18,6) DEFAULT NULL
,TotalBonusBalStkAmt decimal(18,6) DEFAULT NULL
,TotalCashReturn decimal(18,6) DEFAULT NULL
,TotalBonusBalReturn decimal(18,6) DEFAULT NULL
,TotalCashRefund decimal(18,6) DEFAULT NULL
,TotalBonusBalRefund decimal(18,6) DEFAULT NULL
,TotalTokenRefund decimal(18,6) DEFAULT NULL
,TotalCashOutStk decimal(18,6) DEFAULT NULL
,TotalCashOutWin decimal(18,6) DEFAULT NULL
,PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_cv_player_first_last_totals.csv'
INTO TABLE sp_cv_player_first_last_totals FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;

insert into romaniamain.sp_cv_player_first_last_totals
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
,SglLvFirstCashReturn
,SglLvFirstBonusBalReturn
,SglLvFirstCashRefund
,SglLvFirstBonusBalRefund
,SglLvFirstTokenRefund
,SglLvFirstCashOutStk
,SglLvFirstCashOutWin
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
,SglPmFirstCashReturn
,SglPmFirstBonusBalReturn
,SglPmFirstCashRefund
,SglPmFirstBonusBalRefund
,SglPmFirstTokenRefund
,SglPmFirstCashOutStk
,SglPmFirstCashOutWin
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
,CmbFirstCashReturn
,CmbFirstBonusBalReturn
,CmbFirstCashRefund
,CmbFirstBonusBalRefund
,CmbFirstTokenRefund
,CmbFirstCashOutStk
,CmbFirstCashOutWin
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
,SglLvLastCashReturn
,SglLvLastBonusBalReturn
,SglLvLastCashRefund
,SglLvLastBonusBalRefund
,SglLvLastTokenRefund
,SglLvLastCashOutStk
,SglLvLastCashOutWin
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
,SglPmLastCashReturn
,SglPmLastBonusBalReturn
,SglPmLastCashRefund
,SglPmLastBonusBalRefund
,SglPmLastTokenRefund
,SglPmLastCashOutStk
,SglPmLastCashOutWin
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
,CmbLastCashReturn
,CmbLastBonusBalReturn
,CmbLastCashRefund
,CmbLastBonusBalRefund
,CmbLastTokenRefund
,CmbLastCashOutStk
,CmbLastCashOutWin
,TotalCashStkAmt
,TotalBonusStkAmt
,TotalBonusBalStkAmt
,TotalCashReturn
,TotalBonusBalReturn
,TotalCashRefund
,TotalBonusBalRefund
,TotalTokenRefund
,TotalCashOutStk
,TotalCashOutWin
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
,case when BetClass = 'Single' and LiveYN = 'Y' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutWin end

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
,case when BetClass = 'Single' and LiveYN = 'N' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutWin end


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
,case when BetClass = 'Combi' then CashReturn end
,case when BetClass = 'Combi' then BonusBalanceReturn end
,case when BetClass = 'Combi' then CashRefund end
,case when BetClass = 'Combi' then BonusBalanceRefund end
,case when BetClass = 'Combi' then TokenRefund end
,case when BetClass = 'Combi' then CashOutStake end
,case when BetClass = 'Combi' then CashOutWin end


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
,case when BetClass = 'Single' and LiveYN = 'Y' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutWin end

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
,case when BetClass = 'Single' and LiveYN = 'N' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutWin end


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
,case when BetClass = 'Combi' then CashReturn end
,case when BetClass = 'Combi' then BonusBalanceReturn end
,case when BetClass = 'Combi' then CashRefund end
,case when BetClass = 'Combi' then BonusBalanceRefund end
,case when BetClass = 'Combi' then TokenRefund end
,case when BetClass = 'Combi' then CashOutStake end
,case when BetClass = 'Combi' then CashOutWin end

,CashStakeAmt
,BonusStakeAmt
,BonusBalanceStake
,CashReturn
,BonusBalanceReturn
,CashRefund
,BonusBalanceRefund
,TokenRefund
,CashOutStake
,CashOutWin

from
romaniastage.stg_sp_cv_player_first_last as src

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
, SglLvFirstCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashReturn,SglLvFirstCashReturn)
, SglLvFirstBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceReturn,SglLvFirstBonusBalReturn)
, SglLvFirstCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashRefund,SglLvFirstCashRefund)
, SglLvFirstBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceRefund,SglLvFirstBonusBalRefund)
, SglLvFirstTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.TokenRefund,SglLvFirstTokenRefund)
, SglLvFirstCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashOutStake,SglLvFirstCashOutStk)
, SglLvFirstCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashOutWin,SglLvFirstCashOutWin)

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
, SglPmFirstCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashReturn,SglPmFirstCashReturn)
, SglPmFirstBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceReturn,SglPmFirstBonusBalReturn)
, SglPmFirstCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashRefund,SglPmFirstCashRefund)
, SglPmFirstBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceRefund,SglPmFirstBonusBalRefund)
, SglPmFirstTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.TokenRefund,SglPmFirstTokenRefund)
, SglPmFirstCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashOutStake,SglPmFirstCashOutStk)
, SglPmFirstCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashOutWin,SglPmFirstCashOutWin)

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
, CmbFirstCashReturn = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashReturn,CmbFirstCashReturn)
, CmbFirstBonusBalReturn = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceReturn,CmbFirstBonusBalReturn)
, CmbFirstCashRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashRefund,CmbFirstCashRefund)
, CmbFirstBonusBalRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceRefund,CmbFirstBonusBalRefund)
, CmbFirstTokenRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.TokenRefund,CmbFirstTokenRefund)
, CmbFirstCashOutStk = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashOutStake,CmbFirstCashOutStk)
, CmbFirstCashOutWin = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashOutWin,CmbFirstCashOutWin)

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
, SglLvLastCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashReturn,SglLvLastCashReturn)
, SglLvLastBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceReturn,SglLvLastBonusBalReturn)
, SglLvLastCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashRefund,SglLvLastCashRefund)
, SglLvLastBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceRefund,SglLvLastBonusBalRefund)
, SglLvLastTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.TokenRefund,SglLvLastTokenRefund)
, SglLvLastCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashOutStake,SglLvLastCashOutStk)
, SglLvLastCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashOutWin,SglLvLastCashOutWin)

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
, SglPmLastCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashReturn,SglPmLastCashReturn)
, SglPmLastBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceReturn,SglPmLastBonusBalReturn)
, SglPmLastCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashRefund,SglPmLastCashRefund)
, SglPmLastBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceRefund,SglPmLastBonusBalRefund)
, SglPmLastTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.TokenRefund,SglPmLastTokenRefund)
, SglPmLastCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashOutStake,SglPmLastCashOutStk)
, SglPmLastCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashOutWin,SglPmLastCashOutWin)

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
, CmbLastCashReturn = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashReturn,CmbLastCashReturn)
, CmbLastBonusBalReturn = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceReturn,CmbLastBonusBalReturn)
, CmbLastCashRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashRefund,CmbLastCashRefund)
, CmbLastBonusBalRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceRefund,CmbLastBonusBalRefund)
, CmbLastTokenRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.TokenRefund,CmbLastTokenRefund)
, CmbLastCashOutStk = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashOutStake,CmbLastCashOutStk)
, CmbLastCashOutWin = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashOutWin,CmbLastCashOutWin)

,TotalCashStkAmt = TotalCashStkAmt + src.CashStakeAmt
,TotalBonusStkAmt = TotalBonusStkAmt + src.BonusStakeAmt
,TotalBonusBalStkAmt = TotalBonusBalStkAmt + src.BonusBalanceStake
,TotalCashReturn = TotalCashReturn + src.CashReturn
,TotalBonusBalReturn = TotalBonusBalReturn + src.BonusBalanceReturn
,TotalCashRefund = TotalCashRefund + src.CashRefund
,TotalBonusBalRefund = TotalBonusBalRefund + src.BonusBalanceRefund
,TotalTokenRefund = TotalTokenRefund + src.TokenRefund
,TotalCashOutStk = TotalCashOutStk + src.CashOutStake
,TotalCashOutWin = TotalCashOutWin + src.CashOutWin

, SglLvFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BetTime,SglLvFirstBetTime)
, SglPmFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BetTime,SglPmFirstBetTime)
, CmbFirstBetTime = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BetTime,CmbFirstBetTime)
, SglLvLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BetTime,SglLvLastBetTime)
, SglPmLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BetTime,SglPmLastBetTime)
, CmbLastBetTime = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BetTime,CmbLastBetTime)

;

select count(*) from romaniamain.sp_cv_player_first_last_totals;

commit;