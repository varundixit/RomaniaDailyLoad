##date change 2016-02-05
##place file "Customer_P_L_Viewer_2016-02-05.csv" and "Profit_Loss2016-02-05.csv"
#Full Run

drop table romaniastg.stg_customer_pnl;
CREATE TABLE `romaniastg`.`stg_customer_pnl` (
   `settled_date` varchar(200) DEFAULT NULL,
   `cust_id` varchar(200) DEFAULT NULL,
   `cr_date` varchar(200) DEFAULT NULL,
   `cust_limit_mult` varchar(200) DEFAULT NULL,
   `cust_segment_name` varchar(200) DEFAULT NULL,
   `channel_name` varchar(200) DEFAULT NULL,
   `cust_username` varchar(200) DEFAULT NULL,
   `casino_identifier` varchar(200) DEFAULT NULL,
   `cust_ccy_code` varchar(200) DEFAULT NULL,
   `sport_name` varchar(200) DEFAULT NULL,
   `class_name` varchar(200) DEFAULT NULL,
   `type_name` varchar(200) DEFAULT NULL,
   `sgl_mult_bet_types_name` varchar(200) DEFAULT NULL,
   `is_inplay` varchar(20) DEFAULT NULL,
   `mkt_sort_name` varchar(200) DEFAULT NULL,
   `total_stake` varchar(200) DEFAULT NULL,
   `cash_stake` varchar(200) DEFAULT NULL,
   `cash_out_stake` varchar(200) DEFAULT NULL,
   `bonus_stake` varchar(200) DEFAULT NULL,
   `bonus_bal_stake` varchar(200) DEFAULT NULL,
   `num_bets` varchar(200) DEFAULT NULL,
   `num_lines` varchar(200) DEFAULT NULL,
   `returns` varchar(200) DEFAULT NULL,
   `cash_winnings` varchar(200) DEFAULT NULL,
   `cash_out_win` varchar(200) DEFAULT NULL,
   `bonus_winnings` varchar(200) DEFAULT NULL,
   `bonus_bal_winnings` varchar(200) DEFAULT NULL,
   `stake_refunded` varchar(200) DEFAULT NULL,
   `bonus_stake_refunded` varchar(200) DEFAULT NULL,
   `bonus_bal_refund` varchar(200) DEFAULT NULL,
   `num_void_lines` varchar(200) DEFAULT NULL,
   `cash_profit` varchar(200) DEFAULT NULL,
   `profit_pc` varchar(200) DEFAULT NULL,
   `combined_profit` varchar(200) DEFAULT NULL,
   `max_stake` varchar(200) DEFAULT NULL,
   `avg_stake` varchar(200) DEFAULT NULL,
   `in_play_prop` varchar(200) DEFAULT NULL,
   `num_void_bets` varchar(200) DEFAULT NULL,
   `num_void_bet_lines` varchar(200) DEFAULT NULL,
   `void_stakes` varchar(200) DEFAULT NULL,
   `is_void` varchar(200) DEFAULT NULL,
   `void_in_play_prop` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\Customer_P_L_Viewer_2016-02-05.csv' 
INTO TABLE romaniastg.stg_customer_pnl FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
str_to_date(settled_date,'%Y-%m-%d %H:%i') settled_date, 
date(date_add(settled_date, INTERVAL -2 Hour)) settled_cr,
PlayerID,
cust_username, 
cust_limit_mult, 
cust_segment_name, 
channel_name, 
casino_identifier, 
cust_ccy_code, 
sport_name, 
class_name, 
type_name, 
sgl_mult_bet_types_name, 
is_inplay, 
mkt_sort_name, 
total_stake, 
cash_stake, 
cash_out_stake, 
bonus_stake, 
bonus_bal_stake, 
num_bets, 
num_lines, 
returns, 
cash_winnings, 
cash_out_win, 
bonus_winnings, 
bonus_bal_winnings, 
stake_refunded, 
bonus_stake_refunded, 
bonus_bal_refund, 
num_void_lines, 
cash_profit, 
profit_pc, 
combined_profit, 
max_stake, 
avg_stake, 
in_play_prop, 
num_void_bets, 
num_void_bet_lines, 
void_stakes, 
is_void, 
void_in_play_prop
from romaniastg.stg_customer_pnl pnl 
join romaniamain.dim_player dp on dp.username = pnl.cust_username
where settled_date <> 'settled_date'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\SettledSummary2016-02-05.csv'
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';

/*
drop table romaniamain.customer_pnl;
Create table romaniamain.customer_pnl (
SettledDate	datetime,
SettledDateCR	date,
PlayerID	bigint,
Username	varchar(200),
CustLimitMult	decimal(18,6),
CustSegmentName	varchar(200),
ChannelName	varchar(200),
CasinoIdentifier	varchar(200),
CustCcyCode	Varchar(50),
SportName	varchar(200),
ClassName	varchar(200),
TypeName	varchar(500),
SglMultbettype	Varchar(50),
LiveYN	Varchar(50),
MktSortName	varchar(200),
TotalStake	decimal(18,6),
CashStake	decimal(18,6),
CashOutStake	decimal(18,6),
BonusStake	decimal(18,6),
BonusBalStake	decimal(18,6),
NumBets	decimal(18,6),
NumLines	decimal(18,6),
TotalWinnings	decimal(18,6),
CashWinnings	decimal(18,6),
CashOutWin	decimal(18,6),
BonusWinnings	decimal(18,6),
BonusBalWinnings	decimal(18,6),
StakeRefunded	decimal(18,6),
BonusStakeRefunded	decimal(18,6),
BonusBalRefund	decimal(18,6),
NumVoidLines	decimal(18,6),
CashProfit	decimal(18,6),
ProfitPc	decimal(18,6),
CombinedProfit	decimal(18,6),
MaxStake	decimal(18,6),
AvgStake	decimal(18,6),
InPlayProp	decimal(18,6),
NumVoidBets	decimal(18,6),
NumVoidBetLines	decimal(18,6),
VoidStakes	decimal(18,6),
IsVoid	Varchar(50),
VoidInPlayProp	decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

*/

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\SettledSummary2016-02-05.csv' 
INTO TABLE romaniamain.customer_pnl FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\SettledSummaryCompleteJan31Parsed.csv' 
INTO TABLE romaniamain.customer_pnl FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
SettledDate,
date(date_add(SettledDate, INTERVAL -2 Hour)) settled_cr,
PlayerID, Username, CustLimitMult, CustSegmentName, ChannelName, CasinoIdentifier, CustCcyCode, SportName, ClassName, TypeName, SglMultbettype, LiveYN, MktSortName, TotalStake, CashStake, CashOutStake, BonusStake, BonusBalStake, NumBets, NumLines, TotalWinnings, CashWinnings, CashOutWin, BonusWinnings, BonusBalWinnings, StakeRefunded, BonusStakeRefunded, BonusBalRefund, NumVoidLines, CashProfit, ProfitPc, CombinedProfit, MaxStake, AvgStake, InPlayProp, NumVoidBets, NumVoidBetLines, VoidStakes, IsVoid, VoidInPlayProp
from romaniamain.customer_pnl 
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\SettledSummaryCompleteJan31Parsed.csv'
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';
*/

#select * from romaniamain.customer_pnl limit 100;
#############pnl summary load


drop table romaniastg.rw_pnl_summary;
Create table romaniastg.rw_pnl_summary(
SummaryDate varchar(100) DEFAULT NULL,
Operator varchar(100) DEFAULT NULL,
RefLines varchar(100) DEFAULT NULL,
CashStake varchar(100) DEFAULT NULL,
CashPnL varchar(100) DEFAULT NULL,
TokenStake varchar(100) DEFAULT NULL,
TokenPnL varchar(100) DEFAULT NULL,
CashOutStake varchar(100) DEFAULT NULL,
CashOutReturns varchar(100) DEFAULT NULL,
WinningsRedeemed varchar(100) DEFAULT NULL,
OptInTakings varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\Profit_Loss2016-02-05.csv' 
INTO TABLE  romaniastg.rw_pnl_summary
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select str_to_date('2016-02-05','%Y-%m-%d') as_of,
CASE WHEN SummaryDate <> '' THEN str_to_date(substring(SummaryDate, 1,16),'%Y-%m-%d %H:%i') ELSE NULL END summarydate,
Operator, RefLines, CashStake, CashPnL, TokenStake, TokenPnL, CashOutStake, CashOutReturns,WinningsRedeemed,OptInTakings
from romaniastg.rw_pnl_summary
where SummaryDate<> 'Date'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\STGProfit_Loss_2016-02-05.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*
drop table `romaniamain`.`pnl_summary`;
CREATE TABLE `romaniamain`.`pnl_summary` (
AsOf date,
SummaryDate datetime,
Operator varchar(200) DEFAULT NULL,
RefLines integer,
CashStake decimal(18,6),
CashPnL decimal(18,6),
TokenStake decimal(18,6),
TokenPnL decimal(18,6),
CashOutStake decimal(18,6),
CashOutReturns decimal(18,6),
WinningsRedeemed decimal(18,6),
OptInTakings decimal(18,6)
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;*/
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CustomerPLViewer\\STGProfit_Loss_2016-02-05.csv' 
INTO TABLE  `romaniamain`.`pnl_summary`
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#select * from romaniamain.pnl_summary;
