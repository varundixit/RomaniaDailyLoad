#IB Load into Main Tables

######IB_Dim_Player_Load.sql
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_PLAYER.csv'
into table romaniamain.DIM_PLAYER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

select count(1) from romaniamain.DIM_PLAYER where PlayerID is null;

#####Exchange Rates
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate.csv'
into table romaniamain.DD_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';