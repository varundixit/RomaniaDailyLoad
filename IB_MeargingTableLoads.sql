#date change 2016-01-07

#############logins##############################
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\CURL_-_Logins.csv'
INTO TABLE  testrostg.rw_logins
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginsNew.csv'
FIELDS TERMINATED BY '|' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
FROM testrostg.rw_logins
where ClientType!='CLIENTTYPE';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginsNew.csv' 
INTO TABLE  testrostg.c_logins
FIELDS TERMINATED BY '|' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
from testrostg.c_logins lo1 where date(lo1.LoginDate) != date(lo1.logoutdate) 
#and playercode=10275515
) sa 
join romania.d_date d on d.dat_Day_Date between date(sa.logindate) and date(sa.logoutdate)
where d.dat_day_date >= '2015-11-26' and d.dat_day_Date < current_date
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginSplitsAcrossDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';


select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from testrostg.c_logins lo1 where lo1.logoutdate is null and date(lo1.LoginDate) >='2015-11-26'
#and code = 25542
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginNullLogOutDates.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

select date(lo1.logindate),lo1.playercode,playertype,
lo1.logindate,
lo1.logoutdate,
lo1.startbalance,
lo1.startbonusbalance,
coalesce(lo1.endbalance,lo1.startbalance) endbalance,
coalesce(lo1.endbonusbalance,lo1.startbonusbalance) endbonusbalance,
ClientType,Code,FunPlayerCode,HwSerial,IP,KioskCode,Serial,
ServerCode,SessionID,Version,ClientPlatform,LoginDeviceTypeCode,LoginVenueCode
from testrostg.c_logins lo1 where date(lo1.LoginDate) = date(lo1.logoutdate) 
and date(lo1.LoginDate) >='2015-11-26'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\RegularLogins.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginSplitsAcrossDates.csv' 
INTO TABLE testrostg.stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\LoginNullLogOutDates.csv' 
INTO TABLE testrostg.stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\RegularLogins.csv' 
INTO TABLE testrostg.stg_daily_player_logins
FIELDS TERMINATED BY ';' 
ENCLOSED BY 'NULL'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_stg_daily_player_logins.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_daily_player_logins;



############customer########################
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Customer.csv'
into table STG_GIT_CSV_CUSTOMER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

select
PlayerSPId,
Username,
FirstName,
LastName,
PlayerSPSegName,
AllowBonus,
PlayerCurrency,
PlayerSPRating,
PlayerSPRatingLive,
PlayerSPStakeLimit,
PlayerSPStakeLimitLive,
Operator,
Advertiser,
CasinoName,
TestYN,
STR_TO_DATE(CreationDate,'%Y-%m-%d %H:%i'),
1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_GIT_CSV_CUSTOMER_OUT.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_GIT_CSV_CUSTOMER;


Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_GIT_CSV_CUSTOMER_OUT.csv'
into table STG_GIT_CUSTOMER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';


Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Curl_Player.csv'
into table STG_IMS_CSV_PLAYER
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';

select
  AccumulatedBetRefund
, ActivationCode
, ActivationCodeRetryCount
, ActivationCodeVerified
, ActiveBonusCode
, ActivePendingBonusCode
, Address
, AddressTranslate
, AddressUpper
, Advertiser
, AdvertiserCode
, AgeVerification
, STR_TO_DATE(AgeVerificationDate, '%Y-%m-%d %H:%i:%s')
, AllBetsIncluded
, Balance
, BalanceVersion
, BannerID
, BellaConnectAccount
, BetFairCompPoints
, BillingSettingGroupCode
, BingoCustom1
, BingoCustom2
, BirthCity
, BirthCountryCode
, STR_TO_DATE(BirthDate,'%Y-%m-%d')
, BirthDepartment
, BirthProvince
, BirthProvinceCode
, STR_TO_DATE(BlacklistCheckDate, '%Y-%m-%d %H:%i:%s')
, Blacklisted
, BonusBalance
, BonusBalanceVersion
, BonusExcludedGameWin
, STR_TO_DATE(BonusExcludedGameWinResetDate, '%Y-%m-%d %H:%i:%s')
, BonusGroup
, BonusSeeker
, CasinoCode
, Cellphone
, ChangePokerPlayerCode
, Citizenship
, City
, Code
, Comments
, CompPoints
, CountryCode
, CouponName
, CurrencyCode
, CurrencyConversionRemainder
, CurrentBet
, CurrentBonusBet
, Custom01
, Custom02
, Custom03
, Custom04
, Custom05
, Custom06
, Custom08
, CustomClient01
, CustomClient02
, DepositGroupCode
, DepositLimitAmount
, STR_TO_DATE(DepositLimitSetDate, '%Y-%m-%d %H:%i:%s')
, DepositLimitTimePeriod
, DepositRestrictions
, DisableAllDeposits
, DisableGaming
, DisableHeldFunds
, DonotCall
, DonotProcessWithdrawals
, DriverLicenseNo
, DupSearchExclude
, Email
, EmailVerified
, EncryptionKeyVersion
, ExternalCreateType
, ExternalID
, FAX
, FirstDepositClientParameter
, STR_TO_DATE(FirstLoginDate, '%Y-%m-%d %H:%i:%s')
, FirstName
, FirstNameSoundEx
, FraudAdminCode
, STR_TO_DATE(FraudCheckDate, '%Y-%m-%d %H:%i:%s')
, FreezeChat
, Frozen
, Gender
, STR_TO_DATE(GlobalFirstDepositDate, '%Y-%m-%d %H:%i:%s')
, GroupParentCode
, HaveIDCopyFAX
, HeardFrom
, Iban
, IDCardNo
, IncludeFirstDeposit
, IncludeSignup
, InternalAccount
, KioskAdminCode
, KioskCode
, LastName
, LastNameSoundEx
, LastNameUpper
, LoginCount
, LogMessages
, MaxBalance
, MaxTotalBalance
, MobileGameRequestEmail
, MoneyReceiving
, MoneySending
, MoneyToRisk
, NoBonus
, Occupation
, OrigAdvertiserCode
, OrigBannerID
, OrigProfileID
, OrigRefererURL
, PassportID
, PendingBonusBalance
, PersonalID
, Phone
, PhoneTranslate
, PhoneUpper
, STR_TO_DATE(PlayerRiskProfileChangeDate, '%Y-%m-%d %H:%i:%s')
, PlayerRiskProfileCode
, PlayersTS
, PlayerType
, PokerBlocked
, PokerCustom1
, PokerCustom2
, PokerFrozen
, PokerNickname
, PokerVIPLevel
, PostOfficeBOX
, ProfileID
, Province
, ProvinceCode
, RefererURL
, RegionCode
, STR_TO_DATE(RegistrationCheckDate, '%Y-%m-%d %H:%i:%s')
, RegulatorApproval
, RemainingBonuses
, RemindAfterTimePeriod
, RemindOnFirstBet
, STR_TO_DATE(RemoteChangeTimestamp, '%Y-%b-%d %h.%i.%s.%f %p')
, RemoteSync
, ReservedBalance
, Serial
, SignupClientType
, SignupAdvertiserCode
, SignupChannelCode
, SignupClientParameterCode
, SignupClientSkinCode
, STR_TO_DATE(SignupDate, '%Y-%m-%d %H:%i:%s')
, SignupRemoteIP
, SignupVersion
, State
, SyncBetFairCompPoints
, TempApproveDeposit
, Title
, TotalCompPoints
, TrackingID1
, TrackingID2
, TrackingID3
, TrackingID4
, TrackingID5
, TrackingID6
, TrackingID7
, TrackingID8
, STR_TO_DATE(UnsubscribeDate, '%Y-%m-%d %H:%i:%s')
, Username
, VideoBet
, VIPLevel
, STR_TO_DATE(VIPLevelUPDate, '%Y-%m-%d %H:%i:%s')
, Wagering
, WageringRealLoss
, WithdrawVerifyCode
, WorkPhone
, ZIP
, 1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_IMS_CSV_PLAYER_OUT.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_IMS_CSV_PLAYER;


Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_IMS_CSV_PLAYER_OUT.csv'
into table STG_IMS_PLAYER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';


use romaniastg;
select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_PLAYER.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
(SELECT 
IMS.*,
GIT.PlayerSPId,
GIT.PlayerSPSegName,
GIT.AllowBonus,
GIT.PlayerCurrency ,
GIT.PlayerSPRating,
GIT.PlayerSPRatingLive,
GIT.PlayerSPStakeLimit,
GIT.PlayerSPStakeLimitLive,
GIT.OperatorSP,
GIT.AdvertiserSP,
GIT.CasinoNameSP,
GIT.TestYNSP,
GIT.CreationDateSP
FROM testrostg.STG_IMS_PLAYER as IMS
LEFT outer JOIN STG_GIT_CUSTOMER as GIT ON ims.Username = git.Username
UNION
SELECT 
IMS.*,
GIT.PlayerSPId,
GIT.PlayerSPSegName,
GIT.AllowBonus,
GIT.PlayerCurrency ,
GIT.PlayerSPRating,
GIT.PlayerSPRatingLive,
GIT.PlayerSPStakeLimit,
GIT.PlayerSPStakeLimitLive,
GIT.OperatorSP,
GIT.AdvertiserSP,
GIT.CasinoNameSP,
GIT.TestYNSP,
GIT.CreationDateSP
FROM testrostg.STG_IMS_PLAYER as IMS
RIGHT outer JOIN STG_GIT_CUSTOMER as GIT ON ims.Username = git.Username
) as temp;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_PLAYER.csv'
into table testromain.DIM_PLAYER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

select * from testromain.DIM_PLAYER where PlayerID is null;

###########exchange rates
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\STG_Exchange_Rate.csv'
into table STG_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';


select
date(EffectiveTimestamp),
EffectiveTimestamp,
LastUpdTimestamp,
CurrencyCode,
XchangeRate
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\DD_Exchange_Rate.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_Exchange_Rate;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\DD_Exchange_Rate.csv'
into table testromain.DD_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';

##############IB_Balance_Load
select
  Code as Playerid
, STR_TO_DATE('2016-01-07', '%Y-%m-%d %H:%i:%s') AS SummaryDate
, AdvertiserCode
, STR_TO_DATE(GlobalFirstDepositDate, '%Y-%m-%d %H:%i:%s') as FirstDepositDate
, Balance as Balance
, BonusBalance as BonusBalance
, STR_TO_DATE(SignupDate, '%Y-%m-%d %H:%i:%s') as SignUpDate
, 1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_DAILY_PLAYER_BALANCE.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_IMS_CSV_PLAYER;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_DAILY_PLAYER_BALANCE.csv'
into table testromain.FD_DAILY_PLAYER_BALANCE
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

select 
SummaryDate, 
SUM(Balance) as TotalBalance, 
SUM(BonusBalance) as TotalBonusBalance,  
count(distinct PlayerId) 
from testromain.FD_DAILY_PLAYER_BALANCE
where SignupDate >= '2015-11-26'
group by SummaryDate;


#############IB_PAYMENT_LOAD
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\usertransactions.csv'  
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_SCIMS_Data.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.CSV_TO_STG as stg join testromain.dim_player as p on stg.Username = p.Username;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_SCIMS_Data.csv'  
INTO TABLE STG_SCIMS_Data FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select *
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\STG_SCIMS_Data_MySQL.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_SCIMS_Data;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\CURL_Player_Payments.csv'  
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_player_payments.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_csv_player_payments as spp 
join testromain.dim_client_parameter as cp on spp.ClientparameterCode = cp.ClientParameterCode;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_player_payments.csv'  
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

INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_daily_cashier_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'

from testrostg.stg_player_payments
where TxnDate = '2016-01-07'
group by PlayerCode,TxnDate;

select count(distinct PlayerCode) from testrostg.stg_player_payments;

#######################################curl games

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Curl_Games.csv' 
INTO TABLE STG_GAMES_CSV
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_Games_MySQL.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_GAMES_CSV;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_Games_MySQL.csv' 
INTO TABLE testrostg.STG_GAMES
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_Games as stg
join testromain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join testromain.dim_game_list as dgt on stg.Type = dgt.Type
join testromain.dim_player as p on stg.PlayerId = p.PlayerID
#join testromain.dd_exchange_rate as ex on p.CurrencyCode = ex.CurrencyCode
where date(stg.GameDate) <= '2016-01-07';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE testromain.FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.STG_Games as stg
join testromain.DIM_CLIENT_PARAMETER as cp on stg.ClientParameterCode = cp.ClientParameterCode
join testromain.dim_game_list as dgt on stg.Type = dgt.Type
join testromain.dim_player as p on stg.PlayerId = p.PlayerID
where date(stg.GameDate) <= '2016-01-07';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE testromain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_eg_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
where SummaryDate = '2016-01-07'
group by
PlayerId,
SummaryDate,
CurrencyCode;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_eg_daily_player_summary.csv' 
INTO TABLE testromain.sd_eg_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_csc_eg_player_product_info_summ.csv' 
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
from  testromain.fd_csc_eg_player_product_info_summ 
where SummaryDate = '2016-01-07';

#############Placed Bets

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Placed_Bets.csv' 
INTO TABLE  testrostg.stg_placed_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select
 BetslipId
,BetslipStatus
,BetId
,BetType
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,ReferredYN
,CancelReason
,NumLegs
,NumPart
,LegSort
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,STR_TO_DATE(EventStartTime, '%Y-%m-%d %H:%i:%s')
,MeetingName
,RaceType
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
,BonusId
,CampaignId
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,Odds
,EitherwaySort
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_placed_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_placed_bets_csv;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_placed_bets.csv' 
INTO TABLE  stg_placed_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select
 BetslipId
,BetslipStatus
,BetId
,BetType
,BetTime
,BetDate
,BetStatus
,ReferredYN
,CancelReason
,NumLegs
,NumPart
,LegSort
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,EventStartTime
,MeetingName
,RaceType
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,p.PlayerId
,p.UserName
,p.CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,(StakeAmt - BonusStakeAmt - BonusBalanceStake) as CashStakeAmt
,(StakeAmtBC - BonusStakeAmtBC - BonusBalanceStakeBC) as CashStakeAmtBC
,BonusId
,CampaignId
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,Odds
,EitherwaySort
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_placed_bets1.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_placed_bets as stg 
join testromain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_placed_bets1.csv' 
INTO TABLE  testromain.fd_placed_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

###################################Settled Bets###############################
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Settled_Bets.csv' 
INTO TABLE  stg_settled_bets_csv
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_settled_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_settled_bets_csv;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_settled_bets.csv' 
INTO TABLE  stg_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_settled_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_settled_bets as sb
join testromain.fd_placed_bets as pb 
on sb.BetId = pb.BetId and sb.SelectionId = pb.SelectionId and sb.MarketId = pb.MarketId;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_settled_bets.csv' 
INTO TABLE  testromain.fd_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

##########################Rejected Bets
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Rejected_Bets.csv' 
INTO TABLE  testrostg.stg_rejected_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_rejected_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_rejected_bets_csv;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_rejected_bets.csv' 
INTO TABLE  testrostg.stg_rejected_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_rejected_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_rejected_bets as stg 
join testromain.DIM_PLAYER as p on stg.UserName = p.UserName;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_rejected_bets.csv' 
INTO TABLE  testromain.fd_rejected_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


#######################Voided Bets
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\Voided_Bets.csv' 
INTO TABLE  stg_voided_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_voided_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_voided_bets_csv;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\stg_voided_bets.csv' 
INTO TABLE  stg_voided_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select * 
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_voided_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_voided_bets;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_voided_bets.csv' 
INTO TABLE  testromain.fd_voided_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

##########################OpenBets
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Data\\Open_Bets.csv' 
INTO TABLE testrostg.stg_open_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_OPEN_BETS.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_open_bets_csv;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\STG_OPEN_BETS.csv' 
INTO TABLE testrostg.stg_open_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_open_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testrostg.stg_open_bets as stg 
join testromain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId
where BetDate <= '2016-01-07';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_open_bets.csv' 
INTO TABLE  testromain.fd_open_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


#######################IB_TEMP_DPS

select 
PlayerId as PlayerId,
UserName as UserName,
BetDate as SummaryDate,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionId as SelectionId,
SelectionName as SelectionName,
MarketId as MarketId,
MarketName as MarketName,
EventId as EventId,
EventName as EventName,
TypeId as TypeId,
TypeName as TypeName,
ClassId as ClassId,
ClassName as ClassName,
SportName as Sport,
SUM(StakeAmt) as StakeAmt,
SUM(StakeAmtBC) as StakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_gv_placed_bets_simple_single.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_placed_bets
where BetType = 'SGL' and BetDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;

select 
PlayerId as PlayerId,
UserName as UserName,
BetDate as SummaryDate,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
0 as SelectionId,
'Combi' as SelectionName,
0 as MarketId,
'Combi' as MarketName,
0 as EventId,
'Combi' as EventName,
0 as TypeId,
'Combi' as TypeName,
0 as ClassId,
'Combi' as ClassName,
'Combi' as Sport,
AVG(StakeAmt) as StakeAmt,
AVG(StakeAmtBC) as StakeAmtBC,
AVG(CashStakeAmt) as CashStakeAmt,
AVG(CashStakeAmtBC) as CashStakeAmtBC,
AVG(BonusStakeAmt) as BonusStakeAmt,
AVG(BonusStakeAmtBC) as BonusStakeAmtBC,
AVG(BonusBalanceStake) as BonusBalanceStake,
AVG(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_placed_bets
where BetType <> 'SGL' and BetDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_gv_placed_bets_simple_single.csv'
INTO TABLE testromain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_gv_placed_bets_simple_combi.csv'
INTO TABLE testromain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
PlayerId as PlayerId,
UserName as UserName,
SettledDate as SummaryDate,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionId as SelectionId,
SelectionName as SelectionName,
MarketId as MarketId,
MarketName as MarketName,
EventId as EventId,
EventName as EventName,
TypeId as TypeId,
TypeName as TypeName,
ClassId as ClassId,
ClassName as ClassName,
SportName as Sport,
SUM(TotalStakeAmt) as TotalStakeAmt,
SUM(TotalStakeAmtBC) as TotalStakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC,
SUM(TotalReturn) as TotalReturn,
SUM(TotalReturnBC) as TotalReturnBC,
SUM(CashReturn) as CashReturn,
SUM(CashReturnBC) as CashReturnBC,
SUM(BonusBalanceReturn) as BonusBalanceReturn,
SUM(BonusBalancereturnBC) as BonusBalancereturnBC,
SUM(TotalRefund) as TotalRefund,
SUM(TotalRefundBC) as TotalRefundBC,
SUM(CashRefund) as CashRefund,
SUM(CashRefundBC) as CashRefundBC,
SUM(BonusBalanceRefund) as BonusBalanceRefund,
SUM(BonusBalanceRefundBC) as BonusBalanceRefundBC,
SUM(TokenRefund) as TokenRefund,
SUM(TokenRefundBC) as TokenRefundBC,
SUM(CashOutStake) as CashOutStake,
SUM(CashOutStakeBC) as CashOutStakeBC,
SUM(CashOutWin) as CashOutWin,
SUM(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_cv_settled_bets_simple_single.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_settled_bets
where BetType = 'SGL' and SettledDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;

select 
PlayerId as PlayerId,
UserName as UserName,
SettledDate as SummaryDate,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
0 as SelectionId,
'Combi' as SelectionName,
0 as MarketId,
'Combi' as MarketName,
0 as EventId,
'Combi' as EventName,
0 as TypeId,
'Combi' as TypeName,
0 as ClassId,
'Combi' as ClassName,
'Combi' as Sport,
AVG(TotalStakeAmt) as TotalStakeAmt,
AVG(TotalStakeAmtBC) as TotalStakeAmtBC,
AVG(CashStakeAmt) as CashStakeAmt,
AVG(CashStakeAmtBC) as CashStakeAmtBC,
AVG(BonusStakeAmt) as BonusStakeAmt,
AVG(BonusStakeAmtBC) as BonusStakeAmtBC,
AVG(BonusBalanceStake) as BonusBalanceStake,
AVG(BonusBalanceStakeBC) as BonusBalanceStakeBC,
AVG(TotalReturn) as TotalReturn,
AVG(TotalReturnBC) as TotalReturnBC,
AVG(CashReturn) as CashReturn,
AVG(CashReturnBC) as CashReturnBC,
AVG(BonusBalanceReturn) as BonusBalanceReturn,
AVG(BonusBalancereturnBC) as BonusBalanceReturnBC,
AVG(TotalRefund) as TotalRefund,
AVG(TotalRefundBC) as TotalRefundBC,
AVG(CashRefund) as CashRefund,
AVG(CashRefundBC) as CashRefundBC,
AVG(BonusBalanceRefund) as BonusBalanceRefund,
AVG(BonusBalanceRefundBC) as BonusBalanceRefundBC,
AVG(TokenRefund) as TokenRefund,
AVG(TokenRefundBC) as TokenRefundBC,
AVG(CashOutStake) as CashOutStake,
AVG(CashOutStakeBC) as CashOutStakeBC,
AVG(CashOutWin) as CashOutWin,
AVG(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_cv_settled_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_settled_bets
where BetType <> 'SGL' and SettledDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_cv_settled_bets_simple_single.csv'
INTO TABLE testromain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_cv_settled_bets_simple_combi.csv'
INTO TABLE testromain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
PlayerId,
Username,
SummaryDate,
SUM(TotalStakeAmt) as TotalStakeAmt,
SUM(TotalStakeAmtBC) as TotalStakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC,
SUM(TotalReturn) as TotalReturn,
SUM(TotalReturnBC) as TotalReturnBC,
SUM(CashReturn) as CashReturn,
SUM(CashReturnBC) as CashReturnBC,
SUM(BonusBalanceReturn) as BonusBalanceReturn,
SUM(BonusBalancereturnBC) as BonusBalancereturnBC,
SUM(TotalRefund) as TotalRefund,
SUM(TotalRefundBC) as TotalRefundBC,
SUM(CashRefund) as CashRefund,
SUM(CashRefundBC) as CashRefundBC,
SUM(BonusBalanceRefund) as BonusBalanceRefund,
SUM(BonusBalanceRefundBC) as BonusBalanceRefundBC,
SUM(TokenRefund) as TokenRefund,
SUM(TokenRefundBC) as TokenRefundBC,
SUM(CashOutStake) as CashOutStake,
SUM(CashOutStakeBC) as CashOutStakeBC,
SUM(CashOutWin) as CashOutWin,
SUM(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_cv_settled_bets_simple
where SummaryDate = '2016-01-07'
group by PlayerId,Username,SummaryDate;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_sp_daily_player_summary.csv'
INTO TABLE testromain.sd_cv_sp_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
(select
 spdps.PlayerId
,spdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(spdps.TotalReturn,0)
,coalesce(spdps.TotalReturnBC,0)
,coalesce(spdps.CashReturn,0)
,coalesce(spdps.CashReturnBC,0)
,coalesce(spdps.BonusBalanceReturn,0)
,coalesce(spdps.BonusBalancereturnBC,0)
,coalesce(spdps.TotalRefund,0)
,coalesce(spdps.TotalRefundBC,0)
,coalesce(spdps.CashRefund,0)
,coalesce(spdps.CashRefundBC,0)
,coalesce(spdps.BonusBalanceRefund,0)
,coalesce(spdps.BonusBalanceRefundBC,0)
,coalesce(spdps.TokenRefund,0)
,coalesce(spdps.TokenRefundBC,0)
,coalesce(spdps.CashOutStake,0)
,coalesce(spdps.CashOutStakeBC,0)
,coalesce(spdps.CashOutWin,0)
,coalesce(spdps.CashOutWinBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from testromain.sd_cv_sp_daily_player_summary as spdps
left outer join testromain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where spdps.SummaryDate = '2016-01-07' 
UNION
select
 egdps.PlayerId
,egdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(spdps.TotalReturn,0)
,coalesce(spdps.TotalReturnBC,0)
,coalesce(spdps.CashReturn,0)
,coalesce(spdps.CashReturnBC,0)
,coalesce(spdps.BonusBalanceReturn,0)
,coalesce(spdps.BonusBalancereturnBC,0)
,coalesce(spdps.TotalRefund,0)
,coalesce(spdps.TotalRefundBC,0)
,coalesce(spdps.CashRefund,0)
,coalesce(spdps.CashRefundBC,0)
,coalesce(spdps.BonusBalanceRefund,0)
,coalesce(spdps.BonusBalanceRefundBC,0)
,coalesce(spdps.TokenRefund,0)
,coalesce(spdps.TokenRefundBC,0)
,coalesce(spdps.CashOutStake,0)
,coalesce(spdps.CashOutStakeBC,0)
,coalesce(spdps.CashOutWin,0)
,coalesce(spdps.CashOutWinBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from testromain.sd_cv_sp_daily_player_summary as spdps
right outer join testromain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where egdps.SummaryDate = '2016-01-07' 
) as temp;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_cv_daily_player_summary.csv'
INTO TABLE testromain.sd_cv_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
PlayerId,
Username,
SummaryDate,
SUM(StakeAmt) as StakeAmt,
SUM(StakeAmtBC) as StakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_gv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_gv_placed_bets_simple
where SummaryDate = '2016-01-07'
group by PlayerId,Username,SummaryDate;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_gv_sp_daily_player_summary.csv'
INTO TABLE testromain.sd_gv_sp_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_gv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
(select
 spdps.PlayerId
,spdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from testromain.sd_gv_sp_daily_player_summary as spdps
left outer join testromain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where spdps.SummaryDate = '2016-01-07'
UNION
select
 egdps.PlayerId
,egdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from testromain.sd_gv_sp_daily_player_summary as spdps
right outer join testromain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where egdps.SummaryDate = '2016-01-07'
) as temp;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\sd_gv_daily_player_summary.csv'
INTO TABLE testromain.sd_gv_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#############################Daily Summary
##Output to be saved as DayLevelSummary.csv
##################################################### REPORT DATA ######################################################

select 
  cal.calendar_date as SummaryDate
, FTD.FirstTimeDepositors as FirstTimeDepositors
, SignUp.UniqueSignUps as UniqueSignUps
, Cashier.TotalDepAttemptAmt
, Cashier.TotalDepAttemptCnt
, Cashier.TotalDepDeclineAmt
, Cashier.TotalDepDeclineCnt
, Cashier.TotalDepApproveAmt
, Cashier.TotalDepApproveCnt
, Cashier.TotalUniqueAttemptDepositors
, Cashier.TotalUniqueDeclinedDepositors
, Cashier.TotalUniqueApprovedDepositors
, Cashier.TotalWithdAttemptAmt
, Cashier.TotalWithdAttemptCnt
, Cashier.TotalWithdDeclineAmt
, Cashier.TotalWithdDeclineCnt
, Cashier.TotalWithdApproveAmt
, Cashier.TotalWithdApproveCnt
, Cashier.TotalUniqueAttempWithdrawers
, Cashier.TotalUniqueDeclinedWithdrawers
, Cashier.TotalUniqueApprovedWithdrawers
, CashView.TotalStakeAmt
, CashView.TotalCashStakeAmt
, CashView.TotalBonusStakeAmt
, CashView.TotalReturnAmt
, CashView.TotalCashReturnAmt
, ((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt))) as GrossWinAmt
, (((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)))*0.84) as NetGrossWinAmt
, (CashView.TotalBonusStakeAmt - (CashView.TotalReturnAmt - CashView.TotalCashReturnAmt)) as TotalBonusCost
, ((((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)))*0.84) - (CashView.TotalBonusStakeAmt - (CashView.TotalReturnAmt - CashView.TotalCashReturnAmt))) as NetGamingRevenue
, CashView.SPTotalStakeAmt
, CashView.SPCashStakeAmt
, CashView.SPBonusStakeAmt
, CashView.SPBonusBalanceStake
, CashView.SPTotalReturnAmt
, CashView.SPCashReturnAmt
, CashView.SPBonusBalanceReturnAmt
, CashView.SPTotalRefundAmt
, CashView.SPCashRefundAmt
, CashView.SPBonusBalanceRefundAmt
, CashView.SPTokenRefundAmt
, CashView.SPCashOutStakeAmt
, CashView.SPCashOutWinAmt
, (CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) as SPGrossWinAmt
, ((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt)*0.84) as SPNetGrossWinAmt
, (CashView.SPBonusStakeAmt - (CashView.SPTotalReturnAmt - CashView.SPCashReturnAmt)) as SPBonusCost
, (((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt)*0.84) - (CashView.SPBonusStakeAmt - (CashView.SPTotalReturnAmt - CashView.SPCashReturnAmt))) as SPNetGamingRevenue
, CashView.EGTotalStakeAmt 
, CashView.EGCashStakeAmt
, CashView.EGBonusStakeAmt
, CashView.EGTotalReturnAmt
, CashView.EGCashReturnAmt
, CashView.EGBonusReturnAmt
, CashView.EGBonusFreeGamesCount
, CashView.EGFreeGamesCount
, CashView.EGJackpotStakeAmt
, CashView.EGJackpotReturnAmt
, (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)) as EGGrossWinAmt
, ((CashView.EGTotalStakeAmt - CashView.EGTotalReturnAmt)*0.84) as EGNetGrossWinAmt
, (CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt) as EGamingBonusCost
, (((CashView.EGTotalStakeAmt - CashView.EGTotalReturnAmt)*0.84) - (CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt)) as EGNetGamingRevenue
, GameView.SystemAPD
, GameView.SportsAPD
, GameView.EGamingAPD
, Cumulative.CumulativeSystemUAP
, Cumulative.CumulativeSportsUAP
, Cumulative.CumulativeEGamingUAP
, Balance.TotalBalance
, Balance.TotalBonusBalance
from testromain.dim_calendar as cal
left outer join 
(select 
cal.calendar_date as SummaryDate,
count(distinct PlayerId) as FirstTimeDepositors
from testromain.dim_calendar as cal
left outer join testromain.dim_player as p on cal.calendar_date = date(p.GlobalFirstDepositDate)
where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-01-07'
group by 1
) as FTD on cal.calendar_date = FTD.SummaryDate
left outer join 
(select 
cal.calendar_date as SummaryDate,
count(distinct PlayerId) as UniqueSignUps
from testromain.dim_calendar as cal
left outer join testromain.dim_player as p on cal.calendar_date = date(p.SignupDate)
where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-01-07'
group by 1
) as SignUp on cal.calendar_date = SignUp.SummaryDate
left outer join 
(select
dcs.SummaryDate,
SUM(dcs.TotalDepAttemptAmt) as TotalDepAttemptAmt,
SUM(dcs.TotalDepAttemptCnt) as TotalDepAttemptCnt,
SUM(dcs.TotalDepDeclineAmt) as TotalDepDeclineAmt,
SUM(dcs.TotalDepDeclineCnt) as TotalDepDeclineCnt,
SUM(dcs.TotalDepApproveAmt) as TotalDepApproveAmt,
SUM(dcs.TotalDepApproveCnt) as TotalDepApproveCnt,
COUNT(distinct case when dcs.TotalDepAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttemptDepositors,
COUNT(distinct case when dcs.TotalDepDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedDepositors,
COUNT(distinct case when dcs.TotalDepApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedDepositors,
SUM(dcs.TotalWithdAttemptAmt) as TotalWithdAttemptAmt,
SUM(dcs.TotalWithdAttemptCnt) as TotalWithdAttemptCnt,
SUM(dcs.TotalWithdDeclineAmt) as TotalWithdDeclineAmt,
SUM(dcs.TotalWithdDeclineCnt) as TotalWithdDeclineCnt,
SUM(dcs.TotalWithdApproveAmt) as TotalWithdApproveAmt,
SUM(dcs.TotalWithdApproveCnt) as TotalWithdApproveCnt,
COUNT(distinct case when dcs.TotalWithdAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttempWithdrawers,
COUNT(distinct case when dcs.TotalWithdDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedWithdrawers,
COUNT(distinct case when dcs.TotalWithdApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedWithdrawers
from testromain.sd_daily_cashier_summary AS dcs
join testromain.dim_player as p ON dcs.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by
SummaryDate) as Cashier on cal.calendar_date = Cashier.SummaryDate
left outer join 
(
SELECT 
 dps.SummaryDate
,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as SystemAPD
,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as EGamingAPD
FROM testromain.sd_gv_daily_player_summary as dps
join testromain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by SummaryDate
) as GameView  on cal.calendar_date = GameView.SummaryDate
left outer join
(SELECT 
 dps.SummaryDate
,SUM(dps.SPTotalStakeAmt+dps.EGBet) as TotalStakeAmt
,SUM(dps.SPCashStakeAmt+dps.EGCashBet) as TotalCashStakeAmt
,SUM(dps.SPBonusStakeAmt+dps.EGBonusBet) as TotalBonusStakeAmt
,SUM(dps.SPTotalReturn+dps.EGWin) as TotalReturnAmt
,SUM(dps.SPCashReturn+dps.EGCashWin) as TotalCashReturnAmt
,SUM(dps.SPTotalStakeAmt) as SPTotalStakeAmt
,SUM(dps.SPCashStakeAmt) as SPCashStakeAmt
,SUM(dps.SPBonusStakeAmt) as SPBonusStakeAmt
,SUM(dps.SPBonusBalanceStake) as SPBonusBalanceStake
,SUM(dps.SPTotalReturn) as SPTotalReturnAmt
,SUM(dps.SPCashReturn) as SPCashReturnAmt
,SUM(dps.SPBonusBalanceReturn) as SPBonusBalanceReturnAmt
,SUM(dps.SPTotalRefund) as SPTotalRefundAmt
,SUM(dps.SPCashRefund) as SPCashRefundAmt
,SUM(dps.SPBonusBalanceRefund) as SPBonusBalanceRefundAmt
,SUM(dps.SPTokenRefund) as SPTokenRefundAmt
,SUM(dps.SPCashOutStake) as SPCashOutStakeAmt
,SUM(dps.SPCashOutWin) as SPCashOutWinAmt
,SUM(dps.EGBet) as EGTotalStakeAmt
,SUM(dps.EGCashBet) as EGCashStakeAmt
,SUM(dps.EGBonusBet) as EGBonusStakeAmt
,SUM(dps.EGWin) as EGTotalReturnAmt
,SUM(dps.EGCashWin) as EGCashReturnAmt
,SUM(dps.EGBonusWin) as EGBonusReturnAmt
,SUM(dps.EGBonusFreeGamesCount) as EGBonusFreeGamesCount
,SUM(dps.EGFreeGamesCount) as EGFreeGamesCount
,SUM(dps.EGJackpotBet) as EGJackpotStakeAmt
,SUM(dps.EGJackpotWin) as EGJackpotReturnAmt
FROM testromain.sd_cv_daily_player_summary as dps
join testromain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by SummaryDate
) as CashView  on cal.calendar_date = CashView.SummaryDate
left outer join
(
SELECT 
 cal.calendar_date as SummaryDate
,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as CumulativeSystemUAP
,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as CumulativeSportsUAP
,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as CumulativeEGamingUAP
FROM testromain.dim_calendar as cal
left outer join testromain.sd_gv_daily_player_summary as dps on dps.SummaryDate <= cal.calendar_date and cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-01-07' and dps.SummaryDate >= '2015-11-26'
left outer join testromain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by cal.calendar_date
) as Cumulative on cal.calendar_date = Cumulative.SummaryDate
left outer join
(
select 
SummaryDate, 
SUM(Balance) as TotalBalance, 
SUM(BonusBalance) as TotalBonusBalance,  
count(distinct PlayerId) 
from testromain.FD_DAILY_PLAYER_BALANCE
where SignupDate >= '2015-11-26'
group by SummaryDate
) as Balance on cal.calendar_date = Balance.SummaryDate
where 
cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-01-07';

############################IB_Load_MySQL_Sports_Daily_GV_FL

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(StakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_placed_bets
where BetType <> 'SGL' and BetDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(StakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\mysql_fd_gv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_placed_bets
where BetType = 'SGL' and BetDate = '2016-01-07';

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(TotalStakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake,
coalesce(AVG(TotalReturn),0) as TotalReturn,
coalesce(AVG(CashReturn),0) as CashReturn,
coalesce(AVG(BonusBalanceReturn),0) as BonusBalanceReturn,
coalesce(AVG(CashRefund),0) as CashRefund,
coalesce(AVG(BonusBalanceRefund),0) as BonusBalanceRefund,
coalesce(AVG(TokenRefund),0) as TokenRefund,
coalesce(AVG(CashOutStake),0) as CashOutStake,
coalesce(AVG(CashOutWin),0) as CashOutWin
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_fd_cv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_settled_bets
where BetType <> 'SGL' and SettledDate = '2016-01-07'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(TotalStakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake,
coalesce(TotalReturn,0) as TotalReturn,
coalesce(CashReturn,0) as CashReturn,
coalesce(BonusBalanceReturn,0) as BonusBalanceReturn,
coalesce(CashRefund,0) as CashRefund,
coalesce(BonusBalanceRefund,0) as BonusBalanceRefund,
coalesce(TokenRefund,0) as TokenRefund,
coalesce(CashOutStake,0) as CashOutStake,
coalesce(CashOutWin,0) as CashOutWin
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_fd_cv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from testromain.fd_settled_bets
where BetType = 'SGL' and SettledDate = '2016-01-07'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16;


select 
PlayerID,
trim(Username),
trim(Gender),
coalesce(Balance,0),
case when GlobalFirstDepositDate is null then '3000-01-01 00:00:00' else GlobalFirstDepositDate end,
case when SignupDate is null then '3000-01-01 00:00:00' else SignupDate end,
1
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\mysql_dim_player.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
from testromain.dim_player
where PlayerID is not null;


SELECT 
 dps.PlayerID
,coalesce(COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.SummaryDate end),0) as SystemAPD
,coalesce(COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.SummaryDate end),0) as SportsAPD
,coalesce(COUNT(distinct case when (dps.EGBet) > 0 then dps.SummaryDate end),0) as EGamingAPD
FROM testromain.sd_gv_daily_player_summary as dps
join testromain.dim_player as p on dps.PlayerId = p.PlayerId
where dps.SummaryDate = '2016-01-07'
group by dps.PlayerID
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerAPD_Daily.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
p.PlayerId,
coalesce(sports.SportsBetCount,0),
coalesce(eg.EgBetCount,0)
from testromain.dim_player as p
left outer join (select PlayerId, count(BetSlipId) as SportsBetCount from testromain.fd_cv_settled_bets_simple where SummaryDate = '2016-01-07' group by 1) as sports
on p.PlayerId = sports.PlayerId
left outer join (select PlayerId, count(Bet) as EgBetCount from testromain.fd_csc_eg_player_product_info_summ where SummaryDate = '2016-01-07' group by 1) as eg
on p.PlayerId = eg.PlayerId
where p.PlayerId is not null and (sports.SportsBetCount > 0 OR eg.EgBetCount > 0)
group by p.PlayerId
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\PlayerBetCounts_Daily.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select PlayerId, SportName,ClassName,SelectionName, count(*) as BetCount from testromain.fd_placed_bets group by 1,2,3,4 order by PlayerId,  count(*) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerPrefSports.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select PlayerId, CasinoType, GameType, sum(bet) from testromain.fd_csc_eg_player_product_info_summ group by PlayerId,CasinoType,GameType order by PlayerId, sum(bet) desc
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerPrefCasino.csv'
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
from testromain.fd_placed_bets group by 1
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerChannelPrefSP.csv'
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
from testromain.fd_csc_eg_player_product_info_summ
group by 1
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\PlayerChannelPrefEG.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


##################################bet_level_odds
select
PlayerId,
SettledDate,
BetSlipId,
BetId,
BetType,
LiveYN,
TotalStake,
TotalReturn,
CashOutStk,
CashOutWin,
BetOdds,
case when TotalReturn > 0 then 'W' else 'L' end as WinLoss,
case when (CashOutStk > 0 or CashOutWin > 0) then 'Y' else 'N' end as CashOutYN,
1
from
(select 
PlayerId,
SettledDate,
BetSlipId,
BetId,
BetType,
MAX(LiveYN) as LiveYN,
AVG(TotalStakeAmt) as TotalStake,
AVG(TotalReturn) as TotalReturn,
AVG(CashOutStake) as CashOutStk,
AVG(CashOutWin) as CashOutWin,
EXP(SUM(LOG(Odds))) as BetOdds
from testromain.fd_settled_bets
where SettledDate < '2016-01-07'
group by 1,2,3,4,5
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_bet_level_odds_wins.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Temp\\fd_bet_level_odds_wins.csv'
INTO TABLE testromain.fd_bet_level_odds_wins
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


####################Player Volatility
select 
Player.PlayerId,
COALESCE(SGLOdds.SGLAvgOdds,0.0),
COALESCE(SGLOdds.SGLSTDOdds,0.0),
COALESCE(SGLOdds.SGLCovOdds,0.0),
COALESCE(IF((CMBOdds.CMBAvgOdds > 9999999),9999999,CMBOdds.CMBAvgOdds),0.0),
COALESCE(CMBOdds.CMBSTDOdds,0.0),
COALESCE(CMBOdds.CMBCovOdds,0.0),
COALESCE(PlayerStake.SGLTotalWinninStake,0.0),
COALESCE(PlayerStake.SGLTotalStake,0.0),
COALESCE(PlayerStake.SGLTotalReturn,0.0),
COALESCE(PlayerStake.SGLTotalWinningBetCount,0.0),
COALESCE(PlayerStake.SGLTotalBetCount,0.0),
COALESCE(PlayerStake.CMBTotalWinninStake,0.0),
COALESCE(PlayerStake.CMBTotalStake,0.0),
COALESCE(PlayerStake.CMBTotalReturn,0.0),
COALESCE(PlayerStake.CMBTotalWinningBetCount,0.0),
COALESCE(PlayerStake.CMBTotalBetCount,0.0),
COALESCE((PlayerStake.SGLTotalWinningBetCount/PlayerStake.SGLTotalBetCount),0.0) as SGLWinningRatioBetCounts,
COALESCE((PlayerStake.SGLTotalWinninStake/PlayerStake.SGLTotalStake),0.0) as SGLWinningRatioStake,
COALESCE((PlayerStake.CMBTotalWinningBetCount/PlayerStake.CMBTotalBetCount),0.0) as CMBWinningRatioBetCounts,
COALESCE((PlayerStake.CMBTotalWinninStake/PlayerStake.CMBTotalStake),0.0) as CMBWinningRatioStake
from
(select PlayerId from testromain.fd_bet_level_odds_wins group by 1) as Player
left outer join
(select 
PlayerId,
AvgOdds as SGLAvgOdds,
STDOdds as SGLSTDOdds,
STDOdds/AvgOdds as SGLCovOdds
from
(
select 
PlayerId,
AVG(BetOdds) as AvgOdds,
STD(BetOdds) as STDOdds
from 
testromain.fd_bet_level_odds_wins where CashOutYN = 'N' and BetType = 'SGL'
group by 1
) temp
) as SGLOdds on Player.PlayerId = SGLOdds.PlayerId
Left outer join
(select 
PlayerId,
AvgOdds as CMBAvgOdds,
STDOdds as CMBSTDOdds,
STDOdds/AvgOdds as CMBCovOdds
from
(
select 
PlayerId,
AVG(BetOdds) as AvgOdds,
STD(BetOdds) as STDOdds
from 
testromain.fd_bet_level_odds_wins where CashOutYN = 'N' and BetType <> 'SGL'
group by 1
) temp
) as CMBOdds on Player.PlayerId = CMBOdds.PlayerId
left outer join
(select 
PlayerId,
SUM(case when BetType = 'SGL' and WinLoss = 'W' then TotalStake else 0 end) as SGLTotalWinninStake,
SUM(case when BetType = 'SGL' then TotalStake else 0 end) as SGLTotalStake,
SUM(case when BetType = 'SGL' then TotalReturn else 0 end) as SGLTotalReturn,
Count(case when BetType = 'SGL' and WinLoss = 'W' then 1 end) as SGLTotalWinningBetCount,
Count(case when BetType = 'SGL' then 1 end) as SGLTotalBetCount,
SUM(case when BetType <> 'SGL' and WinLoss = 'W' then TotalStake else 0 end) as CMBTotalWinninStake,
SUM(case when BetType <> 'SGL' then TotalStake else 0 end) as CMBTotalStake,
SUM(case when BetType <> 'SGL' then TotalReturn else 0 end) as CMBTotalReturn,
Count(case when BetType <> 'SGL' and WinLoss = 'W' then 1 end) as CMBTotalWinningBetCount,
Count(case when BetType <> 'SGL' then 1 end) as CMBTotalBetCount
from 
testromain.fd_bet_level_odds_wins
group by 1
) as PlayerStake on Player.PlayerId = PlayerStake.PlayerId
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\2016-01-07\\Mysql\\sp_cv_player_volatility.csv'
#character set utf8
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';