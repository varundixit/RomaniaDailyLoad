##dates to be changed 2016-01-14
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
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType <> 'SGL' and BetDate = '2016-01-14'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

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
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType = 'SGL' and BetDate = '2016-01-14';

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
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType <> 'SGL' and SettledDate = '2016-01-14'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

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
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType = 'SGL' and SettledDate = '2016-01-14'
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


SELECT 
 dps.PlayerID
,coalesce(COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.SummaryDate end),0) as SystemAPD
,coalesce(COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.SummaryDate end),0) as SportsAPD
,coalesce(COUNT(distinct case when (dps.EGBet) > 0 then dps.SummaryDate end),0) as EGamingAPD
FROM 
romaniamain.sd_gv_daily_player_summary as dps
join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where dps.SummaryDate = '2016-01-14'
group by dps.PlayerID
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerAPD_Daily.csv'
FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select 
p.PlayerId,
coalesce(sports.SportsBetCount,0),
coalesce(eg.EgBetCount,0)
from 
romaniamain.dim_player as p
left outer join
(select PlayerId, count(BetSlipId) as SportsBetCount from romaniamain.fd_cv_settled_bets_simple where SummaryDate = '2016-01-14' group by 1) as sports
on p.PlayerId = sports.PlayerId
left outer join
(select PlayerId, count(Bet) as EgBetCount from romaniamain.fd_csc_eg_player_product_info_summ where SummaryDate = '2016-01-14' group by 1) as eg
on p.PlayerId = eg.PlayerId
where p.PlayerId is not null and (sports.SportsBetCount > 0 OR eg.EgBetCount > 0)
group by p.PlayerId
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerBetCounts_Daily.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
PlayerId, CAST(coalesce(SUM(egPoints),0.0) as decimal(18,6)) as TotalEgPoints
from ( select eg.PlayerId,IF((eg.Bet*egm.Margins) > eg.Bet,eg.Bet,(eg.Bet*egm.Margins)) as egPoints
from romaniamain.fd_csc_eg_player_product_info_summ as eg
join (select CasinoType, (TotalGrossProfit/TotalBet) as Margins
from ( select CasinoType,SUM(Bet) as TotalBet,SUM(Win) as TotalWin,SUM(Bet-Win) as TotalGrossProfit
from romaniamain.fd_csc_eg_player_product_info_summ
group by 1) as temp) as egm on eg.CasinoType = egm.CasinoType) as EgPoints
group by 1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\TotalEGPoints.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';