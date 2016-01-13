#IB Load into Main Tables

######IB_Dim_Player_Load.sql
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_PLAYER.csv'
into table romaniamain.DIM_PLAYER
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select count(1) from romaniamain.DIM_PLAYER where PlayerID is null;

#####Exchange Rates
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\DD_Exchange_Rate.csv'
into table romaniamain.DD_Exchange_Rate
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

#######IB_LoadSequence_Main
#########New Signups
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\New_signups.csv'
into table romaniaStg.New_Signup
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

###IB_Balance_Load.sql
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_DAILY_PLAYER_BALANCE.csv'
into table romaniamain.FD_DAILY_PLAYER_BALANCE
fields terminated by ',' OPTIONALLY enclosed by '"' lines terminated by '\r\n';

###IB_Payments_load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\sd_daily_cashier_summary.csv'  
INTO TABLE romaniamain.sd_daily_cashier_summary 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Games_load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Games_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId,
SummaryDate,
CurrencyCode,
SUM(Bet),
SUM(CashBet),
SUM(BonusBet),
SUM(Win),
SUM(CashWin),
SUM(BonusWin),
SUM(BonusFreeGamesCount),
SUM(FreeGamesCount),
SUM(JackpotBet),
SUM(JackpotWin)
from romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
where SummaryDate = date(date_add(Current_Date, interval -1 day))
group by PlayerId,SummaryDate,CurrencyCode
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\sd_cv_eg_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 PlayerId
,SummaryDate
,GameDate
,coalesce(Bet,0)
,coalesce(CashBet,0)
,coalesce(BonusBet,0)
,coalesce(Win,0)
,coalesce(CashWin,0)
,coalesce(BonusWin,0)
,coalesce(BonusFreeGamesCount,0)
,coalesce(FreeGamesCount,0)
,coalesce(JackpotBet,0)
,coalesce(JackpotWin,0)
,ClientPlatform
,ClientType
,CasinoType
,GameType
,GameName
,RomDummy 
from  romaniamain.fd_csc_eg_player_product_info_summ 
where SummaryDate = date(date_add(Current_Date, interval -1 day))
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\mysql_fd_csc_eg_player_product_info_summ.csv' 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\sd_cv_eg_daily_player_summary.csv' 
INTO TABLE romaniamain.sd_eg_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Placed_Bets_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\stg_placed_bets.csv' 
INTO TABLE  romaniamain.fd_placed_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Settled_Bets_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets.csv' 
INTO TABLE  romaniamain.fd_settled_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Rejected_Bets_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\fd_rejected_bets.csv' 
INTO TABLE  romaniamain.fd_rejected_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Voided_Bets_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\fd_voided_bets.csv' 
INTO TABLE  romaniamain.fd_voided_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Open_Bets_Load.sql
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\fd_open_bets.csv' 
INTO TABLE romaniamain.fd_open_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

