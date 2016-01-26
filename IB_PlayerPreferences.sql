##Full Run
use romaniamain;
select PlayerId, SportName,ClassName,SelectionName, count(*) as BetCount from romaniamain.fd_placed_bets group by 1,2,3,4 order by PlayerId,  count(*) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefSports.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select PlayerId, CasinoType, GameType, sum(bet) from romaniamain.fd_csc_eg_player_product_info_summ group by PlayerId,CasinoType,GameType order by PlayerId, sum(bet) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefCasino.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
PlayerId,
case when temp.SPInternetBetCnt = (SPTotalBetCnt/2) then 'Hybrid'
        when temp.SPInternetBetCnt > (SPTotalBetCnt/2) then 'Internet'
else 'Mobile' end as ChannelPreference
from
(
select 
PlayerId, 
count(case when Channel = 'FTNWEB' then 1 end) as SPInternetBetCnt,
count(case when Channel = 'FTNMOB' then 1 end) as SPMobileBetCnt,
count(*) as SPTotalBetCnt
from romaniamain.fd_placed_bets group by 1
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefSP.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



select
PlayerId,
case when EGMobileStkAmt > TotalStake/3 then 'Mobile'
when EGInternetStkAmt > TotalStake/3 then 'Internet'
when EGCasDownStkAmt > TotalStake/3 then 'CasinoDownload'
when TotalStake > 0 then 'Hybrid'
else 'Unclassified' end as ChannelPreference
from
(
select 
PlayerId, 
SUM(case when ClientPlatform = 'mobile' then Bet else 0 end) as EGMobileStkAmt,
SUM(case when ClientPlatform = 'flash' then Bet else 0 end) as EGInternetStkAmt,
SUM(case when ClientPlatform = 'download' then Bet else 0 end) as EGCasDownStkAmt,
Sum(Bet) as TotalStake
from fd_csc_eg_player_product_info_summ
group by 1
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefEG.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
