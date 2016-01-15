#LoadSequence Stage

##########Exchange Rates
Load data infile 'D:\\RomData\\dump\\Currency_conversion_rates.csv'
into table romaniastg.STG_Exchange_Rate
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

select date(EffectiveTimestamp),
EffectiveTimestamp,
LastUpdTimestamp,
CurrencyCode,
XchangeRate
from romaniastg.STG_Exchange_Rate
INTO OUTFILE 'D:\\RomData\\dump\\DD_Exchange_Rate.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_PlayerAdvertisersLoad.sql

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\CURL_Advertisers.csv'
into table romaniaStg.Advertisers
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


Load data infile 'D:\\RomData\\dump\\New_signups.csv'
into table romaniaStg.IMS_newSignup
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select p.PlayerID,p.username,adv.email advEmail,advUsername,
case when lower(adv.email) = 'agentii@efortuna.ro' then 'RETAIL'
when lower(adv.email) like 'iulian.dumitru@efortuna.ro' or lower(adv.email) like 'superpont1x2@gmail.com' then 'DIGITAL'
when lower(adv.email) like 'defaulte8' then 'Generic'
else 'AFFILIATE' end advChannel 
from romaniastg.stg_ims_player p
left outer join (select ns.username,coalesce(ad.email,affiliate) email, ad.username advUsername
from romaniastg.IMS_newSignup ns
left outer join romaniastg.advertisers ad on ns.affiliate = ad.username) adv on (adv.username = p.username)
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\CRM\\DimPlayerChannel.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


###IB_Logins.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\CURL_Logins.csv'
INTO TABLE  romaniastg.rw_logins
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

SELECT 
ClientType,
Code,
EndBalance,
EndBonusBalance,
FunPlayerCode,
HwSerial,
IP,
KioskCode,
CASE WHEN LoginDate <> '' THEN str_to_date(substring(LoginDate, 1,16),'%Y-%m-%d %H:%i') ELSE NULL END LoginDate,
CASE WHEN LogoutDate <> '' THEN str_to_date(substring(LogoutDate, 1,16),'%Y-%m-%d %H:%i') ELSE NULL END LogoutDate,
PlayerCode,
PlayerType,
Serial_,
ServerCode,
SessionID,
Startbalance,
Startbonusbalance,
Version,
ClientPlatform,
LoginDeviceTypeCode,
LoginVenueCode
FROM romaniastg.rw_logins
where ClientType!='CLIENTTYPE'
INTO OUTFILE 'D:\\RomData\\dump\\LoginsNew.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\LoginsNew.csv' 
INTO TABLE  romaniastg.c_logins
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select d.DAT_DAY_DATE,playercode,playertype,
case when d.DAT_DAY_DATE = date(logindate)  then logindate  else str_to_date(concat(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 00:00:00'),'%Y-%m-%d %H:%i:%s')  end as logindate,
case when d.DAT_DAY_DATE = date(logoutdate) then logoutdate else str_to_date(CONCAT(DATE_FORMAT(d.DAT_DAY_DATE,'%Y-%m-%d'),' 23:59:59'),'%Y-%m-%d %H:%i:%s')  end as logoutdate,
coalesce(case when d.DAT_DAY_DATE = date(logindate) then startbalance else endbalance end,0) as startbalance,
coalesce(case when d.DAT_DAY_DATE = date(logindate) then startBonusbalance else endBonusbalance end,0) as startBonusbalance,
coalesce(endBalance,0),
coalesce(endBonusBalance,0),
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from 
(select sessionId,lo1.playercode,lo1.logindate,lo1.logoutdate,lo1.startbalance,lo1.endbalance,lo1.startbonusbalance,lo1.endbonusbalance,playertype,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from romaniastg.c_logins lo1 where date(lo1.LoginDate) != date(lo1.logoutdate) 
#and playercode=10275515
) sa 
join romania.d_date d on d.dat_Day_Date between date(sa.logindate) and date(sa.logoutdate)
where d.dat_day_date >= '2015-11-26' and d.dat_day_Date < current_date
INTO OUTFILE 'D:\\RomData\\dump\\LoginSplitsAcrossDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';


select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from romaniastg.c_logins lo1 where lo1.logoutdate is null and date(lo1.LoginDate) >='2015-11-26'
#and code = 25542
INTO OUTFILE 'D:\\RomData\\dump\\LoginNullLogOutDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from romaniastg.c_logins lo1 where date(lo1.LoginDate) = date(lo1.logoutdate) 
and date(lo1.LoginDate) >='2015-11-26'
INTO OUTFILE 'D:\\RomData\\dump\\RegularLogins.csv'
#character set utf8
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'D:\\RomData\\dump\\LoginSplitsAcrossDates.csv' 
INTO TABLE romaniastg.stg_daily_player_logins
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\LoginNullLogOutDates.csv' 
INTO TABLE romaniastg.stg_daily_player_logins
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\RegularLogins.csv' 
INTO TABLE romaniastg.stg_daily_player_logins
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

select   
ClientType
, code LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerCode
,PlayerType
,Serial SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_stg_daily_player_logins.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.stg_daily_player_logins;

###IB_Balance_Load.sql
select
  Code as Playerid
, date_add(current_Date, interval -1 day) AS SummaryDate
, AdvertiserCode
, STR_TO_DATE(GlobalFirstDepositDate, '%Y-%m-%d %H:%i:%s') as FirstDepositDate
, Balance as Balance
, BonusBalance as BonusBalance
, STR_TO_DATE(SignupDate, '%Y-%m-%d %H:%i:%s') as SignUpDate
, 1
INTO OUTFILE 'D:\\RomData\\dump\\STG_DAILY_PLAYER_BALANCE.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.STG_IMS_CSV_PLAYER;


###IB_Payments_load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\usertransactions.csv'  
INTO TABLE romaniastg.CSV_TO_STG FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
STR_TO_DATE(TxnTime, '%Y-%m-%d %H:%i:%s')  ,
STR_TO_DATE(AcceptTime, '%Y-%m-%d %H:%i:%s')  ,
stg.Username ,
p.PlayerID,
date(p.SignupDate),
case when p.GlobalFirstDepositDate is null then STR_TO_DATE('0000-00-00', '%Y-%m-%d') else date(p.GlobalFirstDepositDate) end,
stg.Email ,
Name ,
OBSCCard ,
OBSExpDate ,
cast(TxnID as unsigned) ,
Type ,
Method ,
Merchant ,
case when Bank = '-' then null else Bank end ,
PayoutOption ,
Amount,
OBSPaymentTotal,
Status ,
ExtTxnId ,
Result ,
Reason ,
BonusAdmin ,
BDNumber ,
CashierTxnID ,
PTInfo ,
ThreeDSecureProc ,
ExtTxnAcc ,
Casino ,
stg.Comments ,
RiskProfile ,
Kiosk ,
KioskAdmin ,
Agent ,
Agency ,
Currency ,
case when AdjustmentStatus = '-' then null else AdjustmentStatus end,
Credit ,
CreditReverse ,
Chargeback ,
ChargebackReverse ,
ReturnTxt ,
ReturnReverse ,
PayMethRiskGrp ,
PayMethConfCode ,
case when Channel = '-' then null else Channel end,
ConvertedAmt,
ConvertedCurrency ,
ProcessorAmt,
ProcessorCurrency 
INTO OUTFILE 'D:\\RomData\\dump\\STG_SCIMS_Data.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.CSV_TO_STG as stg join romaniamain.dim_player as p on stg.Username = p.Username;


LOAD DATA INFILE 'D:\\RomData\\dump\\STG_SCIMS_Data.csv'  
INTO TABLE romaniastg.STG_SCIMS_Data FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select *
INTO OUTFILE 'D:\\RomData\\dump\\STG_SCIMS_Data_MySQL.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.STG_SCIMS_Data;


LOAD DATA INFILE 'D:\\RomData\\dump\\CURL_Player_Payments.csv'  
INTO TABLE romaniastg.stg_csv_player_payments FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select 
date(STR_TO_DATE(AcceptDate, '%Y-%m-%d %H:%i:%s')) as TxnDate,
STR_TO_DATE(AcceptDate, '%Y-%m-%d %H:%i:%s') as TxnTime,
Address as Address,
AdvertiserCode as AdvertiserCode,
coalesce(Amount,0) as Amount,
coalesce(AuthCode,0) as AuthCode,
AvsCode as AvsCode,
Balance as Balance,
CashiertranID as CashiertranID,
CCardBin as CCardBin,
CcardCode as CcardCode,
CCardSuffix as CCardSuffix,
City as City,
cp.ClientPlatform as ClientPlatform,
spp.Clienttype as Clienttype,
Code as Code,
coalesce(Comppoints,0) as Comppoints,
Confirmation as Confirmation,
Country as Country,
coalesce(DepositWagering,0) as DepositWagering,
STR_TO_DATE(ExpDate, '%Y-%m-%d %H:%i:%s') as ExpiryDate,
ExtraMerchantInfo as ExtraMerchantInfo,
coalesce(FirstDeposit,0) as FirstDeposit,
FirstName as FirstName,
STR_TO_DATE(LastactivityDate, '%Y-%m-%d %H:%i:%s') as LastactivityDate,
LastName as LastName,
MerchantCode as MerchantCode,
Method as Method,
PaypalTranID as PaypalTranID,
PlayerCode as PlayerCode,
coalesce(PlayerPaydFee,0) as PlayerPaydFee,
PromotionalCode as PromotionalCode,
PTInfo as PaymentTxnInfo,
STR_TO_DATE(RedeemDate, '%Y-%m-%d %H:%i:%s') as RedeemDate,
Redeemed as Redeemed,
RedeemedbonusAmount as RedeemedbonusAmount,
coalesce(RedeemThreshold,0) as RedeemThreshold,
RemoteIP as RemoteIP,
STR_TO_DATE(RequestDate, '%Y-%m-%d %H:%i:%s') as RequestDate,
Status as Status,
Type as Type,
coalesce(WinPayment,0) as WinPayment,
Zip as Zip
from romaniastg.stg_csv_player_payments as spp 
join romaniamain.dim_client_parameter as cp on spp.ClientparameterCode = cp.ClientParameterCode
INTO OUTFILE 'D:\\RomData\\dump\\stg_player_payments.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\stg_player_payments.csv'  
INTO TABLE romaniastg.stg_player_payments FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select
PlayerCode as PlayerId,TxnDate as SummaryDate,
SUM(case when Type = 'deposit' then Amount else 0 end) as TotalDepAttemptAmt,
count(case when Type = 'deposit' then Amount end) as TotalDepAttemptCnt,
SUM(case when Type = 'deposit' and Status = 'declined' then Amount else 0 end) as TotalDepDeclineAmt,
count(case when Type = 'deposit' and Status = 'declined' then Amount end) as TotalDepDeclineCnt,
SUM(case when Type = 'deposit' and Status = 'approved' then Amount else 0 end) as TotalDepApproveAmt,
count(case when Type = 'deposit' and Status = 'approved' then Amount end) as TotalDepApproveCnt,

SUM(case when Type = 'deposit' and Status = 'approved' and ClientPlatform = 'mobile' then Amount else 0 end) as TotalDepApproveMobAmt,
count(case when Type = 'deposit' and Status = 'approved' and ClientPlatform = 'mobile' then Amount end) as TotalDepApproveMobCnt,
SUM(case when Type = 'deposit' and Status = 'approved' and ClientPlatform <> 'mobile' then Amount else 0 end) as TotalDepApproveWebAmt,
count(case when Type = 'deposit' and Status = 'approved' and ClientPlatform <> 'mobile' then Amount end) as TotalDepApproveWebCnt,

SUM(case when Type = 'deposit' and Status = 'declined' and ClientPlatform = 'mobile' then Amount else 0 end) as TotalDepDeclineMobAmt,
count(case when Type = 'deposit' and Status = 'declined' and ClientPlatform = 'mobile' then Amount end) as TotalDepDeclineMobCnt,
SUM(case when Type = 'deposit' and Status = 'declined' and ClientPlatform <> 'mobile' then Amount else 0 end) as TotalDepDeclineWebAmt,
count(case when Type = 'deposit' and Status = 'declined' and ClientPlatform <> 'mobile' then Amount end) as TotalDepDeclineWebCnt,

SUM(case when Type = 'withdraw' then Amount else 0 end) as TotalWithdAttemptAmt,
count(case when Type = 'withdraw' then Amount end) as TotalWithdAttemptCnt,
SUM(case when Type = 'withdraw' and Status = 'declined' then Amount else 0 end) as TotalWithdDeclineAmt,
count(case when Type = 'withdraw' and Status = 'declined' then Amount end) as TotalWithdDeclineCnt,
SUM(case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end) as TotalWithdApproveAmt,
count(case when Type = 'withdraw' and Status = 'approved' then Amount end) as TotalWithdApproveCnt,

SUM(case when Type = 'withdraw' and Status = 'approved' and ClientPlatform = 'mobile' then Amount else 0 end) as TotalWithdApproveMobAmt,
count(case when Type = 'withdraw' and Status = 'approved' and ClientPlatform = 'mobile' then Amount end) as TotalWithdApproveMobCnt,
SUM(case when Type = 'withdraw' and Status = 'approved' and ClientPlatform <> 'mobile' then Amount else 0 end) as TotalWithdApproveWebAmt,
count(case when Type = 'withdraw' and Status = 'approved' and ClientPlatform <> 'mobile' then Amount end) as TotalWithdApproveWebCnt,

SUM(case when Type = 'withdraw' and Status = 'declined' and ClientPlatform = 'mobile' then Amount else 0 end) as TotalWithdDeclineMobAmt,
count(case when Type = 'withdraw' and Status = 'declined' and ClientPlatform = 'mobile' then Amount end) as TotalWithdDeclineMobCnt,
SUM(case when Type = 'withdraw' and Status = 'declined' and ClientPlatform <> 'mobile' then Amount else 0 end) as TotalWithdDeclineWebAmt,
count(case when Type = 'withdraw' and Status = 'declined' and ClientPlatform <> 'mobile' then Amount end) as TotalWithdDeclineWebCnt

from romaniastg.stg_player_payments
where date(TxnDate) = date(date_add(Current_Date, interval -1 day))
group by PlayerCode,TxnDate

INTO OUTFILE 'D:\\RomData\\dump\\sd_daily_cashier_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


###IB_Games_load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\Curl_Games.csv' 
INTO TABLE romaniastg.STG_GAMES_CSV
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
 coalesce(AccumulatedBetRefund,0)
,coalesce(Autoplay,0)
,coalesce(Balance,0)
,coalesce(Bet,0)
,coalesce((Bet - BonusBet),0)
,coalesce(BetExcludingTie,0)
,coalesce(BetRefund,0)
,BGType
,coalesce(BonusBalance,0)
,coalesce(BonusBet,0)
,coalesce(BonusCode,0)
,coalesce(BonusFG,0)
,coalesce(BonusJackpotWin,0)
,BonusType
,coalesce(BonusWageringAmount,0)
,coalesce(BonusWin,0)
,coalesce(ChannelCode,0)
,coalesce(ClientParameterCode,0)
,coalesce(Code,0)
,CoinSize
,coalesce(CompPointsBalance,0)
,coalesce(CompsAmount,0)
,coalesce(CurrentBet,0)
,coalesce(CurrentBonusBet,0)
,coalesce(DealerCode,0)
,coalesce(DEVICEContextCode,0)
,coalesce(FGWinAmount,0)
,str_to_date(GameDate, '%Y-%m-%d %H:%i:%s')
,GameID
,Info
,coalesce(InitialBet,0)
,coalesce(JackpotBet,0)
,coalesce(JackpotWin,0)
,coalesce(LiveGameTableCode,0)
,coalesce(LiveNetworkCode,0)
,coalesce(LPWin,0)
,coalesce(MPGameCode,0)
,coalesce(ParentGameCode,0)
,ParentGameDate
,coalesce(PendingBonusCode,0)
,coalesce(PlayerCode,0)
,RecordID
,RemoteIP
,SessionID
,SlotLines
,SPWin
,coalesce(TurnoverCommissionAllocation,0)
,TurnoverCommissionType
,Type
,coalesce(WageringBonusCode,0)
,coalesce(WageringPendingBonusCode,0)
,coalesce(Win,0)
,coalesce((Win - BonusWin),0)
,coalesce(WindowCode,0)
INTO OUTFILE 'D:\\RomData\\dump\\STG_Games_MySQL.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.STG_GAMES_CSV;

LOAD DATA INFILE 'D:\\RomData\\dump\\STG_Games_MySQL.csv' 
INTO TABLE romaniastg.STG_GAMES
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

 select 
  stg.AccumulatedBetRefund
, stg.Autoplay
, stg.Balance
, stg.Bet
, stg.CashBet
, stg.BetExcludingTie
, stg.BetRefund
, stg.BGType
, stg.BonusBalance
, stg.BonusBet
, stg.BonusCode
, stg.BonusFG
, stg.BonusJackpotWin
, stg.BonusType
, stg.BonusWageringAmount
, stg.BonusWin
, stg.ChannelCode
, stg.ClientParameterCode
, stg.Code
, stg.CoinSize
, stg.CompPointsBalance
, stg.CompsAmount
, stg.CurrentBet
, stg.CurrentBonusBet
, stg.DealerCode
, stg.DEVICEContextCode
, stg.FGWinAmount
, date(stg.GameDate)
, stg.GameDate
, stg.GameID
, stg.Info
, stg.InitialBet
, stg.JackpotBet
, stg.JackpotWin
, stg.LiveGameTableCode
, stg.LiveNetworkCode
, stg.LPWin
, stg.MPGameCode
, stg.ParentGameCode
, stg.ParentGameDate
, stg.PendingBonusCode
, stg.PlayerId
, p.CurrencyCode
, stg.RecordID
, stg.RemoteIP
, stg.SessionID
, stg.SlotLines
, stg.SPWin
, stg.TurnoverCommissionAllocation
, stg.TurnoverCommissionType
, stg.Type
, stg.WageringBonusCode
, stg.WageringPendingBonusCode
, stg.Win
, stg.CashWin
, stg.WindowCode
, cp.ClientPlatform
, cp.ClientType
, dgt.Description as CasinoType
, dgt.GameType as GameType
, dgt.Name as GameName
, 1
from  romaniastg.STG_Games as stg
join  romaniamain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join  romaniamain.dim_game_list as dgt on stg.Type = dgt.Type
join  romaniamain.dim_player as p on stg.PlayerId = p.PlayerID
where date(stg.GameDate) <= date(date_add(Current_Date, interval -1 day))
INTO OUTFILE 'D:\\RomData\\dump\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select 
 stg.PlayerId
,date(stg.GameDate)
,stg.GameDate
, p.CurrencyCode
,stg.Bet
,stg.CashBet
,stg.BonusBet
,stg.Win
,stg.CashWin
,stg.BonusWin
,stg.BonusFG as BonusFreeGamesCount
,stg.FGWinAmount as FreeGamesCount
,stg.JackpotBet
,stg.JackpotWin
,cp.ClientPlatform
,CP.ClientType
,dgt.Description
,dgt.GameType
,dgt.Name
, 1
from romaniastg.STG_Games as stg
join romaniamain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join romaniamain.dim_game_list as dgt on stg.Type = dgt.Type
join romaniamain.dim_player as p on stg.PlayerId = p.PlayerID
where date(stg.GameDate) <= date(date_add(Current_Date, interval -1 day))
INTO OUTFILE 'D:\\RomData\\dump\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Settled_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\Settled_Bets.csv' 
INTO TABLE romaniastg.stg_settled_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
 BetId
,STR_TO_DATE(SettleTime, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(SettleTime, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,NumLeg
,NumPart
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,STR_TO_DATE(EventStartTime, '%Y-%m-%d %H:%i:%s')
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,DecreasingOdds
,PlayerId
,UserName
,NumLines
,NumLinesWin
,NumLinesLose
,NumLinesVoid
,CurrencyCode
,BonusId
,CampaignId
,TotalReturn
,TotalReturnBC
,CashReturn
,CashReturnBC
,BonusBalanceReturn
,BonusBalancereturnBC
,CashRefund
,CashRefundBC
,BonusBalanceRefund
,BonusBalanceRefundBC
,TokenRefund
,TokenRefundBC
,CashOutStake
,CashOutStakeBC
,CashOutWin
,CashOutWinBC
,ViewId
,Channel
,Operator
from romaniastg.stg_settled_bets_csv
INTO OUTFILE 'D:\\RomData\\dump\\stg_settled_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\stg_settled_bets.csv' 
INTO TABLE romaniastg.stg_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

use romaniastg;
select 
  pb.BetslipId
, pb.BetslipStatus
, sb.BetId
, pb.BetType
, pb.BetTime
, pb.BetDate
, sb.SettleTime
, sb.SettledDate
, sb.BetStatus
, pb.ReferredYN
, sb.NumLeg
, sb.NumPart
, pb.LegSort
, sb.SelectionId
, sb.SelectionName
, sb.SelectionSort
, sb.MarketId
, sb.MarketName
, sb.MarketSort
, sb.EventId
, sb.EventName
, sb.EventStartTime
, sb.TypeId
, sb.TypeName
, sb.ClassId
, sb.ClassName
, sb.SportCode
, sb.SportName
, sb.DecreasingOdds
, pb.PlayerId
, sb.UserName
, sb.CurrencyCode
, sb.NumLines
, sb.NumLinesWin
, sb.NumLinesLose
, sb.NumLinesVoid
, pb.StakePerLine
, pb.StakePerLineBC
, (IF(sb.CashOutStake <> 0,0,pb.CashStakeAmt)+IF(sb.CashOutStake <> 0,0,pb.BonusStakeAmt)+IF(sb.CashOutStake <> 0,0,pb.BonusBalanceStake)+sb.CashOutStake) as TotalStakeAmt
, (IF(sb.CashOutStake <> 0,0,pb.CashStakeAmtBC)+IF(sb.CashOutStake <> 0,0,pb.BonusStakeAmtBC)+IF(sb.CashOutStake <> 0,0,pb.BonusBalanceStakeBC)+sb.CashOutStakeBC) as TotalStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.CashStakeAmt end) as CashStakeAmt
, (case when sb.CashOutStake <> 0 then 0 else pb.CashStakeAmtBC end) as CashStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusStakeAmt end) as BonusStakeAmt
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusStakeAmtBC end) as BonusStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusBalanceStake end) as BonusBalanceStake
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusBalanceStakeBC end) as BonusBalanceStakeBC
, sb.BonusId
, sb.CampaignId
, (sb.CashReturn + sb.CashOutWin + sb.BonusBalanceReturn) as TotalReturn
, (sb.CashReturnBC + sb.CashOutWinBC + sb.BonusBalancereturnBC) as TotalReturnBC
, sb.CashReturn
, sb.CashReturnBC
, sb.BonusBalanceReturn
, sb.BonusBalancereturnBC
, (sb.CashRefund+sb.BonusBalanceRefund+sb.TokenRefund) as TotalRefund
, (sb.CashRefundBC+sb.BonusBalanceRefundBC+sb.TokenRefundBC) as TotalRefund
, sb.CashRefund
, sb.CashRefundBC
, sb.BonusBalanceRefund
, sb.BonusBalanceRefundBC
, sb.TokenRefund
, sb.TokenRefundBC
, sb.CashOutStake
, sb.CashOutStakeBC
, sb.CashOutWin
, sb.CashOutWinBC
, pb.LiveYN
, pb.OddsType
, pb.Odds
, pb.EitherwaySort
, sb.ViewId
, sb.Channel
, sb.Operator
from romaniastg.stg_settled_bets as sb
join romaniamain.fd_placed_bets as pb 
on sb.BetId = pb.BetId and sb.SelectionId = pb.SelectionId and sb.MarketId = pb.MarketId
INTO OUTFILE 'D:\\RomData\\dump\\fd_settled_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



###IB_Rejected_Bets_Load.sql

LOAD DATA INFILE 'D:\\RomData\\dump\\Rejected_Bets.csv' 
INTO TABLE romaniastg.stg_rejected_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
 BetslipId
,BetId
,TraderName
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,Username
,CustSegmentName
,UnitStakeAmt
,BetType
,CancelReason
,SelectionDetail
,Odds
,PotentialReturns
,StakeAmt
,TokenStakeAmt
,PotentialReturnsBC
,StakeAmtBC
,BonusStakeAmtBC
,Channel
,ViewName
from romaniastg.stg_rejected_bets_csv
INTO OUTFILE 'D:\\RomData\\dump\\stg_rejected_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\stg_rejected_bets.csv' 
INTO TABLE romaniastg.stg_rejected_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 stg.BetslipId
,stg.BetId
,stg.TraderName
,stg.BetTime
,stg.BetDate
,p.PlayerId
,p.UserName
,p.CurrencyCode
,stg.CustSegmentName
,stg.UnitStakeAmtBC
,stg.BetType
,stg.CancelReason
,stg.SelectionDetail
,stg.Odds
,stg.PotentialReturns
,stg.StakeAmt
,stg.TokenStakeAmt
,stg.PotentialReturnsBC
,stg.StakeAmtBC
,stg.BonusStakeAmtBC
,stg.Channel
,stg.ViewName
from romaniastg.stg_rejected_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.UserName = p.UserName
INTO OUTFILE 'D:\\RomData\\dump\\fd_rejected_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


###IB_Voided_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\Voided_Bets.csv' 
INTO TABLE romaniastg.stg_voided_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
 CustName
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,PlayerId
,Username
,BetId
,BetslipId
,UnitStakeBC
,BetType
,SelectionDetail
,Odds
,BonusStakeDesc
,TotalStakeDesc
,STR_TO_DATE(FirstSettledTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(FirstSettledTime, '%Y-%m-%d %H:%i:%s'))
,BetResult
,FirstSettlerUsername
,STR_TO_DATE(VoidedTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(VoidedTime, '%Y-%m-%d %H:%i:%s'))
,VoiderUsername
INTO OUTFILE 'D:\\RomData\\dump\\stg_voided_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.stg_voided_bets_csv;

LOAD DATA INFILE 'D:\\RomData\\dump\\stg_voided_bets.csv' 
INTO TABLE romaniastg.stg_voided_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select * 
INTO OUTFILE 'D:\\RomData\\dump\\fd_voided_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.stg_voided_bets;


###IB_Open_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\Open_Bets.csv' 
INTO TABLE romaniastg.stg_open_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 BetSlipId
,BetSlipStatus
,BetId
,BetType
,STR_TO_DATE(Placedate, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(Placedate, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,NumLeg
,NumPart
,LegSort
,SelectionId
,Selectionname
,Selectionsort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,PlayerId
,UserName
,CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,DecreasingOdds
,EitherWaySort
,ViewId
,Channel
,Operator
,PotentialReturn
,ViewName
INTO OUTFILE 'D:\\RomData\\dump\\STG_OPEN_BETS.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from romaniastg.stg_open_bets_csv;

LOAD DATA INFILE 'D:\\RomData\\dump\\STG_OPEN_BETS.csv' 
INTO TABLE romaniastg.stg_open_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 BetSlipId
,BetSlipStatus
,BetId
,BetType
,PlaceTime
,BetDate
,BetStatus
,NumLeg
,NumPart
,LegSort
,SelectionId
,Selectionname
,Selectionsort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,p.PlayerId
,p.UserName
,stg.CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,DecreasingOdds
,EitherWaySort
,ViewId
,Channel
,Operator
,PotentialReturn
,ViewName
from romaniastg.stg_open_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId
where BetDate <= date_add(current_Date, interval -1 day)
INTO OUTFILE 'D:\\RomData\\dump\\fd_open_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

