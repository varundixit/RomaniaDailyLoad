select 
PlayerId
,cast(LTSystemAPD as decimal(18,6)) as LTSystemAPD
,cast(TotalStake as decimal(18,6)) as TotalStake
,cast(TotalReturns as decimal(18,6)) as TotalReturns
,cast(TotalGrossProfit as decimal(18,6)) as TotalGrossProfit
,TotalBetCnt
,TotalAPD
,cast(YeildPerAPD as decimal(18,6)) as YeildPerAPD
,cast(BetsPerAPD as decimal(18,6)) as BetsPerAPD
,cast(StakePerBet as decimal(18,6)) as StakePerBet
,cast(Margins as decimal(18,6)) as Margins
,cast(Frequeny as decimal(18,6)) as Frequeny
,cast((Frequeny*30*StakePerBet*BetsPerAPD*Margins)  as decimal(18,6)) as PlayerValue
from
(
select 
p.PlayerId,
PlayerAPD.LTSystemAPD,
SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0)) as TotalStake,
SUM(coalesce(SportsGA.SPTotalReturns,0) + coalesce(EgamingGA.EGTotalReturns,0)) as TotalReturns,
(SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0))- SUM(coalesce(SportsGA.SPTotalReturns,0) + coalesce(EgamingGA.EGTotalReturns,0))) as TotalGrossProfit,
SUM(coalesce(PlayerBetCnts.LTSportsBetCount,0) + coalesce(PlayerBetCnts.LTEgBetCount,0)) as TotalBetCnt,
PlayerAPD.LTSystemAPD as TotalAPD,
(((SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0))- SUM(coalesce(SportsGA.SPTotalReturns,0) + coalesce(EgamingGA.EGTotalReturns,0)))) /PlayerAPD.LTSystemAPD) as YeildPerAPD,
((SUM(coalesce(PlayerBetCnts.LTSportsBetCount,0) + coalesce(PlayerBetCnts.LTEgBetCount,0)))/PlayerAPD.LTSystemAPD) as BetsPerAPD,
(SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0))/SUM(coalesce(PlayerBetCnts.LTSportsBetCount,0) + coalesce(PlayerBetCnts.LTEgBetCount,0))) as StakePerBet,
((SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0))- SUM(coalesce(SportsGA.SPTotalReturns,0) + coalesce(EgamingGA.EGTotalReturns,0)))/SUM(coalesce(SportsGA.SPTotalStake,0) + coalesce(EgamingGA.EGTotalStake,0))) as Margins,
PlayerAPD.LTSystemAPD/30 as Frequeny
from romaniastage.stg_dim_player as p
left outer join 
(
select 
PlayerID,
coalesce(sum(TotalCashStkAmt+TotalBonusBalStkAmt+TotalCashOutStk),0) as SPTotalStake,
coalesce(sum(TotalCashReturn+TotalBonusBalReturn+TotalCashOutWin),0) as SPTotalReturns
from romaniamain.sp_cv_player_first_last_totals
group by 1
) as SportsGA on p.PlayerId = SportsGA.PlayerId
left outer join 
(
select 
PlayerID,
coalesce(TotalBetAmt,0) as EGTotalStake,
coalesce(TotalWinAmt,0) as EGTotalReturns
from romaniamain.eg_player_first_last_totals
) as EgamingGA on p.PlayerId = EgamingGA.PlayerId
left outer join 
(
select
 PlayerID
,LTSystemAPD
,LTSportsAPD
,LTEGamingAPD
from romaniamain.f_player_lifetime_apd
) as PlayerAPD on p.PlayerId = PlayerAPD.PlayerId
left outer join 
(
select 
 PlayerID 
,LTSportsBetCount
,LTEgBetCount
from romaniamain.f_player_lifetime_betcounts
) as PlayerBetCnts on p.PlayerId = PlayerBetCnts.PlayerId
#where p.PlayerId = 10273865
group by 1
) as temp
having TotalStake > 0
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerValue.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


Drop table romaniamain.PlayerValue;
Create table romaniamain.PlayerValue
(
PlayerId integer, 
LTSystemAPD integer, 
TotalStake decimal(18,6), 
TotalReturns decimal(18,6), 
TotalGrossProfit decimal(18,6), 
TotalBetCnt integer, 
TotalAPD integer, 
YeildPerAPD decimal(18,6), 
BetsPerAPD decimal(18,6), 
StakePerBet decimal(18,6), 
Margins decimal(18,6), 
Frequeny decimal(18,6), 
PlayerValue decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerValue.csv'
INTO TABLE romaniamain.PlayerValue
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
