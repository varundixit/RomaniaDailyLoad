#LoadSequence Stage

#IB_Dim_Player_Load.sql
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Customer.csv'
into table romaniastg.STG_GIT_CSV_CUSTOMER
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_GIT_CSV_CUSTOMER_OUT.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniastg.STG_GIT_CSV_CUSTOMER;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_GIT_CSV_CUSTOMER_OUT.csv'
into table romaniastg.STG_GIT_CUSTOMER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Curl_Player.csv'
into table romaniastg.STG_IMS_CSV_PLAYER
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_IMS_CSV_PLAYER_OUT.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniastg.STG_IMS_CSV_PLAYER;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_IMS_CSV_PLAYER_OUT.csv'
into table romaniastg.STG_IMS_PLAYER
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';

select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_PLAYER.csv'
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
FROM romaniastg.STG_IMS_PLAYER as IMS
LEFT outer JOIN romaniastg.STG_GIT_CUSTOMER as GIT ON ims.Username = git.Username
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
FROM romaniastg.STG_IMS_PLAYER as IMS
RIGHT outer JOIN romaniastg.STG_GIT_CUSTOMER as GIT ON ims.Username = git.Username
) as temp;


##########Exchange Rates
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_Exchange_Rate.csv'
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from STG_Exchange_Rate;

