use romaniamain;
select PlayerId, SportName,ClassName,SelectionName, count(*) as BetCount from fd_placed_bets group by 1,2,3,4 order by PlayerId,  count(*) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefSports.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select PlayerId, CasinoType, GameType, sum(bet) from  fd_csc_eg_player_product_info_summ 
group by PlayerId, CasinoType, GameType
order by PlayerId, sum(bet) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefCasino.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

/*select PlayerId, 
case 
	when ClientPlatform = 'mobile' then 'Mobile'
	when ClientPlatform = 'flash' then 'Internet'
    when ClientPlatform = 'download' then 'CasinoDownload'
else 'Internet' end as Channel,
Sum(Bet) as TotalStake
from  romaniamain.fd_csc_eg_player_product_info_summ
group by 1,2
order by PlayerId, Sum(Bet) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ChannelPreferenceGaming.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select PlayerId, 
case when Channel = 'FTNWEB' then 'Internet'
        when Channel = 'FTNMOB' then 'Mobile'
else 'Internet' end as Channel,
count(*) as BetCount 
from romaniamain.fd_placed_bets group by 1,2 order by PlayerId,  count(*) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ChannelPreferenceSports.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';*/