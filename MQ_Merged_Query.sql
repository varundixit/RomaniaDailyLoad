use romaniastage;
drop table `stg_dim_player`;
CREATE TABLE `stg_dim_player` (
  `PlayerID` bigint(20),
  `Username` varchar(100),
  `Gender` varchar(5) DEFAULT NULL,
  `Balance` decimal(18,6) DEFAULT NULL,
  `GlobalFirstDepositDate` datetime,
  `SignupDate` datetime,
  `RomDummy` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_dim_player.csv'
INTO TABLE romaniastage.stg_dim_player FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

use romaniastage;
drop table STG_SCIMS_Data;
Create table STG_SCIMS_Data(
  TxnTime datetime default null
, AcceptTime datetime default null
, Username varchar(200) default null
, PlayerId bigint default null
, SignupDate date default null
, FirstDepositDate date default null
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
) ENGINE=Innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\STG_SCIMS_Data_MySQL.csv'  
INTO TABLE STG_SCIMS_Data FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select Reason, count(*) from STG_SCIMS_Data group by 1;

insert into romaniamain.FACT_DAILY_PLAYER_TRANSACTIONS (
TxnTime, AcceptTime , Username, PlayerId ,SignupDate ,FirstDepositDate ,Email, Name , TxnID, Type , Method, Merchant , Bank , Amount , Status , Result , Reason , ReasonGroup,
CashierTxnID , PTInfo, ThreeDSecureProc , ExtTxnAcc , Casino, Comments, RiskProfile , Agent , Agency , Currency , PayMethRiskGrp, PayMethConfCode)
select
TxnTime, AcceptTime , Username,PlayerId ,SignupDate ,FirstDepositDate ,Email, Name , TxnID, Type , Method, Merchant , Bank , Amount , Status , Result ,
case when lower(Reason) like '%acquirer%' and lower(Reason) like '%validation%' then 'AcquirerValidation'
     when lower(Reason) like '%do%' and lower(Reason) like '%not%' and lower(Reason) like '%honor%' then 'DoNotHonor'
     when lower(Reason) like '%exceeds%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%frequency%' then 'ExceedsWithdrawalFreq'
     when lower(Reason) like '%exceeds%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%limit%' then 'ExceedsWithdrawalLimit'
     when lower(Reason) like '%expired%' and lower(Reason) like '%card%' and lower(Reason) like '%unavail%' then 'ExpiredCardORUserUnAvailable'
     when lower(Reason) like '%incorrect%' and lower(Reason) like '%pin%' then 'IncorrectPin'
     when lower(Reason) like '%insufficient%' and lower(Reason) like '%funds%' then 'InsufficientFunds'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'InvalidToAccount'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%card%' and lower(Reason) like '%number%' then 'InvalidCardNumber'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%cvv2%' then 'InvalidCVV2'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%amount%' then 'InvalidAmount'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%token%' then 'InvalidToken'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%transaction%' then 'InvalidTransaction'
     when lower(Reason) like '%issuer%' and lower(Reason) like '%switch%' and lower(Reason) like '%inoperative%' then 'IssuerORSwitchInoperative'
     when lower(Reason) like '%no%' and lower(Reason) like '%such%' and lower(Reason) like '%issuer%' then 'NoSuchIssuer'
     when lower(Reason) like '%lost%' and lower(Reason) like '%card%' then 'LostCardError'
     when lower(Reason) like '%stolen%' and lower(Reason) like '%card%' then 'StolenCardPickUpMsg'
     when lower(Reason) like '%pick-up%' and lower(Reason) like '%card%' then 'PickUpCardError'
     when lower(Reason) like '%pin%' and lower(Reason) like '%tries%' and lower(Reason) like '%exceeded%' then 'PinTriesExceeded'
     when lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'RestrictedCard'
     when lower(Reason) like '%sc%' and lower(Reason) like '%fs%' and lower(Reason) like '%declined%' then 'SC_FS_DeclinedReason'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' then 'TxnNotPermitted'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' and lower(Reason) like '%terminal%' then 'TxnNotPermittedOnTerminal'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' and lower(Reason) like '%cardholder%' then 'TxnNotPermittedForUser'
     when lower(Reason) like '%apmtransactionid%' and lower(Reason) like '%maximum%' and lower(Reason) like '%retry%' and lower(Reason) like '%clearing%' and lower(Reason) like '%payment%' then 'APMMaxRetryToClearPaymentReached'
     when lower(Reason) like '%generic_error%' and lower(Reason) like '%user%' and lower(Reason) like '%cancelation%' then 'UserCancelled'
     when lower(Reason) like '%timout%' and lower(Reason) like '%retry%' then 'TimeoutRetryError'
     when lower(Reason) like '%approve%' and lower(Reason) like '%referral%' then 'ApproveReferralError'
     when lower(Reason) like '%transaction_mismatch%' and lower(Reason) like '%difference%' then 'TxnIdDifference'
     when lower(Reason) like '%567%' then 'SC_FS_DeclinedReason'
     when lower(Reason) like '%deposit%' and lower(Reason) like '%limit%' and lower(Reason) like '%7%' and lower(Reason) like '%kyc_non-verified%' then 'KYCDepLimit7DayAmtExceeded'
     when lower(Reason) like '%kyc_non-verified%' then 'KYCNonVerified'
     when lower(Reason) like '%maximum%' and lower(Reason) like '%retry%' and lower(Reason) like '%clearing%' and lower(Reason) like '%payment%' then 'MaxRetryToClearPaymentReached'
end as Reason,
case when lower(Reason) like '%acquirer%' and lower(Reason) like '%validation%' then 'SCDeclined'
     when lower(Reason) like '%do%' and lower(Reason) like '%not%' and lower(Reason) like '%honor%' then 'SCDeclined'
     when lower(Reason) like '%exceeds%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%frequency%' then 'SCDeclined'
     when lower(Reason) like '%exceeds%' and lower(Reason) like '%withdrawal%' and lower(Reason) like '%limit%' then 'SCDeclined'
     when lower(Reason) like '%expired%' and lower(Reason) like '%card%' and lower(Reason) like '%unavail%' then 'SCDeclined'
     when lower(Reason) like '%incorrect%' and lower(Reason) like '%pin%' then 'SCDeclined'
     when lower(Reason) like '%insufficient%' and lower(Reason) like '%funds%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%to%' and lower(Reason) like '%account%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%card%' and lower(Reason) like '%number%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%cvv2%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%amount%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%token%' then 'SCDeclined'
     when lower(Reason) like '%invalid%' and lower(Reason) like '%transaction%' then 'SCDeclined'
     when lower(Reason) like '%issuer%' and lower(Reason) like '%switch%' and lower(Reason) like '%inoperative%' then 'SCDeclined'
     when lower(Reason) like '%no%' and lower(Reason) like '%such%' and lower(Reason) like '%issuer%' then 'SCDeclined'
     when lower(Reason) like '%lost%' and lower(Reason) like '%card%' then 'SCDeclined'
     when lower(Reason) like '%stolen%' and lower(Reason) like '%card%' then 'SCDeclined'
     when lower(Reason) like '%pick-up%' and lower(Reason) like '%card%' then 'SCDeclined'
     when lower(Reason) like '%pin%' and lower(Reason) like '%tries%' and lower(Reason) like '%exceeded%' then 'SCDeclined'
     when lower(Reason) like '%restricted%' and lower(Reason) like '%card%' then 'SCDeclined'
     when lower(Reason) like '%sc%' and lower(Reason) like '%fs%' and lower(Reason) like '%declined%' then 'SCDeclined'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' then 'SCDeclined'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' and lower(Reason) like '%terminal%' then 'SCDeclined'
     when lower(Reason) like '%transaction%' and lower(Reason) like '%not%' and lower(Reason) like '%permitted%' and lower(Reason) like '%cardholder%' then 'SCDeclined'
     when lower(Reason) like '%apmtransactionid%' and lower(Reason) like '%maximum%' and lower(Reason) like '%retry%' and lower(Reason) like '%clearing%' and lower(Reason) like '%payment%' then 'IMSRejected'
     when lower(Reason) like '%generic_error%' and lower(Reason) like '%user%' and lower(Reason) like '%cancelation%' then 'IMSRejected'
     when lower(Reason) like '%timout%' and lower(Reason) like '%retry%' then 'SCDeclined'
     when lower(Reason) like '%approve%' and lower(Reason) like '%referral%' then 'SCDeclined'
     when lower(Reason) like '%transaction_mismatch%' and lower(Reason) like '%difference%' then 'IMSRejected'
     when lower(Reason) like '%567%' then 'SCDeclined'
     when lower(Reason) like '%deposit%' and lower(Reason) like '%limit%' and lower(Reason) like '%7%' and lower(Reason) like '%kyc_non-verified%' then 'IMSRejected'
     when lower(Reason) like '%kyc_non-verified%' then 'IMSRejected'
     when lower(Reason) like '%maximum%' and lower(Reason) like '%retry%' and lower(Reason) like '%clearing%' and lower(Reason) like '%payment%' then 'IMSRejected'
end as ReasonGroup,
CashierTxnID , PTInfo, ThreeDSecureProc , ExtTxnAcc , Casino, Comments, RiskProfile , Agent , Agency , Currency , PayMethRiskGrp, PayMethConfCode
from romaniastage.STG_SCIMS_Data ;


use romaniamain;
drop table User_Dep_Curr_Status;
CREATE TABLE `User_Dep_Curr_Status` (
  `Username` varchar(200) NOT NULL,
  `FirstDepositTime` datetime DEFAULT NULL,
  `FirstDepositAmount` decimal(18,6) DEFAULT NULL,
  `LastDepositTime` datetime DEFAULT NULL,
  `LastDepositAmount` decimal(18,6) DEFAULT NULL,
  
  `FirstAttemptDepositTime` datetime DEFAULT NULL,
  `FirstAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
  `LastAttemptDepositTime` datetime DEFAULT NULL,
  `LastAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
  
  `TotalSuccDepAmt` decimal(18,6),
  `TotalSuccDepCnt` int DEFAULT NULL,
  `TotalDecDepAmt` decimal(18,6),
  `TotalDecDepCnt` int DEFAULT NULL,
  `LastTxnStatus` varchar(50),
  `LastTxnMethod`varchar(50),
  `LastTxnMerchant`varchar(100),
  `LastTxnReason` varchar(200),
  `LastTxnReasonGrp` varchar(200),
  `LastTxnRiskProfile` varchar(200),
  `TotalAttemptedDepAmt` decimal(18,6),
  `TotalAttemptedDepCnt` int DEFAULT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=innodb DEFAULT CHARSET=utf8;



insert into User_Dep_Curr_Status (
  Username,
  FirstDepositTime,
  FirstDepositAmount,
  LastDepositTime,
  LastDepositAmount,
  
  FirstAttemptDepositTime,
  FirstAttemptDepositAmount,
  LastAttemptDepositTime,
  LastAttemptDepositAmount,
  
  TotalSuccDepAmt,
  TotalSuccDepCnt,
  TotalDecDepAmt,
  TotalDecDepCnt,
  LastTxnStatus,
  LastTxnMethod,
  LastTxnMerchant,
  LastTxnReason,
  LastTxnReasonGrp,
  LastTxnRiskProfile,
  TotalAttemptedDepAmt,
  TotalAttemptedDepCnt
)
 
select 
 Username
,case when Status = 'approved' then AcceptTime end
,case when Status = 'approved' then Amount else 0 end
,case when Status = 'approved' then AcceptTime end
,case when Status = 'approved' then Amount else 0 end

,AcceptTime
,Amount
,AcceptTime
,Amount

,case when Status = 'approved' then Amount else 0 end
,case when Status = 'approved' then 1 else 0 end
,case when Status = 'declined' then Amount else 0 end
,case when Status = 'declined' then 1 else 0 end
,Status
,Method
,Merchant
,Reason
,ReasonGroup
,RiskProfile
,Amount
,1
from romaniamain.FACT_DAILY_PLAYER_TRANSACTIONS as src where Type = 'deposit'

on duplicate key update 
 
	FirstDepositAmount = IF((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved', src.Amount, FirstDepositAmount)
,	LastDepositAmount = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved', src.Amount, LastDepositAmount)

,	FirstAttemptDepositAmount = IF(src.AcceptTime < FirstAttemptDepositTime, src.Amount, FirstAttemptDepositAmount)
,	LastAttemptDepositAmount = IF(src.AcceptTime > LastAttemptDepositTime , src.Amount, LastAttemptDepositAmount)

,	TotalSuccDepAmt = TotalSuccDepAmt + IF(src.Status = 'approved',src.Amount,0)
,	TotalSuccDepCnt =  TotalSuccDepCnt + IF(src.Status = 'approved',1,0)
,	TotalDecDepAmt = TotalDecDepAmt + IF(src.Status = 'declined',src.Amount,0)
,	TotalDecDepCnt = TotalDecDepCnt + IF(src.Status = 'declined',1,0)
,	LastTxnStatus = IF(src.AcceptTime > LastDepositTime , src.Status, LastTxnStatus)
,	LastTxnMethod = IF(src.AcceptTime > LastDepositTime , src.Method, LastTxnMethod)
,	LastTxnMerchant = IF(src.AcceptTime > LastDepositTime , src.Merchant, LastTxnMerchant)
,	LastTxnReason = IF(src.AcceptTime > LastDepositTime , src.Reason, LastTxnReason)
,	LastTxnReasonGrp = IF(src.AcceptTime > LastDepositTime , src.ReasonGroup, LastTxnReasonGrp)
,	LastTxnRiskProfile = IF(src.AcceptTime > LastDepositTime , src.RiskProfile, LastTxnRiskProfile)
,	TotalAttemptedDepAmt =  TotalAttemptedDepAmt + src.Amount
,	TotalAttemptedDepCnt = TotalAttemptedDepCnt + 1
,	FirstDepositTime = if((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved',src.AcceptTime,FirstDepositTime)
,	LastDepositTime = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved', src.AcceptTime, LastDepositTime)

,	FirstAttemptDepositTime = if(src.AcceptTime < FirstAttemptDepositTime,src.AcceptTime,FirstAttemptDepositTime)
,	LastAttemptDepositTime = IF(src.AcceptTime > LastAttemptDepositTime, src.AcceptTime, LastAttemptDepositTime)

;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\User_Dep_Curr_Status.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from User_Dep_Curr_Status;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\Daily_User_First_Last.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from Daily_User_First_Last;

use romaniamain;
drop table Daily_User_First_Last;
CREATE TABLE Daily_User_First_Last (
  `Username` varchar(200) NOT NULL,
  `SummaryDate` date,
  `SignupDate` date,
  `FirstDepositDate` date,
  `FirstDepositTime` datetime DEFAULT NULL,
  `FirstDepositAmount` decimal(18,6) DEFAULT NULL,
  `LastDepositTime` datetime DEFAULT NULL,
  `LastDepositAmount` decimal(18,6) DEFAULT NULL,
  `TotalSuccDepAmt` decimal(18,6),
  `TotalSuccDepCnt` int DEFAULT NULL,
  `TotalIMSRejectedAmt` decimal(18,6),
  `TotalIMSRejectedCnt` decimal(18,6),
  `TotalSCDeclinedAmt` decimal(18,6),
  `TotalSCDeclinedCnt` int DEFAULT NULL,
  `LastTxnStatus` varchar(50),
  `LastTxnMethod`varchar(50),
  `LastTxnMerchant`varchar(100),
  `LastTxnReason` varchar(200),
  `LastTxnReasonGrp` varchar(200),
  PRIMARY KEY (Username,SummaryDate)
) ENGINE=innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\Daily_User_First_Last.csv'
INTO TABLE Daily_User_First_Last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

insert into Daily_User_First_Last (
  Username,
  SummaryDate,
  SignupDate,
  FirstDepositDate,
  FirstDepositTime,
  FirstDepositAmount,
  LastDepositTime,
  LastDepositAmount,
  TotalSuccDepAmt,
  TotalSuccDepCnt,
  TotalIMSRejectedAmt,
  TotalIMSRejectedCnt,
  TotalSCDeclinedAmt,
  TotalSCDeclinedCnt,
  LastTxnStatus,
  LastTxnMethod,
  LastTxnMerchant,
  LastTxnReason,
  LastTxnReasonGrp
)
 
select 
 Username
,date(AcceptTime)
,SignupDate
,FirstDepositDate
,AcceptTime
,Amount
,AcceptTime
,Amount
,case when Status = 'approved' then Amount else 0 end
,case when Status = 'approved' then 1 else 0 end
,case when Status = 'declined' and ReasonGroup = 'IMSRejected' then Amount else 0 end
,case when Status = 'declined' and ReasonGroup = 'IMSRejected' then 1 else 0 end
,case when Status = 'declined' and ReasonGroup = 'SCDeclined' then Amount else 0 end
,case when Status = 'declined' and ReasonGroup = 'SCDeclined' then 1 else 0 end
,Status
,Method
,Merchant
,Reason
,ReasonGroup

from romaniamain.FACT_DAILY_PLAYER_TRANSACTIONS as src where Type = 'deposit'

on duplicate key update 
 
	FirstDepositAmount = IF((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved', src.Amount, FirstDepositAmount)
,	LastDepositAmount = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved', src.Amount, LastDepositAmount)


,	TotalSuccDepAmt = TotalSuccDepAmt + IF(src.Status = 'approved',src.Amount,0)
,	TotalSuccDepCnt =  TotalSuccDepCnt + IF(src.Status = 'approved',1,0)

,   TotalIMSRejectedAmt = TotalIMSRejectedAmt + IF((src.Status = 'declined' AND ReasonGroup = 'IMSRejected'),src.Amount,0)
,   TotalIMSRejectedCnt = TotalIMSRejectedCnt + IF((src.Status = 'declined' AND ReasonGroup = 'IMSRejected'),src.Amount,0)

,   TotalSCDeclinedAmt = TotalSCDeclinedAmt + IF((src.Status = 'declined' AND ReasonGroup = 'IMSRejected'),src.Amount,0)
,   TotalSCDeclinedCnt = TotalSCDeclinedCnt + IF((src.Status = 'declined' AND ReasonGroup = 'IMSRejected'),src.Amount,0)

,	LastTxnStatus = IF(src.AcceptTime > LastDepositTime , src.Status, LastTxnStatus)
,	LastTxnMethod = IF(src.AcceptTime > LastDepositTime , src.Method, LastTxnMethod)
,	LastTxnMerchant = IF(src.AcceptTime > LastDepositTime , src.Merchant, LastTxnMerchant)
,	LastTxnReason = IF(src.AcceptTime > LastDepositTime , src.Reason, LastTxnReason)
,	LastTxnReasonGrp = IF(src.AcceptTime > LastDepositTime , src.ReasonGroup, LastTxnReasonGrp)

,	FirstDepositTime = if((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved',src.AcceptTime,FirstDepositTime)
,	LastDepositTime = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved', src.AcceptTime, LastDepositTime)

,   SignupDate = src.SignupDate
,   FirstDepositDate = src.FirstDepositDate

;

commit;

#Output to be saved as DailyUserFirstLastWithSegments.csv
select 
  dfl.*
, lt.FirstDepositTime as GlobalFirstDepositTime
, lt.FirstAttemptDepositTime
, case when dfl.SummaryDate = date(lt.FirstDepositTime) then 'NewEntrant'
	   when dfl.SummaryDate > date(lt.FirstDepositTime) then 'Existing'
       when dfl.SummaryDate <= date(lt.FirstAttemptDepositTime) then 'AttemptingFirst'
       when dfl.SummaryDate > date(lt.FirstAttemptDepositTime) then 'UnSuccessPrevTryingToday'
  end as DepositSegment
, case when dfl.SummaryDate = date(dfl.SignupDate) then 'SignedToday'
	   when dfl.SummaryDate > date(dfl.SignupDate) then 'SignedEarlier'
       when dfl.SummaryDate < date(dfl.SignupDate) then 'NotSignedUp'
  end as SignUpSegment
from Daily_User_First_Last as dfl
join User_Dep_Curr_Status as lt on dfl.Username = lt.Username;


#################Query 2: 
use romaniamain;
drop table User_Dep_With_First_Last;
CREATE TABLE `User_Dep_With_First_Last` (
  `PlayerId` bigint(20) NOT NULL,
  `FirstDepositTime` datetime DEFAULT NULL,
  `FirstDepositAmount` decimal(18,6) DEFAULT NULL,
  `LastDepositTime` datetime DEFAULT NULL,
  `LastDepositAmount` decimal(18,6) DEFAULT NULL,
  
  `FirstWithdrawalTime` datetime DEFAULT NULL,
  `FirstWithdrawalAmount` decimal(18,6) DEFAULT NULL,
  `LastWithdrawalTime` datetime DEFAULT NULL,
  `LastWithdrawalAmount` decimal(18,6) DEFAULT NULL,
  
  `FirstAttemptDepositTime` datetime DEFAULT NULL,
  `FirstAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
  `LastAttemptDepositTime` datetime DEFAULT NULL,
  `LastAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
  
  `FirstAttemptWithdrawalTime` datetime DEFAULT NULL,
  `FirstAttemptWithdrawalAmount` decimal(18,6) DEFAULT NULL,
  `LastAttemptWithdrawalTime` datetime DEFAULT NULL,
  `LastAttemptWithdrawalAmount` decimal(18,6) DEFAULT NULL,
  
  `TotalSuccDepAmt` decimal(18,6),
  `TotalSuccDepCnt` int DEFAULT NULL,
  `TotalDecDepAmt` decimal(18,6),
  `TotalDecDepCnt` int DEFAULT NULL,
  `TotalAttemptedDepAmt` decimal(18,6),
  `TotalAttemptedDepCnt` int DEFAULT NULL,
  
  `TotalSuccWithdAmt` decimal(18,6),
  `TotalSuccWithdCnt` int DEFAULT NULL,
  `TotalDecWithdAmt` decimal(18,6),
  `TotalDecWithdCnt` int DEFAULT NULL,
  `TotalAttemptedWithdAmt` decimal(18,6),
  `TotalAttemptedWithdCnt` int DEFAULT NULL,
  
  `LastDepTxnStatus` varchar(50),
  `LastDepTxnMethod`varchar(50),
  `LastDepTxnMerchant`varchar(100),
  `LastDepTxnReason` varchar(200),
  `LastDepTxnReasonGrp` varchar(200),
  `LastDepTxnRiskProfile` varchar(200),
  
  `LastWithdTxnStatus` varchar(50),
  `LastWithdTxnMethod`varchar(50),
  `LastWithdTxnMerchant`varchar(100),
  `LastWithdTxnReason` varchar(200),
  `LastWithdTxnReasonGrp` varchar(200),
  `LastWithdTxnRiskProfile` varchar(200),

  PRIMARY KEY (`PlayerId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;


insert into romaniamain.User_Dep_With_First_Last (
     PlayerId
	,FirstDepositTime
	,FirstDepositAmount
	,LastDepositTime
	,LastDepositAmount
	,FirstWithdrawalTime
	,FirstWithdrawalAmount
	,LastWithdrawalTime
	,LastWithdrawalAmount
	,FirstAttemptDepositTime
	,FirstAttemptDepositAmount
	,LastAttemptDepositTime
	,LastAttemptDepositAmount
	,FirstAttemptWithdrawalTime
	,FirstAttemptWithdrawalAmount
	,LastAttemptWithdrawalTime
	,LastAttemptWithdrawalAmount
	,TotalSuccDepAmt
	,TotalSuccDepCnt
	,TotalDecDepAmt
	,TotalDecDepCnt
	,TotalAttemptedDepAmt
	,TotalAttemptedDepCnt
	,TotalSuccWithdAmt
	,TotalSuccWithdCnt
	,TotalDecWithdAmt
	,TotalDecWithdCnt
	,TotalAttemptedWithdAmt
	,TotalAttemptedWithdCnt
	,LastDepTxnStatus
	,LastDepTxnMethod
	,LastDepTxnMerchant
	,LastDepTxnReason
	,LastDepTxnReasonGrp
	,LastDepTxnRiskProfile
	,LastWithdTxnStatus
	,LastWithdTxnMethod
	,LastWithdTxnMerchant
	,LastWithdTxnReason
	,LastWithdTxnReasonGrp
	,LastWithdTxnRiskProfile
)
 
select 
 dim.PlayerId
,case when Type = 'deposit' and Status = 'approved' then AcceptTime end
,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end
,case when Type = 'deposit' and Status = 'approved' then AcceptTime end
,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end

,case when Type = 'withdraw' and Status = 'approved' then AcceptTime end
,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'approved' then AcceptTime end
,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end

,case when Type = 'deposit' then AcceptTime end
,case when Type = 'deposit' then Amount end
,case when Type = 'deposit' then AcceptTime end
,case when Type = 'deposit' then Amount end

,case when Type = 'withdraw' then AcceptTime end
,case when Type = 'withdraw' then Amount end
,case when Type = 'withdraw' then AcceptTime end
,case when Type = 'withdraw' then Amount end

,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end
,case when Type = 'deposit' and Status = 'approved' then 1 else 0 end
,case when Type = 'deposit' and Status = 'declined' then Amount else 0 end
,case when Type = 'deposit' and Status = 'declined' then 1 else 0 end
,case when Type = 'deposit' then Amount else 0 end
,case when Type = 'deposit' then 1 else 0 end


,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'approved' then 1 else 0 end
,case when Type = 'withdraw' and Status = 'declined' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'declined' then 1 else 0 end
,case when Type = 'withdraw' then Amount else 0 end
,case when Type = 'withdraw' then 1 else 0 end

,case when Type = 'deposit' then Status end
,case when Type = 'deposit' then Method end
,case when Type = 'deposit' then Merchant end
,case when Type = 'deposit' then Reason end
,case when Type = 'deposit' then ReasonGroup end
,case when Type = 'deposit' then RiskProfile end

,case when Type = 'withdraw' then Status end
,case when Type = 'withdraw' then Method end
,case when Type = 'withdraw' then Merchant end
,case when Type = 'withdraw' then Reason end
,case when Type = 'withdraw' then ReasonGroup end
,case when Type = 'withdraw' then RiskProfile end

from romaniamain.FACT_DAILY_PLAYER_TRANSACTIONS as src join romaniastage.stg_dim_player as dim on src.Username = dim.Username


on duplicate key update 
 
	FirstDepositAmount = IF((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.Amount, FirstDepositAmount)
,	LastDepositAmount = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.Amount, LastDepositAmount)

,	FirstWithdrawalAmount = IF((src.AcceptTime < FirstWithdrawalTime OR FirstWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.Amount, FirstWithdrawalAmount)
,	LastWithdrawalAmount = IF((src.AcceptTime > LastWithdrawalTime OR LastWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.Amount, LastWithdrawalAmount)

,	FirstAttemptDepositAmount = IF((src.AcceptTime < FirstAttemptDepositTime OR FirstAttemptDepositTime is null) AND src.Type = 'deposit', src.Amount, FirstAttemptDepositAmount)
,	LastAttemptDepositAmount = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Amount, LastAttemptDepositAmount)

,	FirstAttemptWithdrawalAmount = IF((src.AcceptTime < FirstAttemptWithdrawalTime OR FirstAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Amount, FirstAttemptWithdrawalAmount)
,	LastAttemptWithdrawalAmount = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Amount, LastAttemptWithdrawalAmount)

,	TotalSuccDepAmt = TotalSuccDepAmt + IF(src.Type = 'deposit' AND src.Status = 'approved',src.Amount,0)
,	TotalSuccDepCnt =  TotalSuccDepCnt + IF(src.Type = 'deposit' AND src.Status = 'approved',1,0)
,	TotalDecDepAmt = TotalDecDepAmt + IF(src.Type = 'deposit' AND src.Status = 'declined',src.Amount,0)
,	TotalDecDepCnt = TotalDecDepCnt + IF(src.Type = 'deposit' AND src.Status = 'declined',1,0)
,	TotalAttemptedDepAmt =  TotalAttemptedDepCnt + IF(src.Type = 'deposit',src.Amount,0)
,	TotalAttemptedDepCnt = TotalAttemptedDepCnt + IF(src.Type = 'deposit',1,0)

,	TotalSuccWithdAmt = TotalSuccWithdAmt + IF(src.Type = 'withdraw' AND src.Status = 'approved',src.Amount,0)
,	TotalSuccWithdCnt =  TotalSuccWithdCnt + IF(src.Type = 'withdraw' AND src.Status = 'approved',1,0)
,	TotalDecWithdAmt = TotalDecWithdAmt + IF(src.Type = 'withdraw' AND src.Status = 'declined',src.Amount,0)
,	TotalDecWithdCnt = TotalDecWithdCnt + IF(src.Type = 'withdraw' AND src.Status = 'declined',1,0)
,	TotalAttemptedWithdAmt =  TotalAttemptedWithdAmt + IF(src.Type = 'withdraw',src.Amount,0)
,	TotalAttemptedWithdCnt = TotalAttemptedWithdCnt + IF(src.Type = 'withdraw',1,0)

,	LastDepTxnStatus = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Status, LastDepTxnStatus)
,	LastDepTxnMethod = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Method, LastDepTxnMethod)
,	LastDepTxnMerchant = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Merchant, LastDepTxnMerchant)
,	LastDepTxnReason = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Reason, LastDepTxnReason)
,	LastDepTxnReasonGrp = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.ReasonGroup, LastDepTxnReasonGrp)
,	LastDepTxnRiskProfile = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.RiskProfile, LastDepTxnRiskProfile)

,	LastWithdTxnStatus = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Status, LastWithdTxnStatus)
,	LastWithdTxnMethod = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Method, LastWithdTxnMethod)
,	LastWithdTxnMerchant = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Merchant, LastWithdTxnMerchant)
,	LastWithdTxnReason = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Reason, LastWithdTxnReason)
,	LastWithdTxnReasonGrp = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.ReasonGroup, LastWithdTxnReasonGrp)
,	LastWithdTxnRiskProfile = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.RiskProfile, LastWithdTxnRiskProfile)

,	FirstDepositTime = if((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit',src.AcceptTime,FirstDepositTime)
,	LastDepositTime = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.AcceptTime, LastDepositTime)

,	FirstWithdrawalTime = if((src.AcceptTime < FirstWithdrawalTime OR FirstWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw',src.AcceptTime,FirstWithdrawalTime)
,	LastWithdrawalTime = IF((src.AcceptTime > LastWithdrawalTime OR LastWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.AcceptTime, LastWithdrawalTime)

,	FirstAttemptDepositTime = if((src.AcceptTime < FirstAttemptDepositTime OR FirstAttemptDepositTime is null) AND src.Type = 'deposit',src.AcceptTime,FirstAttemptDepositTime)
,	LastAttemptDepositTime = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.AcceptTime, LastAttemptDepositTime)

,	FirstAttemptWithdrawalTime = if((src.AcceptTime < FirstAttemptWithdrawalTime OR FirstAttemptWithdrawalTime is null) AND src.Type = 'withdraw',src.AcceptTime,FirstAttemptWithdrawalTime)
,	LastAttemptWithdrawalTime = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.AcceptTime, LastAttemptWithdrawalTime)
;
commit;


# to be exported
select * from romaniamain.User_Dep_With_First_Last;


#############################Query 3:
use romaniastage;
drop table fd_csc_eg_player_product_info_summ;
CREATE TABLE `fd_csc_eg_player_product_info_summ` (
  `PlayerId` int(11) DEFAULT NULL,
  `SummaryDate` date DEFAULT NULL,
  `GameDate` datetime DEFAULT NULL,
  `Bet` decimal(18,4) DEFAULT NULL,
  `CashBet` decimal(18,4) DEFAULT NULL,
  `BonusBet` decimal(18,4) DEFAULT NULL,
  `Win` decimal(18,4) DEFAULT NULL,
  `CashWin` decimal(18,4) DEFAULT NULL,
  `BonusWin` decimal(18,4) DEFAULT NULL,
  `BonusFreeGamesCount` decimal(18,4) DEFAULT NULL,
  `FreeGamesCount` decimal(18,4) DEFAULT NULL,
  `JackpotBet` decimal(18,4) DEFAULT NULL,
  `JackpotWin` decimal(18,4) DEFAULT NULL,
  `ClientPlatform` varchar(100) DEFAULT NULL,
  `ClientType` varchar(100) DEFAULT NULL,
  `CasinoType` varchar(100) DEFAULT NULL,
  `GameType` varchar(100) DEFAULT NULL,
  `GameName` varchar(100) DEFAULT NULL,
  `RomDummy` int(11) DEFAULT NULL
) ENGINE=innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_csc_eg_player_product_info_summ.csv'
INTO TABLE fd_csc_eg_player_product_info_summ FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\eg_player_first_last_totals.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
romaniamain.eg_player_first_last_totals;


use romaniamain;
drop table eg_player_first_last_totals;
create table `eg_player_first_last_totals`(
	`PlayerId` bigint(20),
    `FirstCashBetDate` datetime DEFAULT NULL,
    `FirstCashBetAmt` decimal(18,4) DEFAULT NULL,
    `FirstCashBetChannel` varchar(20) DEFAULT NULL,
	`FirstBonusBetDate` datetime DEFAULT NULL,
    `FirstBonusBetAmt` decimal(18,4) DEFAULT NULL,
    `FirstBonusBetChannel` varchar(20) DEFAULT NULL,
    
	`FirstCashWinDate` datetime DEFAULT NULL,
    `FirstCashWinAmt` decimal(18,4) DEFAULT NULL,
    `FirstCashWinChannel` varchar(20) DEFAULT NULL,
	`FirstBonusWinDate` datetime DEFAULT NULL,
    `FirstBonusWinAmt` decimal(18,4) DEFAULT NULL,
    `FirstBonusWinChannel` varchar(20) DEFAULT NULL,
    
	`LastCashBetDate` datetime DEFAULT NULL,
    `LastCashBetAmt` decimal(18,4) DEFAULT NULL,
    `LastCashBetChannel` varchar(20) DEFAULT NULL,
	`LastBonusBetDate` datetime DEFAULT NULL,
    `LastBonusBetAmt` decimal(18,4) DEFAULT NULL,
    `LastBonusBetChannel` varchar(20) DEFAULT NULL,
    
	`LastCashWinDate` datetime DEFAULT NULL,
    `LastCashWinAmt` decimal(18,4) DEFAULT NULL,
    `LastCashWinChannel` varchar(20) DEFAULT NULL,
	`LastBonusWinDate` datetime DEFAULT NULL,
    `LastBonusWinAmt` decimal(18,4) DEFAULT NULL,
    `LastBonusWinChannel` varchar(20) DEFAULT NULL,
    
    `TotalBetAmt` decimal(18,4) DEFAULT NULL,
    `TotalCashBetAmount` decimal(18,4) DEFAULT NULL,
    `TotalBonusBetAmount` decimal(18,4) DEFAULT NULL,
    
	`TotalWinAmt` decimal(18,4) DEFAULT NULL,
    `TotalCashWinAmount` decimal(18,4) DEFAULT NULL,
    `TotalBonusWinAmount` decimal(18,4) DEFAULT NULL,
    
    `LastChannel` varchar(20) default null,
    `LastGamePlayDate` datetime default null,
    `LastPlayedCasinoType` varchar(100) default null,
    `LastPlayedGameType` varchar(100) default null,
    `LastPlayedGameName` varchar(100) default null,
    
    PRIMARY KEY (`PlayerId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\eg_player_first_last_totals.csv'
INTO TABLE eg_player_first_last_totals FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

commit;

insert into eg_player_first_last_totals
(
 PlayerId
,FirstCashBetDate
,FirstCashBetAmt
,FirstCashBetChannel
,FirstBonusBetDate
,FirstBonusBetAmt
,FirstBonusBetChannel
,FirstCashWinDate
,FirstCashWinAmt
,FirstCashWinChannel
,FirstBonusWinDate
,FirstBonusWinAmt
,FirstBonusWinChannel
,LastCashBetDate
,LastCashBetAmt
,LastCashBetChannel
,LastBonusBetDate
,LastBonusBetAmt
,LastBonusBetChannel
,LastCashWinDate
,LastCashWinAmt
,LastCashWinChannel
,LastBonusWinDate
,LastBonusWinAmt
,LastBonusWinChannel
,TotalBetAmt
,TotalCashBetAmount
,TotalBonusBetAmount
,TotalWinAmt
,TotalCashWinAmount
,TotalBonusWinAmount
,LastChannel
,LastGamePlayDate
,LastPlayedCasinoType
,LastPlayedGameType
,LastPlayedGameName
)
select
Playerid,
(case when CashBet > 0 then GameDate end) ,
(case when CashBet > 0 then CashBet else 0 end) ,
(case when CashBet > 0 then ClientPlatform end),
(case when BonusBet > 0 then GameDate end) ,
(case when BonusBet > 0 then BonusBet else 0 end) ,
(case when BonusBet > 0 then ClientPlatform end) ,

(case when CashWin > 0 then GameDate end) ,
(case when CashWin > 0 then CashWin else 0 end) ,
(case when CashWin > 0 then ClientPlatform end) ,
(case when BonusWin > 0 then GameDate end) ,
(case when BonusWin > 0 then BonusWin else 0 end) ,
(case when BonusWin > 0 then ClientPlatform end) ,

(case when CashBet > 0 then GameDate end) ,
(case when CashBet > 0 then CashBet else 0 end) ,
(case when CashBet > 0 then ClientPlatform end) ,
(case when BonusBet > 0 then GameDate end) ,
(case when BonusBet > 0 then BonusBet else 0 end) ,
(case when BonusBet > 0 then ClientPlatform end) ,

(case when CashWin > 0 then GameDate end) ,
(case when CashWin > 0 then CashWin else 0 end) ,
(case when CashWin > 0 then ClientPlatform end) ,
(case when BonusWin > 0 then GameDate end) ,
(case when BonusWin > 0 then BonusWin else 0 end) ,
(case when BonusWin > 0 then ClientPlatform end) ,

Bet,
CashBet,
BonusBet,
Win,
CashWin,
BonusWin,

ClientPlatform,
GameDate,
CasinoType,
GameType,
GameName
from romaniastage.fd_csc_eg_player_product_info_summ as src

on duplicate key update 

  FirstCashBetAmt = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0) , src.CashBet, FirstCashBetAmt)
, FirstCashBetChannel = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0), src.ClientPlatform, FirstCashBetChannel)
, FirstBonusBetAmt = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0) , src.BonusBet, FirstBonusBetAmt)
, FirstBonusBetChannel = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0) , src.ClientPlatform, FirstBonusBetChannel)

, FirstCashWinAmt = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0), src.CashWin, FirstCashWinAmt)
, FirstCashWinChannel = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0) , src.ClientPlatform, FirstCashWinChannel)
, FirstBonusWinAmt = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0), src.BonusWin, FirstBonusWinAmt)
, FirstBonusWinChannel = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0) , src.ClientPlatform, FirstBonusWinChannel)

, LastCashBetAmt = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0), src.CashBet, LastCashBetAmt)
, LastCashBetChannel = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0), src.ClientPlatform, LastCashBetChannel)
, LastBonusBetAmt = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0) , src.BonusBet, LastBonusBetAmt)
, LastBonusBetChannel = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0), src.ClientPlatform, LastBonusBetChannel)

, LastCashWinAmt = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0), src.CashWin, LastCashWinAmt)
, LastCashWinChannel = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0) , src.ClientPlatform, LastCashWinChannel)
, LastBonusWinAmt = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0), src.BonusWin, LastBonusWinAmt)
, LastBonusWinChannel = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0), src.ClientPlatform, LastBonusWinChannel)

, TotalBetAmt = TotalBetAmt + src.Bet
, TotalCashBetAmount = TotalCashBetAmount + src.CashBet
, TotalBonusBetAmount = TotalBonusBetAmount + src.BonusBet
, TotalWinAmt = TotalWinAmt + src.Win
, TotalCashWinAmount = TotalCashWinAmount + src.CashWin
, TotalBonusWinAmount = TotalBonusWinAmount + src.BonusWin

, LastChannel = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.ClientPlatform, LastChannel)
, LastPlayedCasinoType = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.CasinoType, LastPlayedCasinoType)
, LastPlayedGameType = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.GameType, LastPlayedGameType)
, LastPlayedGameName = IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null), src.GameName, LastPlayedGameName)

, FirstCashBetDate = IF(((src.GameDate < FirstCashBetDate OR FirstCashBetDate is null) AND src.CashBet > 0), src.GameDate, FirstCashBetDate)
, FirstBonusBetDate = IF(((src.GameDate < FirstBonusBetDate OR FirstBonusBetDate is null) AND src.BonusBet > 0),src.GameDate,FirstBonusBetDate)
, FirstCashWinDate = IF(((src.GameDate < FirstCashWinDate OR FirstCashWinDate is null) AND src.CashWin > 0),src.GameDate,FirstCashWinDate)
, FirstBonusWinDate = IF(((src.GameDate < FirstBonusWinDate OR FirstBonusWinDate is null) AND src.BonusWin > 0),src.GameDate,FirstBonusWinDate)
, LastCashBetDate = IF(((src.GameDate >= LastCashBetDate OR LastCashBetDate is null) AND src.CashBet > 0),src.GameDate,LastCashBetDate)
, LastBonusBetDate = IF(((src.GameDate >= LastBonusBetDate OR LastBonusBetDate is null) AND src.BonusBet > 0),src.GameDate,LastBonusBetDate)
, LastCashWinDate = IF(((src.GameDate >= LastCashWinDate OR LastCashWinDate is null) AND src.CashWin > 0),src.GameDate,LastCashWinDate)
, LastBonusWinDate = IF(((src.GameDate >= LastBonusWinDate OR LastBonusWinDate is null) AND src.BonusWin > 0),src.GameDate,LastBonusWinDate)
, LastGamePlayDate =  IF((src.GameDate >= LastGamePlayDate OR LastGamePlayDate is null),src.GameDate,LastGamePlayDate)

;
commit;


###############################Query 4:
use romaniastage;
Drop table stg_sp_gv_player_first_last;
CREATE TABLE `stg_sp_gv_player_first_last` ( 
 PlayerId bigint(20) NOT NULL
,BetTime datetime NOT NULL
,Channel varchar(20)
,BetClass varchar(20)
,BetType varchar(20)
,BetslipId bigint(20) NOT NULL
,BetId bigint(20) NOT NULL
,BetSlipStatus varchar(20)
,LiveYN varchar(20)
,SelectionName varchar(500)
,MarketName varchar(500)
,EventName varchar(500)
,TypeName varchar(500)
,ClassName varchar(500)
,Sport varchar(500)
,Odds varchar(20)
,StakeAmt decimal(18,6) DEFAULT NULL
,CashStakeAmt decimal(18,6) DEFAULT NULL
,BonusStakeAmt decimal(18,6) DEFAULT NULL
,BonusBalanceStake decimal(18,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_gv_placed_bets_simple_sgl.csv'
INTO TABLE romaniastage.stg_sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_gv_placed_bets_simple_combi.csv'
INTO TABLE romaniastage.stg_sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

commit;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\sp_gv_player_first_last.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.sp_gv_player_first_last;

use romaniamain;
Drop table sp_gv_player_first_last;
CREATE TABLE `sp_gv_player_first_last` ( 
 PlayerId bigint(20) NOT NULL
,SglLvFirstBetTime datetime DEFAULT NULL
,SglLvFirstChannel varchar(20) DEFAULT NULL
,SglLvFirstSelectionName varchar(500) DEFAULT NULL
,SglLvFirstMarketName varchar(500) DEFAULT NULL
,SglLvFirstEventName varchar(500) DEFAULT NULL
,SglLvFirstTypeName varchar(500) DEFAULT NULL
,SglLvFirstClassName varchar(500) DEFAULT NULL
,SglLvFirstSport varchar(500) DEFAULT NULL
,SglLvFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglPmFirstBetTime datetime DEFAULT NULL
,SglPmFirstChannel varchar(20) DEFAULT NULL
,SglPmFirstSelectionName varchar(500) DEFAULT NULL
,SglPmFirstMarketName varchar(500) DEFAULT NULL
,SglPmFirstEventName varchar(500) DEFAULT NULL
,SglPmFirstTypeName varchar(500) DEFAULT NULL
,SglPmFirstClassName varchar(500) DEFAULT NULL
,SglPmFirstSport varchar(500) DEFAULT NULL
,SglPmFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,CmbFirstBetTime datetime DEFAULT NULL
,CmbFirstChannel varchar(20) DEFAULT NULL
,CmbFirstSelectionName varchar(500) DEFAULT NULL
,CmbFirstMarketName varchar(500) DEFAULT NULL
,CmbFirstEventName varchar(500) DEFAULT NULL
,CmbFirstTypeName varchar(500) DEFAULT NULL
,CmbFirstClassName varchar(500) DEFAULT NULL
,CmbFirstSport varchar(500) DEFAULT NULL
,CmbFirstCashStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglLvLastBetTime datetime DEFAULT NULL
,SglLvLastChannel varchar(20) DEFAULT NULL
,SglLvLastSelectionName varchar(500) DEFAULT NULL
,SglLvLastMarketName varchar(500) DEFAULT NULL
,SglLvLastEventName varchar(500) DEFAULT NULL
,SglLvLastTypeName varchar(500) DEFAULT NULL
,SglLvLastClassName varchar(500) DEFAULT NULL
,SglLvLastSport varchar(500) DEFAULT NULL
,SglLvLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,SglPmLastBetTime datetime DEFAULT NULL
,SglPmLastChannel varchar(20) DEFAULT NULL
,SglPmLastSelectionName varchar(500) DEFAULT NULL
,SglPmLastMarketName varchar(500) DEFAULT NULL
,SglPmLastEventName varchar(500) DEFAULT NULL
,SglPmLastTypeName varchar(500) DEFAULT NULL
,SglPmLastClassName varchar(500) DEFAULT NULL
,SglPmLastSport varchar(500) DEFAULT NULL
,SglPmLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,CmbLastBetTime datetime DEFAULT NULL
,CmbLastChannel varchar(20) DEFAULT NULL
,CmbLastSelectionName varchar(500) DEFAULT NULL
,CmbLastMarketName varchar(500) DEFAULT NULL
,CmbLastEventName varchar(500) DEFAULT NULL
,CmbLastTypeName varchar(500) DEFAULT NULL
,CmbLastClassName varchar(500) DEFAULT NULL
,CmbLastSport varchar(500) DEFAULT NULL
,CmbLastCashStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusBalStkAmt decimal(18,6) DEFAULT NULL

,PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\sp_gv_player_first_last.csv'
INTO TABLE sp_gv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

insert into sp_gv_player_first_last
(
 PlayerId
,SglLvFirstBetTime
,SglLvFirstChannel
,SglLvFirstSelectionName
,SglLvFirstMarketName
,SglLvFirstEventName
,SglLvFirstTypeName
,SglLvFirstClassName
,SglLvFirstSport
,SglLvFirstCashStkAmt
,SglLvFirstBonusStkAmt
,SglLvFirstBonusBalStkAmt
,SglPmFirstBetTime
,SglPmFirstChannel
,SglPmFirstSelectionName
,SglPmFirstMarketName
,SglPmFirstEventName
,SglPmFirstTypeName
,SglPmFirstClassName
,SglPmFirstSport
,SglPmFirstCashStkAmt
,SglPmFirstBonusStkAmt
,SglPmFirstBonusBalStkAmt
,CmbFirstBetTime
,CmbFirstChannel
,CmbFirstSelectionName
,CmbFirstMarketName
,CmbFirstEventName
,CmbFirstTypeName
,CmbFirstClassName
,CmbFirstSport
,CmbFirstCashStkAmt
,CmbFirstBonusStkAmt
,CmbFirstBonusBalStkAmt
,SglLvLastBetTime
,SglLvLastChannel
,SglLvLastSelectionName
,SglLvLastMarketName
,SglLvLastEventName
,SglLvLastTypeName
,SglLvLastClassName
,SglLvLastSport
,SglLvLastCashStkAmt
,SglLvLastBonusStkAmt
,SglLvLastBonusBalStkAmt
,SglPmLastBetTime
,SglPmLastChannel
,SglPmLastSelectionName
,SglPmLastMarketName
,SglPmLastEventName
,SglPmLastTypeName
,SglPmLastClassName
,SglPmLastSport
,SglPmLastCashStkAmt
,SglPmLastBonusStkAmt
,SglPmLastBonusBalStkAmt
,CmbLastBetTime
,CmbLastChannel
,CmbLastSelectionName
,CmbLastMarketName
,CmbLastEventName
,CmbLastTypeName
,CmbLastClassName
,CmbLastSport
,CmbLastCashStkAmt
,CmbLastBonusStkAmt
,CmbLastBonusBalStkAmt
)

select
 PlayerId
,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end

,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end

,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end

from
romaniastage.stg_sp_gv_player_first_last as src

on duplicate key update 

  SglLvFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Channel,SglLvFirstChannel)
, SglLvFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.SelectionName,SglLvFirstSelectionName)
, SglLvFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.MarketName,SglLvFirstMarketName)
, SglLvFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.EventName,SglLvFirstEventName)
, SglLvFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.TypeName,SglLvFirstTypeName)
, SglLvFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.ClassName,SglLvFirstClassName)
, SglLvFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Sport,SglLvFirstSport)
, SglLvFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashStakeAmt,SglLvFirstCashStkAmt)
, SglLvFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusStakeAmt,SglLvFirstBonusStkAmt)
, SglLvFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceStake,SglLvFirstBonusBalStkAmt)

, SglPmFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Channel,SglPmFirstChannel)
, SglPmFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.SelectionName,SglPmFirstSelectionName)
, SglPmFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.MarketName,SglPmFirstMarketName)
, SglPmFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.EventName,SglPmFirstEventName)
, SglPmFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.TypeName,SglPmFirstTypeName)
, SglPmFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.ClassName,SglPmFirstClassName)
, SglPmFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Sport,SglPmFirstSport)
, SglPmFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashStakeAmt,SglPmFirstCashStkAmt)
, SglPmFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusStakeAmt,SglPmFirstBonusStkAmt)
, SglPmFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceStake,SglPmFirstBonusBalStkAmt)

, CmbFirstChannel = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Channel,CmbFirstChannel)
, CmbFirstSelectionName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.SelectionName,CmbFirstSelectionName)
, CmbFirstMarketName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.MarketName,CmbFirstMarketName)
, CmbFirstEventName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.EventName,CmbFirstEventName)
, CmbFirstTypeName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.TypeName,CmbFirstTypeName)
, CmbFirstClassName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.ClassName,CmbFirstClassName)
, CmbFirstSport = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Sport,CmbFirstSport)
, CmbFirstCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashStakeAmt,CmbFirstCashStkAmt)
, CmbFirstBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusStakeAmt,CmbFirstBonusStkAmt)
, CmbFirstBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceStake,CmbFirstBonusBalStkAmt)

, SglLvLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Channel,SglLvLastChannel)
, SglLvLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.SelectionName,SglLvLastSelectionName)
, SglLvLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.MarketName,SglLvLastMarketName)
, SglLvLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.EventName,SglLvLastEventName)
, SglLvLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.TypeName,SglLvLastTypeName)
, SglLvLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.ClassName,SglLvLastClassName)
, SglLvLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Sport,SglLvLastSport)
, SglLvLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashStakeAmt,SglLvLastCashStkAmt)
, SglLvLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusStakeAmt,SglLvLastBonusStkAmt)
, SglLvLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceStake,SglLvLastBonusBalStkAmt)

, SglPmLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Channel,SglPmLastChannel)
, SglPmLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.SelectionName,SglPmLastSelectionName)
, SglPmLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.MarketName,SglPmLastMarketName)
, SglPmLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.EventName,SglPmLastEventName)
, SglPmLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.TypeName,SglPmLastTypeName)
, SglPmLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.ClassName,SglPmLastClassName)
, SglPmLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Sport,SglPmLastSport)
, SglPmLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashStakeAmt,SglPmLastCashStkAmt)
, SglPmLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusStakeAmt,SglPmLastBonusStkAmt)
, SglPmLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceStake,SglPmLastBonusBalStkAmt)

, CmbLastChannel = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Channel,CmbLastChannel)
, CmbLastSelectionName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.SelectionName,CmbLastSelectionName)
, CmbLastMarketName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.MarketName,CmbLastMarketName)
, CmbLastEventName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.EventName,CmbLastEventName)
, CmbLastTypeName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.TypeName,CmbLastTypeName)
, CmbLastClassName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.ClassName,CmbLastClassName)
, CmbLastSport = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Sport,CmbLastSport)
, CmbLastCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashStakeAmt,CmbLastCashStkAmt)
, CmbLastBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusStakeAmt,CmbLastBonusStkAmt)
, CmbLastBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceStake,CmbLastBonusBalStkAmt)


, SglLvFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BetTime,SglLvFirstBetTime)
, SglPmFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BetTime,SglPmFirstBetTime)
, CmbFirstBetTime = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BetTime,CmbFirstBetTime)
, SglLvLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BetTime,SglLvLastBetTime)
, SglPmLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BetTime,SglPmLastBetTime)
, CmbLastBetTime = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BetTime,CmbLastBetTime)

;

commit;

##########################Query 5:
use romaniastage;
Drop table stg_sp_cv_player_first_last;
CREATE TABLE `stg_sp_cv_player_first_last` ( 
 PlayerId bigint(20) NOT NULL
,BetTime datetime NOT NULL
,Channel varchar(20)
,BetClass varchar(20)
,BetType varchar(20)
,BetslipId bigint(20) NOT NULL
,BetId bigint(20) NOT NULL
,BetSlipStatus varchar(20)
,LiveYN varchar(20)
,SelectionName varchar(500)
,MarketName varchar(500)
,EventName varchar(500)
,TypeName varchar(500)
,ClassName varchar(500)
,Sport varchar(500)
,Odds varchar(20)
,TotalStakeAmt decimal(18,6) DEFAULT NULL
,CashStakeAmt decimal(18,6) DEFAULT NULL
,BonusStakeAmt decimal(18,6) DEFAULT NULL
,BonusBalanceStake decimal(18,6) DEFAULT NULL
,TotalReturn decimal(18,6) DEFAULT NULL
,CashReturn decimal(18,6) DEFAULT NULL
,BonusBalanceReturn decimal(18,6) DEFAULT NULL
,CashRefund decimal(18,6) DEFAULT NULL
,BonusBalanceRefund decimal(18,6) DEFAULT NULL
,TokenRefund decimal(18,6) DEFAULT NULL
,CashOutStake decimal(18,6) DEFAULT NULL
,CashOutWin decimal(18,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_fd_cv_placed_bets_simple_sgl.csv'
INTO TABLE romaniastage.stg_sp_cv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_fd_cv_placed_bets_simple_combi.csv'
INTO TABLE romaniastage.stg_sp_cv_player_first_last FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\sp_cv_player_first_last_totals.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.sp_cv_player_first_last_totals;

use romaniamain;
Drop table sp_cv_player_first_last_totals;
CREATE TABLE `sp_cv_player_first_last_totals` ( 
 PlayerId bigint(20) NOT NULL
,SglLvFirstBetTime datetime DEFAULT NULL
,SglLvFirstChannel varchar(20) DEFAULT NULL
,SglLvFirstSelectionName varchar(500) DEFAULT NULL
,SglLvFirstMarketName varchar(500) DEFAULT NULL
,SglLvFirstEventName varchar(500) DEFAULT NULL
,SglLvFirstTypeName varchar(500) DEFAULT NULL
,SglLvFirstClassName varchar(500) DEFAULT NULL
,SglLvFirstSport varchar(500) DEFAULT NULL
,SglLvFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL
,SglLvFirstCashReturn decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,SglLvFirstCashRefund decimal(18,6) DEFAULT NULL
,SglLvFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,SglLvFirstTokenRefund decimal(18,6) DEFAULT NULL
,SglLvFirstCashOutStk decimal(18,6) DEFAULT NULL
,SglLvFirstCashOutWin decimal(18,6) DEFAULT NULL

,SglPmFirstBetTime datetime DEFAULT NULL
,SglPmFirstChannel varchar(20) DEFAULT NULL
,SglPmFirstSelectionName varchar(500) DEFAULT NULL
,SglPmFirstMarketName varchar(500) DEFAULT NULL
,SglPmFirstEventName varchar(500) DEFAULT NULL
,SglPmFirstTypeName varchar(500) DEFAULT NULL
,SglPmFirstClassName varchar(500) DEFAULT NULL
,SglPmFirstSport varchar(500) DEFAULT NULL
,SglPmFirstCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL
,SglPmFirstCashReturn decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,SglPmFirstCashRefund decimal(18,6) DEFAULT NULL
,SglPmFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,SglPmFirstTokenRefund decimal(18,6) DEFAULT NULL
,SglPmFirstCashOutStk decimal(18,6) DEFAULT NULL
,SglPmFirstCashOutWin decimal(18,6) DEFAULT NULL

,CmbFirstBetTime datetime DEFAULT NULL
,CmbFirstChannel varchar(20) DEFAULT NULL
,CmbFirstSelectionName varchar(500) DEFAULT NULL
,CmbFirstMarketName varchar(500) DEFAULT NULL
,CmbFirstEventName varchar(500) DEFAULT NULL
,CmbFirstTypeName varchar(500) DEFAULT NULL
,CmbFirstClassName varchar(500) DEFAULT NULL
,CmbFirstSport varchar(500) DEFAULT NULL
,CmbFirstCashStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalStkAmt decimal(18,6) DEFAULT NULL
,CmbFirstCashReturn decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalReturn decimal(18,6) DEFAULT NULL
,CmbFirstCashRefund decimal(18,6) DEFAULT NULL
,CmbFirstBonusBalRefund decimal(18,6) DEFAULT NULL
,CmbFirstTokenRefund decimal(18,6) DEFAULT NULL
,CmbFirstCashOutStk decimal(18,6) DEFAULT NULL
,CmbFirstCashOutWin decimal(18,6) DEFAULT NULL

,SglLvLastBetTime datetime DEFAULT NULL
,SglLvLastChannel varchar(20) DEFAULT NULL
,SglLvLastSelectionName varchar(500) DEFAULT NULL
,SglLvLastMarketName varchar(500) DEFAULT NULL
,SglLvLastEventName varchar(500) DEFAULT NULL
,SglLvLastTypeName varchar(500) DEFAULT NULL
,SglLvLastClassName varchar(500) DEFAULT NULL
,SglLvLastSport varchar(500) DEFAULT NULL
,SglLvLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalStkAmt decimal(18,6) DEFAULT NULL
,SglLvLastCashReturn decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalReturn decimal(18,6) DEFAULT NULL
,SglLvLastCashRefund decimal(18,6) DEFAULT NULL
,SglLvLastBonusBalRefund decimal(18,6) DEFAULT NULL
,SglLvLastTokenRefund decimal(18,6) DEFAULT NULL
,SglLvLastCashOutStk decimal(18,6) DEFAULT NULL
,SglLvLastCashOutWin decimal(18,6) DEFAULT NULL

,SglPmLastBetTime datetime DEFAULT NULL
,SglPmLastChannel varchar(20) DEFAULT NULL
,SglPmLastSelectionName varchar(500) DEFAULT NULL
,SglPmLastMarketName varchar(500) DEFAULT NULL
,SglPmLastEventName varchar(500) DEFAULT NULL
,SglPmLastTypeName varchar(500) DEFAULT NULL
,SglPmLastClassName varchar(500) DEFAULT NULL
,SglPmLastSport varchar(500) DEFAULT NULL
,SglPmLastCashStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalStkAmt decimal(18,6) DEFAULT NULL
,SglPmLastCashReturn decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalReturn decimal(18,6) DEFAULT NULL
,SglPmLastCashRefund decimal(18,6) DEFAULT NULL
,SglPmLastBonusBalRefund decimal(18,6) DEFAULT NULL
,SglPmLastTokenRefund decimal(18,6) DEFAULT NULL
,SglPmLastCashOutStk decimal(18,6) DEFAULT NULL
,SglPmLastCashOutWin decimal(18,6) DEFAULT NULL

,CmbLastBetTime datetime DEFAULT NULL
,CmbLastChannel varchar(20) DEFAULT NULL
,CmbLastSelectionName varchar(500) DEFAULT NULL
,CmbLastMarketName varchar(500) DEFAULT NULL
,CmbLastEventName varchar(500) DEFAULT NULL
,CmbLastTypeName varchar(500) DEFAULT NULL
,CmbLastClassName varchar(500) DEFAULT NULL
,CmbLastSport varchar(500) DEFAULT NULL
,CmbLastCashStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusStkAmt decimal(18,6) DEFAULT NULL
,CmbLastBonusBalStkAmt decimal(18,6) DEFAULT NULL
,CmbLastCashReturn decimal(18,6) DEFAULT NULL
,CmbLastBonusBalReturn decimal(18,6) DEFAULT NULL
,CmbLastCashRefund decimal(18,6) DEFAULT NULL
,CmbLastBonusBalRefund decimal(18,6) DEFAULT NULL
,CmbLastTokenRefund decimal(18,6) DEFAULT NULL
,CmbLastCashOutStk decimal(18,6) DEFAULT NULL
,CmbLastCashOutWin decimal(18,6) DEFAULT NULL

,TotalCashStkAmt decimal(18,6) DEFAULT NULL
,TotalBonusStkAmt decimal(18,6) DEFAULT NULL
,TotalBonusBalStkAmt decimal(18,6) DEFAULT NULL
,TotalCashReturn decimal(18,6) DEFAULT NULL
,TotalBonusBalReturn decimal(18,6) DEFAULT NULL
,TotalCashRefund decimal(18,6) DEFAULT NULL
,TotalBonusBalRefund decimal(18,6) DEFAULT NULL
,TotalTokenRefund decimal(18,6) DEFAULT NULL
,TotalCashOutStk decimal(18,6) DEFAULT NULL
,TotalCashOutWin decimal(18,6) DEFAULT NULL
,PRIMARY KEY (PlayerId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\sp_cv_player_first_last_totals.csv'
INTO TABLE sp_cv_player_first_last_totals FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

insert into romaniamain.sp_cv_player_first_last_totals
(
 PlayerId
,SglLvFirstBetTime
,SglLvFirstChannel
,SglLvFirstSelectionName
,SglLvFirstMarketName
,SglLvFirstEventName
,SglLvFirstTypeName
,SglLvFirstClassName
,SglLvFirstSport
,SglLvFirstCashStkAmt
,SglLvFirstBonusStkAmt
,SglLvFirstBonusBalStkAmt
,SglLvFirstCashReturn
,SglLvFirstBonusBalReturn
,SglLvFirstCashRefund
,SglLvFirstBonusBalRefund
,SglLvFirstTokenRefund
,SglLvFirstCashOutStk
,SglLvFirstCashOutWin
,SglPmFirstBetTime
,SglPmFirstChannel
,SglPmFirstSelectionName
,SglPmFirstMarketName
,SglPmFirstEventName
,SglPmFirstTypeName
,SglPmFirstClassName
,SglPmFirstSport
,SglPmFirstCashStkAmt
,SglPmFirstBonusStkAmt
,SglPmFirstBonusBalStkAmt
,SglPmFirstCashReturn
,SglPmFirstBonusBalReturn
,SglPmFirstCashRefund
,SglPmFirstBonusBalRefund
,SglPmFirstTokenRefund
,SglPmFirstCashOutStk
,SglPmFirstCashOutWin
,CmbFirstBetTime
,CmbFirstChannel
,CmbFirstSelectionName
,CmbFirstMarketName
,CmbFirstEventName
,CmbFirstTypeName
,CmbFirstClassName
,CmbFirstSport
,CmbFirstCashStkAmt
,CmbFirstBonusStkAmt
,CmbFirstBonusBalStkAmt
,CmbFirstCashReturn
,CmbFirstBonusBalReturn
,CmbFirstCashRefund
,CmbFirstBonusBalRefund
,CmbFirstTokenRefund
,CmbFirstCashOutStk
,CmbFirstCashOutWin
,SglLvLastBetTime
,SglLvLastChannel
,SglLvLastSelectionName
,SglLvLastMarketName
,SglLvLastEventName
,SglLvLastTypeName
,SglLvLastClassName
,SglLvLastSport
,SglLvLastCashStkAmt
,SglLvLastBonusStkAmt
,SglLvLastBonusBalStkAmt
,SglLvLastCashReturn
,SglLvLastBonusBalReturn
,SglLvLastCashRefund
,SglLvLastBonusBalRefund
,SglLvLastTokenRefund
,SglLvLastCashOutStk
,SglLvLastCashOutWin
,SglPmLastBetTime
,SglPmLastChannel
,SglPmLastSelectionName
,SglPmLastMarketName
,SglPmLastEventName
,SglPmLastTypeName
,SglPmLastClassName
,SglPmLastSport
,SglPmLastCashStkAmt
,SglPmLastBonusStkAmt
,SglPmLastBonusBalStkAmt
,SglPmLastCashReturn
,SglPmLastBonusBalReturn
,SglPmLastCashRefund
,SglPmLastBonusBalRefund
,SglPmLastTokenRefund
,SglPmLastCashOutStk
,SglPmLastCashOutWin
,CmbLastBetTime
,CmbLastChannel
,CmbLastSelectionName
,CmbLastMarketName
,CmbLastEventName
,CmbLastTypeName
,CmbLastClassName
,CmbLastSport
,CmbLastCashStkAmt
,CmbLastBonusStkAmt
,CmbLastBonusBalStkAmt
,CmbLastCashReturn
,CmbLastBonusBalReturn
,CmbLastCashRefund
,CmbLastBonusBalRefund
,CmbLastTokenRefund
,CmbLastCashOutStk
,CmbLastCashOutWin
,TotalCashStkAmt
,TotalBonusStkAmt
,TotalBonusBalStkAmt
,TotalCashReturn
,TotalBonusBalReturn
,TotalCashRefund
,TotalBonusBalRefund
,TotalTokenRefund
,TotalCashOutStk
,TotalCashOutWin
)
select
 PlayerId
,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutWin end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutWin end


,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end
,case when BetClass = 'Combi' then CashReturn end
,case when BetClass = 'Combi' then BonusBalanceReturn end
,case when BetClass = 'Combi' then CashRefund end
,case when BetClass = 'Combi' then BonusBalanceRefund end
,case when BetClass = 'Combi' then TokenRefund end
,case when BetClass = 'Combi' then CashOutStake end
,case when BetClass = 'Combi' then CashOutWin end


,case when BetClass = 'Single' and LiveYN = 'Y' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'Y' then Channel end
,case when BetClass = 'Single' and LiveYN = 'Y' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'Y' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'Y' then EventName end
,case when BetClass = 'Single' and LiveYN = 'Y' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'Y' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'Y' then Sport end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'Y' then CashOutWin end

,case when BetClass = 'Single' and LiveYN = 'N' then BetTime end
,case when BetClass = 'Single' and LiveYN = 'N' then Channel end
,case when BetClass = 'Single' and LiveYN = 'N' then SelectionName end
,case when BetClass = 'Single' and LiveYN = 'N' then MarketName end
,case when BetClass = 'Single' and LiveYN = 'N' then EventName end
,case when BetClass = 'Single' and LiveYN = 'N' then TypeName end
,case when BetClass = 'Single' and LiveYN = 'N' then ClassName end
,case when BetClass = 'Single' and LiveYN = 'N' then Sport end
,case when BetClass = 'Single' and LiveYN = 'N' then CashStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusStakeAmt end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceReturn end
,case when BetClass = 'Single' and LiveYN = 'N' then CashRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then BonusBalanceRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then TokenRefund end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutStake end
,case when BetClass = 'Single' and LiveYN = 'N' then CashOutWin end


,case when BetClass = 'Combi' then BetTime end
,case when BetClass = 'Combi' then Channel end
,case when BetClass = 'Combi' then SelectionName end
,case when BetClass = 'Combi' then MarketName end
,case when BetClass = 'Combi' then EventName end
,case when BetClass = 'Combi' then TypeName end
,case when BetClass = 'Combi' then ClassName end
,case when BetClass = 'Combi' then Sport end
,case when BetClass = 'Combi' then CashStakeAmt end
,case when BetClass = 'Combi' then BonusStakeAmt end
,case when BetClass = 'Combi' then BonusBalanceStake end
,case when BetClass = 'Combi' then CashReturn end
,case when BetClass = 'Combi' then BonusBalanceReturn end
,case when BetClass = 'Combi' then CashRefund end
,case when BetClass = 'Combi' then BonusBalanceRefund end
,case when BetClass = 'Combi' then TokenRefund end
,case when BetClass = 'Combi' then CashOutStake end
,case when BetClass = 'Combi' then CashOutWin end

,CashStakeAmt
,BonusStakeAmt
,BonusBalanceStake
,CashReturn
,BonusBalanceReturn
,CashRefund
,BonusBalanceRefund
,TokenRefund
,CashOutStake
,CashOutWin

from
romaniastage.stg_sp_cv_player_first_last as src

on duplicate key update 

  SglLvFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Channel,SglLvFirstChannel)
, SglLvFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.SelectionName,SglLvFirstSelectionName)
, SglLvFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.MarketName,SglLvFirstMarketName)
, SglLvFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.EventName,SglLvFirstEventName)
, SglLvFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.TypeName,SglLvFirstTypeName)
, SglLvFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.ClassName,SglLvFirstClassName)
, SglLvFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.Sport,SglLvFirstSport)
, SglLvFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashStakeAmt,SglLvFirstCashStkAmt)
, SglLvFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusStakeAmt,SglLvFirstBonusStkAmt)
, SglLvFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceStake,SglLvFirstBonusBalStkAmt)
, SglLvFirstCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashReturn,SglLvFirstCashReturn)
, SglLvFirstBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceReturn,SglLvFirstBonusBalReturn)
, SglLvFirstCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashRefund,SglLvFirstCashRefund)
, SglLvFirstBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BonusBalanceRefund,SglLvFirstBonusBalRefund)
, SglLvFirstTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.TokenRefund,SglLvFirstTokenRefund)
, SglLvFirstCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashOutStake,SglLvFirstCashOutStk)
, SglLvFirstCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.CashOutWin,SglLvFirstCashOutWin)

, SglPmFirstChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Channel,SglPmFirstChannel)
, SglPmFirstSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.SelectionName,SglPmFirstSelectionName)
, SglPmFirstMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.MarketName,SglPmFirstMarketName)
, SglPmFirstEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.EventName,SglPmFirstEventName)
, SglPmFirstTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.TypeName,SglPmFirstTypeName)
, SglPmFirstClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.ClassName,SglPmFirstClassName)
, SglPmFirstSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.Sport,SglPmFirstSport)
, SglPmFirstCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashStakeAmt,SglPmFirstCashStkAmt)
, SglPmFirstBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusStakeAmt,SglPmFirstBonusStkAmt)
, SglPmFirstBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceStake,SglPmFirstBonusBalStkAmt)
, SglPmFirstCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashReturn,SglPmFirstCashReturn)
, SglPmFirstBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceReturn,SglPmFirstBonusBalReturn)
, SglPmFirstCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashRefund,SglPmFirstCashRefund)
, SglPmFirstBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BonusBalanceRefund,SglPmFirstBonusBalRefund)
, SglPmFirstTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.TokenRefund,SglPmFirstTokenRefund)
, SglPmFirstCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashOutStake,SglPmFirstCashOutStk)
, SglPmFirstCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.CashOutWin,SglPmFirstCashOutWin)

, CmbFirstChannel = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Channel,CmbFirstChannel)
, CmbFirstSelectionName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.SelectionName,CmbFirstSelectionName)
, CmbFirstMarketName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.MarketName,CmbFirstMarketName)
, CmbFirstEventName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.EventName,CmbFirstEventName)
, CmbFirstTypeName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.TypeName,CmbFirstTypeName)
, CmbFirstClassName = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.ClassName,CmbFirstClassName)
, CmbFirstSport = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.Sport,CmbFirstSport)
, CmbFirstCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashStakeAmt,CmbFirstCashStkAmt)
, CmbFirstBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusStakeAmt,CmbFirstBonusStkAmt)
, CmbFirstBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceStake,CmbFirstBonusBalStkAmt)
, CmbFirstCashReturn = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashReturn,CmbFirstCashReturn)
, CmbFirstBonusBalReturn = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceReturn,CmbFirstBonusBalReturn)
, CmbFirstCashRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashRefund,CmbFirstCashRefund)
, CmbFirstBonusBalRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BonusBalanceRefund,CmbFirstBonusBalRefund)
, CmbFirstTokenRefund = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.TokenRefund,CmbFirstTokenRefund)
, CmbFirstCashOutStk = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashOutStake,CmbFirstCashOutStk)
, CmbFirstCashOutWin = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.CashOutWin,CmbFirstCashOutWin)

, SglLvLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Channel,SglLvLastChannel)
, SglLvLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.SelectionName,SglLvLastSelectionName)
, SglLvLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.MarketName,SglLvLastMarketName)
, SglLvLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.EventName,SglLvLastEventName)
, SglLvLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.TypeName,SglLvLastTypeName)
, SglLvLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.ClassName,SglLvLastClassName)
, SglLvLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.Sport,SglLvLastSport)
, SglLvLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashStakeAmt,SglLvLastCashStkAmt)
, SglLvLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusStakeAmt,SglLvLastBonusStkAmt)
, SglLvLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceStake,SglLvLastBonusBalStkAmt)
, SglLvLastCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashReturn,SglLvLastCashReturn)
, SglLvLastBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceReturn,SglLvLastBonusBalReturn)
, SglLvLastCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashRefund,SglLvLastCashRefund)
, SglLvLastBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BonusBalanceRefund,SglLvLastBonusBalRefund)
, SglLvLastTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.TokenRefund,SglLvLastTokenRefund)
, SglLvLastCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashOutStake,SglLvLastCashOutStk)
, SglLvLastCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.CashOutWin,SglLvLastCashOutWin)

, SglPmLastChannel = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Channel,SglPmLastChannel)
, SglPmLastSelectionName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.SelectionName,SglPmLastSelectionName)
, SglPmLastMarketName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.MarketName,SglPmLastMarketName)
, SglPmLastEventName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.EventName,SglPmLastEventName)
, SglPmLastTypeName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.TypeName,SglPmLastTypeName)
, SglPmLastClassName = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.ClassName,SglPmLastClassName)
, SglPmLastSport = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.Sport,SglPmLastSport)
, SglPmLastCashStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashStakeAmt,SglPmLastCashStkAmt)
, SglPmLastBonusStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusStakeAmt,SglPmLastBonusStkAmt)
, SglPmLastBonusBalStkAmt = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceStake,SglPmLastBonusBalStkAmt)
, SglPmLastCashReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashReturn,SglPmLastCashReturn)
, SglPmLastBonusBalReturn = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceReturn,SglPmLastBonusBalReturn)
, SglPmLastCashRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashRefund,SglPmLastCashRefund)
, SglPmLastBonusBalRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BonusBalanceRefund,SglPmLastBonusBalRefund)
, SglPmLastTokenRefund = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.TokenRefund,SglPmLastTokenRefund)
, SglPmLastCashOutStk = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashOutStake,SglPmLastCashOutStk)
, SglPmLastCashOutWin = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.CashOutWin,SglPmLastCashOutWin)

, CmbLastChannel = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Channel,CmbLastChannel)
, CmbLastSelectionName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.SelectionName,CmbLastSelectionName)
, CmbLastMarketName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.MarketName,CmbLastMarketName)
, CmbLastEventName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.EventName,CmbLastEventName)
, CmbLastTypeName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.TypeName,CmbLastTypeName)
, CmbLastClassName = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.ClassName,CmbLastClassName)
, CmbLastSport = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.Sport,CmbLastSport)
, CmbLastCashStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashStakeAmt,CmbLastCashStkAmt)
, CmbLastBonusStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusStakeAmt,CmbLastBonusStkAmt)
, CmbLastBonusBalStkAmt = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceStake,CmbLastBonusBalStkAmt)
, CmbLastCashReturn = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashReturn,CmbLastCashReturn)
, CmbLastBonusBalReturn = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceReturn,CmbLastBonusBalReturn)
, CmbLastCashRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashRefund,CmbLastCashRefund)
, CmbLastBonusBalRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BonusBalanceRefund,CmbLastBonusBalRefund)
, CmbLastTokenRefund = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.TokenRefund,CmbLastTokenRefund)
, CmbLastCashOutStk = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashOutStake,CmbLastCashOutStk)
, CmbLastCashOutWin = IF((src.BetClass = 'Combi'  and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.CashOutWin,CmbLastCashOutWin)

,TotalCashStkAmt = TotalCashStkAmt + src.CashStakeAmt
,TotalBonusStkAmt = TotalBonusStkAmt + src.BonusStakeAmt
,TotalBonusBalStkAmt = TotalBonusBalStkAmt + src.BonusBalanceStake
,TotalCashReturn = TotalCashReturn + src.CashReturn
,TotalBonusBalReturn = TotalBonusBalReturn + src.BonusBalanceReturn
,TotalCashRefund = TotalCashRefund + src.CashRefund
,TotalBonusBalRefund = TotalBonusBalRefund + src.BonusBalanceRefund
,TotalTokenRefund = TotalTokenRefund + src.TokenRefund
,TotalCashOutStk = TotalCashOutStk + src.CashOutStake
,TotalCashOutWin = TotalCashOutWin + src.CashOutWin

, SglLvFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime < SglLvFirstBetTime) OR (SglLvFirstBetTime is null),src.BetTime,SglLvFirstBetTime)
, SglPmFirstBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime < SglPmFirstBetTime) OR (SglPmFirstBetTime is null),src.BetTime,SglPmFirstBetTime)
, CmbFirstBetTime = IF((src.BetClass = 'Combi' and src.BetTime < CmbFirstBetTime) OR (CmbFirstBetTime is null),src.BetTime,CmbFirstBetTime)
, SglLvLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'Y' and src.BetTime >= SglLvLastBetTime) OR (SglLvLastBetTime is null),src.BetTime,SglLvLastBetTime)
, SglPmLastBetTime = IF((src.BetClass = 'Single' and src.LiveYN = 'N' and src.BetTime >= SglPmLastBetTime) OR (SglPmLastBetTime is null),src.BetTime,SglPmLastBetTime)
, CmbLastBetTime = IF((src.BetClass = 'Combi' and src.BetTime >= CmbLastBetTime) OR (CmbLastBetTime is null),src.BetTime,CmbLastBetTime)

;
commit;


###############################Query 6:
use romaniastage;
drop table stg_player_lifetime_apd;
CREATE TABLE `stg_player_lifetime_apd` (
  `PlayerID` bigint(20) DEFAULT NULL,
  `SystemAPD` int DEFAULT NULL,
  `SportsAPD` int DEFAULT NULL,
  `EGamingAPD` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerAPD_Daily.csv'
INTO TABLE romaniastage.stg_player_lifetime_apd FIELDS TERMINATED BY ';'  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
;

insert into romaniamain.f_player_lifetime_apd
( PlayerID,LTSystemAPD,LTSportsAPD,LTEGamingAPD)
select PlayerID,SystemAPD,SportsAPD,EGamingAPD
from romaniastage.stg_player_lifetime_apd as src
on duplicate key update 
LTSystemAPD = LTSystemAPD + src.SystemAPD,
LTSportsAPD = LTSportsAPD + src.SportsAPD,
LTEGamingAPD = LTEGamingAPD + src.EGamingAPD;
commit;

################################Query 7:
use romaniastage;
drop table stg_daily_logins;
CREATE TABLE `stg_daily_logins` (
  `ClientType` varchar(200) DEFAULT NULL,
  `LoginId` int(9) DEFAULT NULL,
  `EndBalance` decimal(18,6) DEFAULT NULL,
  `EndBonusBalance` decimal(18,6) DEFAULT NULL,
  `FunPlayerCode` int(9) DEFAULT NULL,
  `HwSerial` int(9) DEFAULT NULL,
  `IP` varchar(200) DEFAULT NULL,
  `KioskCode` int(9) DEFAULT NULL,
  `LoginDate` datetime DEFAULT NULL,
  `LogoutDate` datetime DEFAULT NULL,
  `PlayerCode` int(9) DEFAULT NULL,
  `PlayerType` varchar(200) DEFAULT NULL,
  `SerialCode` varchar(200) DEFAULT NULL,
  `ServerCode` varchar(200) DEFAULT NULL,
  `SessionId` varchar(200) DEFAULT NULL,
  `Startbalance` decimal(18,6) DEFAULT NULL,
  `Startbonusbalance` decimal(18,6) DEFAULT NULL,
  `Version` varchar(200) DEFAULT NULL,
  `ClientPlatform` varchar(200) DEFAULT NULL,
  `LoginDeviceTypeCode` int(9) DEFAULT NULL,
  `LoginVenueCode` int(9) DEFAULT NULL
) ENGINE=innodb DEFAULT CHARSET=utf8;

commit;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_stg_daily_player_logins.csv' 
INTO TABLE  romaniastage.stg_daily_logins
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@vClientType, @vLoginId, @vEndBalance, @vEndBonusBalance, @vFunPlayerCode, @vHwSerial, @vIP, @vKioskCode, @vLoginDate, @vLogoutDate, @vPlayerCode, @vPlayerType, @vSerialCode, @vServerCode, @vSessionId, @vStartbalance, @vStartbonusbalance, @vVersion, @vClientPlatform, @vLoginDeviceTypeCode, @vLoginVenueCode)
SET
ClientType = nullif(@vClientType, ''),
LoginId = nullif(@vLoginId, ''),
EndBalance = nullif(@vEndBalance, ''),
EndBonusBalance = nullif(@vEndBonusBalance, ''),
FunPlayerCode = nullif(@vFunPlayerCode, ''),
HwSerial = nullif(@vHwSerial, ''),
IP = nullif(@vIP, ''),
KioskCode = nullif(@vKioskCode, ''),
LoginDate = nullif(@vLoginDate, ''),
LogoutDate = nullif(@vLogoutDate, ''),
PlayerCode = nullif(@vPlayerCode, ''),
PlayerType = nullif(@vPlayerType, ''),
SerialCode = nullif(@vSerialCode, ''),
ServerCode = nullif(@vServerCode, ''),
SessionId = nullif(@vSessionId, ''),
Startbalance = nullif(@vStartbalance, ''),
Startbonusbalance = nullif(@vStartbonusbalance, ''),
Version = nullif(@vVersion, ''),
ClientPlatform = nullif(@vClientPlatform, ''),
LoginDeviceTypeCode = nullif(@vLoginDeviceTypeCode, ''),
LoginVenueCode = nullif(@vLoginVenueCode, '');


######################################################### Completed Logins ################################################################

insert into  romaniamain.fd_daily_logins_open
(
 Product
,SummaryDate
,LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerId
,PlayerType
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,LoginChannel
,LoginDeviceTypeCode
,LoginVenueCode
)
select 
 ClientType
,date(LoginDate)
,LoginId
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
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
from
romaniastage.stg_daily_logins where LogoutDate is null;

commit;


######################################################### Completed Logins ################################################################

insert into  romaniamain.fd_daily_logins_completed
(
 Product
,SummaryDate
,LoginId
,EndCashBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerId
,PlayerType
,SerialCode
,ServerCode
,SessionId
,StartCashbalance
,Startbonusbalance
,Version
,LoginChannel
,LoginDeviceTypeCode
,LoginVenueCode
)
select 
 ClientType
,date(LoginDate)
,LoginId
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
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
from
romaniastage.stg_daily_logins where LogoutDate is not null;

commit;

############################################################ Player First Last ##################################################################
select * from romaniamain.fd_daily_logins_completed;

drop table romaniamain.daily_player_login_first_last;
CREATE TABLE romaniamaindaily_player_login_first_last (
   PlayerId bigint(20),
   SummaryDate date,
   PlayerType varchar(50) DEFAULT NULL,
   FirstLoginTime datetime DEFAULT NULL,
   LastLogoutTime datetime DEFAULT NULL,
   FirstCashBalance decimal(18,6) DEFAULT NULL,
   FirstBonusBalance decimal(18,6) DEFAULT NULL,
   LastCashBalance decimal(18,6) DEFAULT NULL,
   LastBonusBalance decimal(18,6) DEFAULT NULL,
   LoginCounts int,
   PRIMARY KEY (`PlayerId`,`SummaryDate`)
 ) ENGINE=Innodb DEFAULT CHARSET=utf8;
 

insert into romaniamain.daily_player_login_first_last(
	 PlayerId
	,SummaryDate
	,PlayerType
	,FirstLoginTime
	,LastLogoutTime
	,FirstCashBalance
	,FirstBonusBalance
	,LastCashBalance
	,LastBonusBalance
    ,LoginCounts
)
select 
PlayerId,
SummaryDate,
PlayerType,
LoginDate,
LogoutDate,
StartCashBalance,
StartBonusBalance,
EndCashBalance,
EndBonusBalance,
1
from romaniamain.fd_daily_logins_completed as src 

on duplicate key update 

  FirstCashBalance = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.StartCashBalance,FirstCashBalance)
, FirstBonusBalance = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.StartBonusBalance,FirstBonusBalance)

, LastCashBalance = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <> 3000 AND src.EndCashBalance is not null),src.EndCashBalance,LastCashBalance)
, LastBonusBalance = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <>3000 AND src.EndBonusBalance is not null),src.EndBonusBalance,LastBonusBalance)

, FirstLoginTime = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.LoginDate,FirstLoginTime)
, LastLogoutTime = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,LastLogoutTime)

, PlayerType = src.PlayerType
, LoginCounts = LoginCounts + 1
;

commit;


############################################### Player Lifetime First Last ###############################################################
use romaniamain;
drop table player_login_first_last;
CREATE TABLE player_login_first_last (
   PlayerId bigint(20),
   PlayerType varchar(50) DEFAULT NULL,
   FirstLoginDate datetime DEFAULT NULL,
   LastLoginDate datetime DEFAULT NULL,
   FirstLogoutDate datetime DEFAULT NULL,
   LastLogoutDate datetime DEFAULT NULL,
   FirstCashBalance decimal(18,6) DEFAULT NULL,
   FirstBonusBalance decimal(18,6) DEFAULT NULL,
   CurrentCashBalance decimal(18,6) DEFAULT NULL,
   CurrentBonusBalance decimal(18,6) DEFAULT NULL,
   PRIMARY KEY (`PlayerId`)
 ) ENGINE=Innodb DEFAULT CHARSET=utf8;
 
insert into romaniamain.player_login_first_last(
	 PlayerId
	,PlayerType
	,FirstLoginDate
	,LastLoginDate
	,FirstLogoutDate
	,LastLogoutDate
	,FirstCashBalance
	,FirstBonusBalance
	,CurrentCashBalance
	,CurrentBonusBalance
)
select 
PlayerId,
PlayerType,
LoginDate,
LoginDate,
LogoutDate,
LogoutDate,
StartCashBalance,
StartBonusBalance,
EndCashBalance,
EndBonusBalance
from romaniamain.fd_daily_logins_completed as src 

on duplicate key update 

  FirstCashBalance = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.StartCashBalance,FirstCashBalance)
, FirstBonusBalance = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.StartBonusBalance,FirstBonusBalance)

, CurrentCashBalance = IF(((src.LogoutDate > LastLogoutDate OR LastLogoutDate is null) AND year(src.LogoutDate) <> 3000 AND src.EndCashBalance is not null),src.EndCashBalance,CurrentCashBalance)
, CurrentBonusBalance = IF(((src.LogoutDate > LastLogoutDate OR LastLogoutDate is null) AND year(src.LogoutDate) <>3000 AND src.EndBonusBalance is not null),src.EndBonusBalance,CurrentBonusBalance)

, FirstLoginDate = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.LoginDate,FirstLoginDate)
, LastLoginDate = IF((src.LoginDate > LastLoginDate OR LastLoginDate is null),src.LoginDate,LastLoginDate)

, FirstLogoutDate = IF(((src.LogoutDate < FirstLogoutDate OR FirstLogoutDate is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,FirstLogoutDate)
, LastLogoutDate = IF(((src.LogoutDate > LastLoginDate OR LastLogoutDate is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,LastLogoutDate)

, PlayerType = src.PlayerType

;
commit;

################################Query 8:
##Output to be saved as CRM_Report
select
  p.PlayerId
, p.Gender
, p.SignupDate
, p.GlobalFirstDepositDate as FirstDepositDate
, dw.FirstDepositTime
, dw.FirstDepositAmount
, dw.LastDepositTime
, dw.LastDepositAmount
, dw.FirstWithdrawalTime
, dw.FirstWithdrawalAmount
, dw.LastWithdrawalTime
, dw.LastWithdrawalAmount
, dw.LastAttemptDepositTime
, dw.LastAttemptDepositAmount
, dw.LastDepTxnStatus
, dw.LastDepTxnMethod
, dw.LastDepTxnMerchant
, dw.LastDepTxnReason
, dw.LastDepTxnReasonGrp
, dw.LastDepTxnRiskProfile
, dw.LastAttemptWithdrawalTime
, dw.LastAttemptWithdrawalAmount
, dw.LastWithdTxnStatus
, dw.LastWithdTxnMethod
, dw.LastWithdTxnMerchant
, dw.LastWithdTxnReason
, dw.TotalSuccDepAmt
, dw.TotalSuccDepCnt
, dw.TotalSuccWithdAmt
, dw.TotalSuccWithdCnt

, gv.SglLvFirstBetTime as GV_SglLvFirstBetTime
, gv.SglLvFirstChannel as GV_SglLvFirstChannel
, gv.SglLvFirstCashStkAmt as GV_SglLvFirstCashStkAmt
, gv.SglLvFirstBonusStkAmt as GV_SglLvFirstBonusStkAmt
, gv.SglLvFirstBonusBalStkAmt as GV_SglLvFirstBonusBalStkAmt

, gv.SglPmFirstBetTime as GV_SglPmFirstBetTime
, gv.SglPmFirstChannel as GV_SglPmFirstChannel
, gv.SglPmFirstCashStkAmt as GV_SglPmFirstCashStkAmt
, gv.SglPmFirstBonusStkAmt as GV_SglPmFirstBonusStkAmt
, gv.SglPmFirstBonusBalStkAmt as GV_SglPmFirstBonusBalStkAmt

, gv.CmbFirstBetTime as GV_CmbFirstBetTime
, gv.CmbFirstChannel as GV_CmbFirstChannel
, gv.CmbFirstCashStkAmt as GV_CmbFirstCashStkAmt
, gv.CmbFirstBonusStkAmt as GV_CmbFirstBonusStkAmt
, gv.CmbFirstBonusBalStkAmt as GV_CmbFirstBonusBalStkAmt

, gv.SglLvLastBetTime as GV_SglLvLastBetTime
, gv.SglLvLastChannel as GV_SglLvLastChannel
, gv.SglLvLastCashStkAmt as GV_SglLvLastCashStkAmt
, gv.SglLvLastBonusStkAmt as GV_SglLvLastBonusStkAmt
, gv.SglLvLastBonusBalStkAmt as GV_SglLvLastBonusBalStkAmt

, gv.SglPmLastBetTime as GV_SglPmLastBetTime
, gv.SglPmLastChannel as GV_SglPmLastChannel
, gv.SglPmLastCashStkAmt as GV_SglPmLastCashStkAmt
, gv.SglPmLastBonusStkAmt as GV_SglPmLastBonusStkAmt
, gv.SglPmLastBonusBalStkAmt as GV_SglPmLastBonusBalStkAmt

, gv.CmbLastBetTime as GV_CmbLastBetTime
, gv.CmbLastChannel as GV_CmbLastChannel
, gv.CmbLastCashStkAmt as GV_CmbLastCashStkAmt
, gv.CmbLastBonusStkAmt as GV_CmbLastBonusStkAmt
, gv.CmbLastBonusBalStkAmt as GV_CmbLastBonusBalStkAmt

, CV.SglLvFirstBetTime as CV_SglLvFirstBetTime
, CV.SglLvFirstChannel as CV_SglLvFirstChannel
, CV.SglLvFirstCashStkAmt as CV_SglLvFirstCashStkAmt
, CV.SglLvFirstBonusStkAmt as CV_SglLvFirstBonusStkAmt
, CV.SglLvFirstBonusBalStkAmt as CV_SglLvFirstBonusBalStkAmt
, CV.SglLvFirstCashReturn as CV_SglLvFirstCashReturn
, CV.SglLvFirstBonusBalReturn as CV_SglLvFirstBonusBalReturn
, CV.SglLvFirstCashOutStk as CV_SglLvFirstCashOutStk
, CV.SglLvFirstCashOutWin as CV_SglLvFirstCashOutWin

, CV.SglPmFirstBetTime as CV_SglPmFirstBetTime
, CV.SglPmFirstChannel as CV_SglPmFirstChannel
, CV.SglPmFirstCashStkAmt as CV_SglPmFirstCashStkAmt
, CV.SglPmFirstBonusStkAmt as CV_SglPmFirstBonusStkAmt
, CV.SglPmFirstBonusBalStkAmt as CV_SglPmFirstBonusBalStkAmt
, CV.SglPmFirstCashReturn as CV_SglPmFirstCashReturn
, CV.SglPmFirstBonusBalReturn as CV_SglPmFirstBonusBalReturn
, CV.SglPmFirstCashOutStk as CV_SglPmFirstCashOutStk
, CV.SglPmFirstCashOutWin as CV_SglPmFirstCashOutWin

, CV.CmbFirstBetTime as CV_CmbFirstBetTime
, CV.CmbFirstChannel as CV_CmbFirstChannel
, CV.CmbFirstCashStkAmt as CV_CmbFirstCashStkAmt
, CV.CmbFirstBonusStkAmt as CV_CmbFirstBonusStkAmt
, CV.CmbFirstBonusBalStkAmt as CV_CmbFirstBonusBalStkAmt
, CV.CmbFirstCashReturn as CV_CmbFirstCashReturn
, CV.CmbFirstBonusBalReturn as CV_CmbFirstBonusBalReturn
, CV.CmbFirstCashOutStk as CV_CmbFirstCashOutStk
, CV.CmbFirstCashOutWin as CV_CmbFirstCashOutWin

, CV.SglLvLastBetTime as CV_SglLvLastBetTime
, CV.SglLvLastChannel as CV_SglLvLastChannel
, CV.SglLvLastCashStkAmt as CV_SglLvLastCashStkAmt
, CV.SglLvLastBonusStkAmt as CV_SglLvLastBonusStkAmt
, CV.SglLvLastBonusBalStkAmt as CV_SglLvLastBonusBalStkAmt
, CV.SglLvLastCashReturn as CV_SglLvLastCashReturn
, CV.SglLvLastBonusBalReturn as CV_SglLvLastBonusBalReturn
, CV.SglLvLastCashOutStk as CV_SglLvLastCashOutStk
, CV.SglLvLastCashOutWin as CV_SglLvLastCashOutWin

, CV.SglPmLastBetTime as CV_SglPmLastBetTime
, CV.SglPmLastChannel as CV_SglPmLastChannel
, CV.SglPmLastCashStkAmt as CV_SglPmLastCashStkAmt
, CV.SglPmLastBonusStkAmt as CV_SglPmLastBonusStkAmt
, CV.SglPmLastBonusBalStkAmt as CV_SglPmLastBonusBalStkAmt
, CV.SglPmLastCashReturn as CV_SglPmLastCashReturn
, CV.SglPmLastBonusBalReturn as CV_SglPmLastBonusBalReturn
, CV.SglPmLastCashOutStk as CV_SglPmLastCashOutStk
, CV.SglPmLastCashOutWin as CV_SglPmLastCashOutWin

, CV.CmbLastBetTime as CV_CmbLastBetTime
, CV.CmbLastChannel as CV_CmbLastChannel
, CV.CmbLastCashStkAmt as CV_CmbLastCashStkAmt
, CV.CmbLastBonusStkAmt as CV_CmbLastBonusStkAmt
, CV.CmbLastBonusBalStkAmt as CV_CmbLastBonusBalStkAmt
, CV.CmbLastCashReturn as CV_CmbLastCashReturn
, CV.CmbLastBonusBalReturn as CV_CmbLastBonusBalReturn
, CV.CmbLastCashOutStk as CV_CmbLastCashOutStk
, CV.CmbLastCashOutWin as CV_CmbLastCashOutWin

, CV.TotalCashStkAmt as CV_TotalCashStkAmt
, CV.TotalBonusStkAmt as CV_TotalBonusStkAmt
, CV.TotalBonusBalStkAmt as CV_TotalBonusBalStkAmt
, CV.TotalCashReturn as CV_TotalCashReturn
, CV.TotalBonusBalReturn as CV_TotalBonusBalReturn
, CV.TotalCashRefund as CV_TotalCashRefund
, CV.TotalBonusBalRefund as CV_TotalBonusBalRefund
, CV.TotalTokenRefund as CV_TotalTokenRefund
, CV.TotalCashOutStk as CV_TotalCashOutStk
, CV.TotalCashOutWin as CV_TotalCashOutWin

, EG.FirstCashBetDate as EG_FirstCashBetDate
, EG.FirstCashBetAmt as EG_FirstCashBetAmt
, EG.FirstCashBetChannel as EG_FirstCashBetChannel
, EG.FirstBonusBetDate as EG_FirstBonusBetDate
, EG.FirstBonusBetAmt as EG_FirstBonusBetAmt
, EG.FirstBonusBetChannel as EG_FirstBonusBetChannel
, EG.LastChannel as EG_LastChannel
, EG.LastGamePlayDate as EG_LastGamePlayDate
, EG.LastPlayedCasinoType as EG_LastPlayedCasinoType
, EG.LastPlayedGameType as EG_LastPlayedGameType
, EG.LastPlayedGameName as EG_LastPlayedGameName
, EG.TotalBetAmt as EG_EG_TotalBetAmt
, EG.TotalCashBetAmount as EG_TotalCashBetAmount
, EG.TotalBonusBetAmount as EG_TotalBonusBetAmount
, EG.TotalWinAmt as EG_TotalWinAmt
, EG.TotalCashWinAmount as EG_TotalCashWinAmount
, EG.TotalBonusWinAmount as EG_TotalBonusWinAmount

, L.FirstLoginDate as FirstLoginDate
, L.LastLoginDate as LastLoginDate
, L.LastLogoutDate as LastLogoutDate
, L.FirstCashBalance as FirstCashBalance
, L.FirstBonusBalance as FirstBonusBalance
, L.CurrentCashBalance as CurrentCashBalance
, L.CurrentBonusBalance as CurrentBonusBalance

from
romaniastage.stg_dim_player as p
left outer join romaniamain.user_dep_with_first_last as dw on p.PlayerId = dw.PlayerId
left outer join romaniamain.sp_gv_player_first_last as gv on p.PlayerId = gv.PlayerId
left outer join romaniamain.sp_cv_player_first_last_totals as cv on p.PlayerId = cv.PlayerId
left outer join romaniamain.eg_player_first_last_totals as eg on p.PlayerId = eg.PlayerId
left outer join romaniamain.player_login_first_last as L on p.PlayerId = L.PlayerId
;

########################################Query 9:
drop table romaniastage.stg_sports_prod_pref;
create table romaniastage.stg_sports_prod_pref(
PlayerId integer default null,
PreferredSport varchar(500),
PreferredLeague varchar(500),
PreferredTeam varchar(500),
BetCount integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table romaniastage.stg_egaming_prod_pref;
create table romaniastage.stg_egaming_prod_pref(
PlayerId integer default null,
CategoryPref varchar(500),
MarketPref  varchar(500),
BetAmt decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerPrefSports.csv'
INTO TABLE romaniastage.stg_sports_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerPrefCasino.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

commit;

select temp.rank,temp.PlayerId, temp.CategoryPref, temp.MarketPref, temp.BetAmt from
( SELECT ( 
            CASE PlayerId 
            WHEN @curType 
            THEN @curRow := @curRow + 1 
            ELSE @curRow := 1 AND @curType := PlayerId END
          )  AS rank,
          PlayerId,
          CategoryPref,
          MarketPref,
          BetAmt
FROM      romaniastage.stg_egaming_prod_pref,
          (SELECT @curRow := 0, @curType := '') r
ORDER BY  PlayerId, BetAmt DESC
) as temp
where Rank < 5
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedCasino.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 0, playerid, 'OverAll', 'OverAll', Sum(BetAmt) from romaniastage.stg_egaming_prod_pref group by playerid
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedCasinoAll.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select temp.rank,temp.PlayerId, temp.PreferredSport, temp.PreferredLeague,temp.PreferredTeam, temp.BetCount from
( SELECT ( 
            CASE PlayerId 
            WHEN @curType 
            THEN @curRow := @curRow + 1 
            ELSE @curRow := 1 AND @curType := PlayerId END
          )  AS rank,
          PlayerId,
          PreferredSport,
          PreferredLeague,
          PreferredTeam,
          BetCount
FROM      romaniastage.stg_sports_prod_pref,
          (SELECT @curRow := 0, @curType := '') r
ORDER BY  PlayerId, BetCount DESC
) as temp
where Rank < 5
order by 2,1,6
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedSports.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 0, playerid, 'OverAll', 'OverAll', 'OverAll', Sum(BetCount) from romaniastage.stg_sports_prod_pref group by playerid
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedSportsAll.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

drop table romaniastage.stg_sports_prod_pref_tf;
create table romaniastage.stg_sports_prod_pref_tf(
Rank integer default null,
PlayerId integer default null,
PreferredSport varchar(500),
PreferredLeague varchar(500),
PreferredTeam varchar(500),
BetCount integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table romaniastage.stg_egaming_prod_pref_tf;
create table romaniastage.stg_egaming_prod_pref_tf(
Rank integer default null,
PlayerId integer default null,
CategoryPref varchar(500),
MarketPref  varchar(500),
BetAmt decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedSports.csv'
INTO TABLE romaniastage.stg_sports_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedSportsAll.csv'
INTO TABLE romaniastage.stg_sports_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedCasino.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\MysqlDump\\PlayerPrefferedCasinoAll.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
commit;

#####Output to be saved as Sports Preferences
select PlayerId,
PreferredSport1,PreferredLeague1,PreferredTeam1,BetCount1,(BetCount1/OverallBet)*100 betPer,
PreferredSport2,PreferredLeague2,PreferredTeam2,BetCount2,(BetCount2/OverallBet)*100 betPer,
PreferredSport3,PreferredLeague3,PreferredTeam3,BetCount3,(BetCount3/OverallBet)*100 betPer,
PreferredSport4,PreferredLeague4,PreferredTeam4,BetCount4,(BetCount4/OverallBet)*100 betPer,OverallBet from 
(select PlayerId,
max(case rank when 1 then PreferredSport end) as PreferredSport1,
max(case rank when 1 then PreferredLeague end) as PreferredLeague1,
max(case rank when 1 then PreferredTeam end) as PreferredTeam1,
max(case rank when 1 then BetCount end) as BetCount1,

max(case rank when 2 then PreferredSport end) as PreferredSport2,
max(case rank when 2 then PreferredLeague end) as PreferredLeague2,
max(case rank when 2 then PreferredTeam end) as PreferredTeam2,
max(case rank when 2 then BetCount end) as BetCount2,

max(case rank when 3 then PreferredSport end) as PreferredSport3,
max(case rank when 3 then PreferredLeague end) as PreferredLeague3,
max(case rank when 3 then PreferredTeam end) as PreferredTeam3,
max(case rank when 3 then BetCount end) as BetCount3,

max(case rank when 4 then PreferredSport end) as PreferredSport4,
max(case rank when 4 then PreferredLeague end) as PreferredLeague4,
max(case rank when 4 then PreferredTeam end) as PreferredTeam4,
max(case rank when 4 then BetCount end) as BetCount4,

max(case rank when 0 then BetCount end) OverallBet

from romaniastage.stg_sports_prod_pref_tf
# where playerid = 10274175
group by PlayerId) ab;

#####Output to be saved as Casino Preferences
select PlayerId,
CategoryPref1,MarketPref1,Betamt1,(Betamt1/OverallBet)*100 betPer1,
CategoryPref2,MarketPref2,Betamt2,(Betamt2/OverallBet)*100 betPer2,
CategoryPref3,MarketPref3,Betamt3,(Betamt3/OverallBet)*100 betPer3,
CategoryPref4,MarketPref4,Betamt4,(Betamt4/OverallBet)*100 betPer4,OverallBet from 
(select PlayerId,
max(case rank when 1 then CategoryPref end) as CategoryPref1,
max(case rank when 1 then MarketPref end) as MarketPref1,
max(case rank when 1 then BetAmt end) as BetAmt1,

max(case rank when 2 then CategoryPref end) as CategoryPref2,
max(case rank when 2 then MarketPref end) as MarketPref2,
max(case rank when 2 then BetAmt end) as BetAmt2,

max(case rank when 3 then CategoryPref end) as CategoryPref3,
max(case rank when 3 then MarketPref end) as MarketPref3,
max(case rank when 3 then BetAmt end) as BetAmt3,

max(case rank when 4 then CategoryPref end) as CategoryPref4,
max(case rank when 4 then MarketPref end) as MarketPref4,
max(case rank when 4 then BetAmt end) as BetAmt4,

max(case rank when 0 then BetAmt end) OverallBet

from romaniastage.stg_egaming_prod_pref_tf
# where playerid = 10274175
group by PlayerId) ab;


############channel prefferences Sports
drop table romaniastage.stg_sports_channel_pref;
create table romaniastage.stg_sports_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerChannelPrefSP.csv'
into table romaniastage.stg_sports_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

############channel prefferences Casino
drop table romaniastage.stg_eg_channel_pref;
create table romaniastage.stg_eg_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerChannelPrefEG.csv'
into table romaniastage.stg_eg_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

###################Player Volatility

Drop table romaniamain.sp_cv_player_volatility;
Create table romaniamain.sp_cv_player_volatility
(
PlayerId integer, 
SGLAvgOdds decimal(18,6), 
SGLSTDOdds decimal(18,6), 
SGLCovOdds decimal(18,6), 
CMBAvgOdds decimal(18,6), 
CMBSTDOdds decimal(18,6), 
CMBCovOdds decimal(18,6), 
SGLTotalWinninStake decimal(18,6), 
SGLTotalStake decimal(18,6), 
SGLTotalReturn decimal(18,6), 
SGLTotalWinningBetCount decimal(18,6), 
SGLTotalBetCount decimal(18,6), 
CMBTotalWinninStake decimal(18,6), 
CMBTotalStake decimal(18,6), 
CMBTotalReturn decimal(18,6), 
CMBTotalWinningBetCount decimal(18,6), 
CMBTotalBetCount decimal(18,6), 
SGLWinningRatioBetCounts decimal(18,6), 
SGLWinningRatioStake decimal(18,6), 
CMBWinningRatioBetCounts decimal(18,6), 
CMBWinningRatioStake decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\sp_cv_player_volatility.csv'
INTO TABLE romaniamain.sp_cv_player_volatility
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';