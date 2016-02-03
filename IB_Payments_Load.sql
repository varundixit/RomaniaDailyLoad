##date change 2016-02-02
###place files "SC_IMS_2016-02-02.csv", "CURL_Player_Payments2016-02-02.csv" and "Transactions_information_2016-02-02.csv"
## update file name in Powershell. Run Powershell script, remove headers
##full run

use romaniastg;
drop table CSV_TO_STG;
Create table CSV_TO_STG (
  TxnTime varchar(200)
, AcceptTime varchar(200)
, Username varchar(200)
, Email varchar(200)
, Name varchar(200)
, OBSCCard varchar(200)
, OBSExpDate varchar(200)
, TxnID varchar(200)
, Type varchar(200)
, Method varchar(200)
, Merchant varchar(500)
, Bank varchar(200)
, PayoutOption varchar(200)
, Amount varchar(200)
, OBSPaymentTotal varchar(200)
, Status varchar(200)
, ExtTxnId varchar(200)
, Result varchar(200)
, Reason varchar(4000)
, BonusAdmin varchar(200)
, BDNumber varchar(200)
, CashierTxnID varchar(200)
, PTInfo varchar(500)
, ThreeDSecureProc varchar(10)
, ExtTxnAcc varchar(500)
, Casino varchar(50)
, Comments varchar(200)
, RiskProfile varchar(500)
, Kiosk varchar(200)
, KioskAdmin varchar(200)
, Agent varchar(200)
, Agency varchar(200)
, Currency varchar(10)
, AdjustmentStatus varchar(200)
, Credit varchar(200)
, CreditReverse varchar(200)
, Chargeback varchar(200) 
, ChargebackReverse varchar(200)
, ReturnTxt varchar(200)
, ReturnReverse varchar(200)
, PayMethRiskGrp varchar(200)
, PayMethConfCode varchar(200)
, Channel varchar(200)
, ConvertedAmt varchar(200)
, ConvertedCurrency varchar(10)
, ProcessorAmt varchar(200)
, ProcessorCurrency varchar(10)
)  ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\SC_IMS_2016-02-02.csv'  
INTO TABLE CSV_TO_STG FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\STG_SCIMS_Data.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from CSV_TO_STG as stg join romaniamain.dim_player as p on stg.Username = p.Username;

drop table STG_SCIMS_Data;
Create table STG_SCIMS_Data(
  TxnTime datetime default null
, AcceptTime datetime default null
, Username varchar(200) default null
, PlayerId bigint
, SignupDate date
, FirstDepositDate date
, Email varchar(200) default null
, Name varchar(200) default null
, OBSCCard varchar(200) default null
, OBSExpDate varchar(200) default null
, TxnID bigint(20) default null
, Type varchar(200) default null
, Method varchar(200) default null
, Merchant varchar(500) default null
, Bank varchar(200) default null
, PayoutOption varchar(200) default null
, Amount decimal(18,6) default null
, OBSPaymentTotal decimal(18,6) default null
, Status varchar(200) default null
, ExtTxnId varchar(200) default null
, Result bigint(20) default null
, Reason varchar(4000) default null
, BonusAdmin varchar(200) default null
, BDNumber varchar(200) default null
, CashierTxnID varchar(200) default null
, PTInfo varchar(500) default null
, ThreeDSecureProc varchar(10) default null
, ExtTxnAcc varchar(500) default null
, Casino varchar(50) default null
, Comments varchar(200) default null
, RiskProfile varchar(500) default null
, Kiosk varchar(200) default null
, KioskAdmin varchar(200) default null
, Agent varchar(200) default null
, Agency varchar(200) default null
, Currency varchar(10) default null
, AdjustmentStatus varchar(200) default null
, Credit varchar(200) default null
, CreditReverse varchar(200) default null
, Chargeback varchar(200)  default null
, ChargebackReverse varchar(200) default null
, ReturnTxt varchar(200) default null
, ReturnReverse varchar(200) default null
, PayMethRiskGrp varchar(200) default null
, PayMethConfCode bigint default null
, Channel varchar(200) default null
, ConvertedAmt decimal(18,6) default null
, ConvertedCurrency varchar(10) default null
, ProcessorAmt decimal(18,6) default null
, ProcessorCurrency varchar(10) default null
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\STG_SCIMS_Data.csv'  
INTO TABLE STG_SCIMS_Data FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\STG_SCIMS_Data_MySQL.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from STG_SCIMS_Data;

use romaniastg;
drop table stg_csv_player_payments;
CREATE TABLE `stg_csv_player_payments` (
  `AcceptDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Address` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AdvertiserCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AfterWager` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AgencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AgentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Amount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AuthCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Automaticrequest` char(1) COLLATE latin1_bin DEFAULT NULL,
  `AvsCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BAddress` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Balance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BatchsettleDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_Amount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_CAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_CbAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCity` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCountry` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BillingAutomatic` char(1) COLLATE latin1_bin DEFAULT NULL,
  `BName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusAdminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusBalanceAfterClose` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusLastAction` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BState` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BZip` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CardPin` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CashiertranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CbDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CCardBin` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CcardCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CCardSuffix` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ChannelCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `City` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ClientparameterCode` int ,
  `Clienttype` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Code` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Comments` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CompanyadvtransferBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Comppoints` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ComppointsBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Confirmation` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConfirmDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConvertedAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConvertedcurrencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Country` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CVV2` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositForRedemption` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositOver` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ECI` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ExpDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ExtraMerchantInfo` varchar(300) COLLATE latin1_bin DEFAULT NULL,
  `FirstDeposit` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `FirstName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KeepWinningSpending` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KioskadminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KioskCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `LastactivityDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `LastName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `MerchantAnswer` varchar(2000) COLLATE latin1_bin DEFAULT NULL,
  `MerchantbatchrefCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `MerchantCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Method` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ModificationCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NetworkCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NetworktranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NonRedeemableWithWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ParentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentRequestCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentTotal` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalEmail` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalTranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalTranType` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PendingbonusCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerPaydFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerPMAccountCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PokerRounding` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessingCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessingDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessorAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessorcurrencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PromotionalCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PTInfo` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Quickdeposit` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Redeemed` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemedbonusAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemThreshold` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ReferralCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundCount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundedAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundmadeDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefunduponccmigrationCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefunduponCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteacceptDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteAccountID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteIP` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RequestadminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RequestDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `State` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Status` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Submethod` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Type` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WageringMethod` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WaitingremotepaymentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WinPayment` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTAccName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTAccNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTIban` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTType` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WUFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WULocation` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WUMtcn` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Zip` varchar(200) COLLATE latin1_bin DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\CURL_Player_Payments2016-02-02.csv'  
INTO TABLE stg_csv_player_payments FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\stg_player_payments.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_csv_player_payments as spp 
join romaniamain.dim_client_parameter as cp on spp.ClientparameterCode = cp.ClientParameterCode;


use romaniastg;
drop table stg_player_payments;
CREATE TABLE `stg_player_payments` (
 TxnDate date default null
,TxnTime datetime default null
,Address varchar(200) default null
,AdvertiserCode bigint(20) default null
,Amount decimal(18,6) default null
,AuthCode bigint(20) default null
,AvsCode int default null
,Balance decimal(18,6) default null
,CashiertranID varchar(200) default null
,CCardBin int default null
,CcardCode bigint(20) default null
,CCardSuffix int default null
,City varchar(200) default null
,ClientPlatform varchar(200) default null
,Clienttype varchar(200) default null
,Code bigint(20) default null
,Comppoints decimal(18,6) default null
,Confirmation varchar(200) default null
,Country varchar(200) default null
,DepositWagering int default null
,ExpiryDate datetime default null
,ExtraMerchantInfo varchar(1000) default null
,FirstDeposit int default null
,FirstName varchar(200) default null
,LastactivityDate datetime default null
,LastName varchar(200) default null
,MerchantCode int default null
,Method varchar(200) default null
,PaypalTranID varchar(200) default null
,PlayerCode bigint(20) default null
,PlayerPaydFee int default null
,PromotionalCode bigint(20) default null
,PaymentTxnInfo varchar(200) default null
,RedeemDate datetime default null
,Redeemed int default null
,RedeemedbonusAmount decimal(18,6) default null
,RedeemThreshold int default null
,RemoteIP varchar(200) default null
,RequestDate datetime default null
,Status varchar(200) default null
,Type varchar(200) default null
,WinPayment decimal(18,6) default null
,Zip varchar(200) default null
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\stg_player_payments.csv'  
INTO TABLE stg_player_payments FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
PlayerCode as PlayerId,
TxnDate as SummaryDate,
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

INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\sd_daily_cashier_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from stg_player_payments
where TxnDate = '2016-02-02'
group by PlayerCode,TxnDate;

#select count(distinct PlayerCode) from stg_player_payments;

/*
#use romaniamain;
#drop table sd_daily_cashier_summary;
CREATE TABLE `sd_daily_cashier_summary` (
 PlayerId bigint(20) default null
,SummaryDate date default null
,TotalDepAttemptAmt decimal(18,6) default null
,TotalDepAttemptCnt int default null
,TotalDepDeclineAmt decimal(18,6) default null
,TotalDepDeclineCnt int default null
,TotalDepApproveAmt decimal(18,6) default null
,TotalDepApproveCnt int default null
,TotalDepApproveMobAmt decimal(18,6) default null
,TotalDepApproveMobCnt int default null
,TotalDepApproveWebAmt decimal(18,6) default null
,TotalDepApproveWebCnt int default null
,TotalDepDeclineMobAmt decimal(18,6) default null
,TotalDepDeclineMobCnt int default null
,TotalDepDeclineWebAmt decimal(18,6) default null
,TotalDepDeclineWebCnt int default null
,TotalWithdAttemptAmt decimal(18,6) default null
,TotalWithdAttemptCnt int default null
,TotalWithdDeclineAmt decimal(18,6) default null
,TotalWithdDeclineCnt int default null
,TotalWithdApproveAmt decimal(18,6) default null
,TotalWithdApproveCnt int default null
,TotalWithdApproveMobAmt decimal(18,6) default null
,TotalWithdApproveMobCnt int default null
,TotalWithdApproveWebAmt decimal(18,6) default null
,TotalWithdApproveWebCnt int default null
,TotalWithdDeclineMobAmt decimal(18,6) default null
,TotalWithdDeclineMobCnt int default null
,TotalWithdDeclineWebAmt decimal(18,6) default null
,TotalWithdDeclineWebCnt int default null
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\sd_daily_cashier_summary.csv'  
INTO TABLE romaniamain.sd_daily_cashier_summary 
FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


################Load Player Transactions

drop table romaniastg.stg_transaction_info;
Create table romaniastg.stg_transaction_info(
Code int(10),
Username varchar(100),
Casino varchar(50),
Merchant varchar(50),
Clienttype varchar(50),
Ppcode int(10),
Type varchar(50),
Status varchar(50),
Requestdate datetime,
Currencycode varchar(10),
Amount decimal(18,6),
Bc_amount decimal(18,6),
Balance decimal(18,6),
Bc_balance decimal(18,6),
Method varchar(100),
Paypaltranid varchar(500),
Submethod varchar(50),
Reason varchar(4000)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\Transactions_information_2016-02-02.csv' 
INTO TABLE romaniastg.stg_transaction_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select txn.Code,p.PlayerId,txn.Username,Casino,Merchant,Clienttype,Ppcode,Type,Status ,Requestdate,
date(Requestdate),month(Requestdate),year(Requestdate),txn.Currencycode ,Amount,
Bc_amount ,txn.Balance ,Bc_balance ,Method ,Paypaltranid ,Submethod ,
case when Status = 'approved' then 'NotDeclined'
	 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%card%' then 'InvalidCardDetails'
 when Status = 'declined' and lower(Reason) like '%ndeclined%' and lower(Reason) like '%prctime%' then 'NDeclinedPrcTime'
 when Status = 'declined' and lower(Reason) like '%pick-up%' and lower(Reason) like '%card%' then 'PickUpCardError'
 when Status = 'declined' and lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'RestrictedCard'
 when Status = 'declined' and lower(Reason) like '%approve%' and lower(Reason) like '%referral%' then 'ApproveRegerralError'
 when Status = 'declined' and lower(Reason) like '%timeout/retry%' then 'TimeoutRetry'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%cvv2%' then 'InvalidCVV2'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%token%' then 'InvalidToken'
 when Status = 'declined' and lower(Reason) like '%no%' and lower(Reason) like '%issuer%' then 'NoSuchIssuer'
 when Status = 'declined' and lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'RestrictedCard'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%transaction%' and lower(Reason) like '%exceeded%' then 'InvalidTransaction'
 when Status = 'declined' and lower(Reason) like '%pin%' and lower(Reason) like '%tries%' and lower(Reason) like '%exceeded%' then 'MaximumPinTriesExceeded'
 when Status = 'declined' and lower(Reason) like '%sc_fs_declined_trans%' then 'SC_FS_Declined'
 when Status = 'declined' and lower(Reason) like '%maximum%retry%clear%reach%' then 'MaximumClearanceRetryReached'
 when Status = 'declined' and lower(Reason) like '%issuer%' and lower(Reason) like '%switch%' and lower(Reason) like '%inoperative%' then 'IssuerORSwitchInoperative'
 when Status = 'declined' and lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' then 'TxnNotPermittedToCardHolder'
 when Status = 'declined' and lower(Reason) like '%acquirer%' and lower(Reason) like '%validation%' then 'AcquirerValidationError'
 when Status = 'declined' and lower(Reason) like '%do%' and lower(Reason) like '%not%' and lower(Reason) like '%honor%' then 'DoNotHonor'
 when Status = 'declined' and lower(Reason) like '%exceed%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%frequency%' then 'ExceedsWithdrawalFrequency'
 when Status = 'declined' and lower(Reason) like '%exceed%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%limit%' then 'ExceedsWithdrawalLimit'
 when Status = 'declined' and lower(Reason) like '%expired%' and lower(Reason) like '%card%' and lower(Reason) like '%unavail%' then 'ExpiredCardORUserUnavailable'
 when Status = 'declined' and lower(Reason) like '%insufficient%' and lower(Reason) like '%funds%' then 'InsufficientFunds'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'InvalidToAccount'
 when Status = 'declined' and lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'InvalidToAccount'
 when Status = 'declined' and lower(Reason) like '%generic_error%' and lower(Reason) like '%user%' and lower(Reason) like '%cancelation%' then 'UserCancelled'
 when Status = 'declined' and lower(Reason) like '%567%' then 'SC_FS_Declined'
 else 'NA' end as DeclinedReason
from romaniastg.stg_transaction_info as txn 
join romaniamain.dim_player p on txn.username = p.Username
where date(Requestdate) = '2016-02-02'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\daily_player_transactions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n';

#select distinct type from romaniastg.stg_transaction_info;

/*
drop table romaniamain.daily_player_transactions;
Create table romaniamain.daily_player_transactions(
Code int(10),
PlayerId bigint(20),
Username varchar(50),
Casino varchar(50),
Merchant varchar(50),
Clienttype varchar(50),
Ppcode int(10),
Type varchar(50),
Status varchar(50),
Requestdate datetime,
TxnDate date,
TxnMonth int,
TxnYear int,
Currencycode varchar(10),
Amount decimal(18,6),
Bc_amount decimal(18,6),
Balance decimal(18,6),
Bc_balance decimal(18,6),
Method varchar(100),
Paypaltranid varchar(500),
Submethod varchar(50),
DeclinedReason varchar(500)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\daily_player_transactions.csv' 
INTO TABLE romaniamain.daily_player_transactions
FIELDS TERMINATED BY ',' ENCLOSED BY 'NULL' LINES TERMINATED BY '\r\n';

#select distinct type from romaniamain.daily_player_transactions;