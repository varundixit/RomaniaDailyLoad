##dates to be changed 2016-01-04

use romaniamain;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(StakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType <> 'SGL' and BetDate = '2016-01-04'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(StakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType = 'SGL' and BetDate = '2016-01-04';

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(TotalStakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake,
coalesce(AVG(TotalReturn),0) as TotalReturn,
coalesce(AVG(CashReturn),0) as CashReturn,
coalesce(AVG(BonusBalanceReturn),0) as BonusBalanceReturn,
coalesce(AVG(CashRefund),0) as CashRefund,
coalesce(AVG(BonusBalanceRefund),0) as BonusBalanceRefund,
coalesce(AVG(TokenRefund),0) as TokenRefund,
coalesce(AVG(CashOutStake),0) as CashOutStake,
coalesce(AVG(CashOutWin),0) as CashOutWin
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType <> 'SGL' and SettledDate = '2016-01-04'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(TotalStakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake,
coalesce(TotalReturn,0) as TotalReturn,
coalesce(CashReturn,0) as CashReturn,
coalesce(BonusBalanceReturn,0) as BonusBalanceReturn,
coalesce(CashRefund,0) as CashRefund,
coalesce(BonusBalanceRefund,0) as BonusBalanceRefund,
coalesce(TokenRefund,0) as TokenRefund,
coalesce(CashOutStake,0) as CashOutStake,
coalesce(CashOutWin,0) as CashOutWin
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType = 'SGL' and SettledDate = '2016-01-04'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;


select 
PlayerID,
trim(Username),
trim(Gender),
coalesce(Balance,0),
case when GlobalFirstDepositDate is null then '3000-01-01 00:00:00' else GlobalFirstDepositDate end,
case when SignupDate is null then '3000-01-01 00:00:00' else SignupDate end,
1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\mysql_dim_player.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
from dim_player
where PlayerID is not null;