###Clean FL_Backup
#Full run

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

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\mysql_dim_player.csv'
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

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Deposits\\STG_SCIMS_Data_MySQL.csv'  
INTO TABLE STG_SCIMS_Data FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#select Reason, count(*) from STG_SCIMS_Data group by 1;

/*
#use romaniamain;
#drop table FACT_DAILY_PLAYER_TRANSACTIONS;
Create table FACT_DAILY_PLAYER_TRANSACTIONS (
  TxnTime datetime
, AcceptTime datetime
, Username varchar(200)
, PlayerId bigint
, SignupDate date
, FirstDepositDate date
, Email varchar(200)
, Name varchar(200)
, TxnID bigint(20)
, Type varchar(200)
, Method varchar(200)
, Merchant varchar(500)
, Bank varchar(200)
, Amount decimal(18,6)
, Status varchar(200)
, Result bigint(20)
, Reason varchar(1000)
, ReasonGroup varchar(500)
, CashierTxnID varchar(200)
, PTInfo varchar(500)
, ThreeDSecureProc varchar(10)
, ExtTxnAcc varchar(500)
, Casino varchar(50)
, Comments varchar(200)
, RiskProfile varchar(500)
, Agent varchar(200)
, Agency varchar(200)
, Currency varchar(10)
, PayMethRiskGrp varchar(200)
, PayMethConfCode bigint
) ENGINE=Innodb DEFAULT CHARSET=utf8;
*/

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\User_Dep_Curr_Status.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from User_Dep_Curr_Status;

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\Daily_User_First_Last.csv'
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

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\Daily_User_First_Last.csv'
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

#select SummaryDate, count(*) from Daily_User_First_Last group by 1 order by 1 desc;

#select count(*) from (

#output to be saved as DailyUserFirstLastWithSegments.csv
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


#) as temp;


#select * from User_Dep_Curr_Status;

