drop table romaniastg.STG_GIT_CSV_CUSTOMER;
CREATE TABLE romaniastg.STG_GIT_CSV_CUSTOMER (
  PlayerSPId bigint(20),
  Username varchar(200) DEFAULT NULL,
  FirstName varchar(200) DEFAULT NULL,
  LastName varchar(200) DEFAULT NULL,
  PlayerSPSegName varchar(200) DEFAULT NULL,
  AllowBonus varchar(10) DEFAULT NULL,
  PlayerCurrency varchar(10) DEFAULT NULL,
  PlayerSPRating decimal(18,6) DEFAULT NULL,
  PlayerSPRatingLive decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimit decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimitLive decimal(18,6) DEFAULT NULL,
  Operator varchar(200) DEFAULT NULL,
  Advertiser varchar(200) DEFAULT NULL,
  CasinoName varchar(200) DEFAULT NULL,
  TestYN varchar(5) DEFAULT NULL,
  CreationDate varchar(40) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\Customer.csv'
into table romaniastg.STG_GIT_CSV_CUSTOMER
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

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
from romaniastg.STG_GIT_CSV_CUSTOMER
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_GIT_CSV_CUSTOMER_OUT.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table romaniastg.STG_GIT_CUSTOMER;
CREATE TABLE romaniastg.STG_GIT_CUSTOMER (
  PlayerSPId bigint,
  Username varchar(100) DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  PlayerSPSegName varchar(500) DEFAULT NULL,
  AllowBonus varchar(10) DEFAULT NULL,
  PlayerCurrency varchar(10) DEFAULT NULL,
  PlayerSPRating decimal(18,6) DEFAULT NULL,
  PlayerSPRatingLive decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimit decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimitLive decimal(18,6) DEFAULT NULL,
  OperatorSP varchar(200) DEFAULT NULL,
  AdvertiserSP varchar(200) DEFAULT NULL,
  CasinoNameSp varchar(200) DEFAULT NULL,
  TestYNSP varchar(5) DEFAULT NULL,
  CreationDateSP datetime,
  RomDummy int
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_GIT_CSV_CUSTOMER_OUT.csv'
into table romaniastg.STG_GIT_CUSTOMER
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

drop table romaniastg.STG_IMS_CSV_PLAYER;
CREATE TABLE romaniastg.STG_IMS_CSV_PLAYER (
  AccumulatedBetRefund decimal(18,6) DEFAULT NULL,
  ActivationCode bigint default null ,
  ActivationCodeRetryCount int DEFAULT NULL,
  ActivationCodeVerified int DEFAULT NULL,
  ActiveBonusCode varchar(100) DEFAULT NULL,
  ActivePendingBonusCode varchar(100) DEFAULT NULL,
  Address varchar(500) DEFAULT NULL,
  AddressTranslate varchar(500) DEFAULT NULL,
  AddressUpper varchar(500) DEFAULT NULL,
  Advertiser int DEFAULT NULL,
  AdvertiserCode bigint DEFAULT NULL,
  AgeVerification varchar(100) DEFAULT NULL,
  AgeVerificationDate varchar(100) DEFAULT NULL,
  AllBetsIncluded int DEFAULT NULL,
  OBAuthenticationPhone varchar(100) DEFAULT NULL,
  OBAuthenticationPhonePIN varchar(100) DEFAULT NULL,
  Balance decimal(18,6) DEFAULT NULL,
  BalanceVersion int DEFAULT NULL,
  BannerID varchar(100) DEFAULT NULL,
  OBBCBalance varchar(50) DEFAULT NULL,
  OBBCBonusBalance varchar(50) DEFAULT NULL,
  OBBCCurrentBet varchar(50) DEFAULT NULL,
  OBBCPendingBonusBalance varchar(50) DEFAULT NULL,
  BellaConnectAccount int DEFAULT NULL,
  BetFairCompPoints decimal(18,6) DEFAULT NULL,
  BillingSettingGroupCode varchar(100) DEFAULT NULL,
  BingoCustom1 varchar(100) DEFAULT NULL,
  BingoCustom2 decimal(18,6) DEFAULT NULL,
  OBBingoFrozen char(1) DEFAULT NULL,
  OBBingoNickname varchar(100) DEFAULT NULL,
  BirthCity varchar(100) DEFAULT NULL,
  BirthCountryCode varchar(100) DEFAULT NULL,
  BirthDate varchar(50) DEFAULT NULL,
  BirthDepartment varchar(100) DEFAULT NULL,
  BirthProvince varchar(100) DEFAULT NULL,
  BirthProvinceCode varchar(100) DEFAULT NULL,
  BlacklistCheckDate varchar(50) DEFAULT NULL,
  Blacklisted int DEFAULT NULL,
  BonusBalance decimal(18,6) DEFAULT NULL,
  BonusBalanceVersion int DEFAULT NULL,
  BonusExcludedGameWin int DEFAULT NULL,
  BonusExcludedGameWinResetDate varchar(50) DEFAULT NULL,
  BonusGroup varchar(100) DEFAULT NULL,
  BonusSeeker int DEFAULT NULL,
  OBCantDeposit char(1) DEFAULT NULL,
  OBCantDepositAll char(1) DEFAULT NULL,
  CasinoCode int DEFAULT NULL,
  Cellphone varchar(20) DEFAULT NULL,
  ChangePokerPlayerCode varchar(100) DEFAULT NULL,
  OBChatAdminCode varchar(100) DEFAULT NULL,
  OBChatKickPeriod varchar(100) DEFAULT NULL,
  OBChatKickTime varchar(100) DEFAULT NULL,
  OBChatMutePeriod varchar(100) DEFAULT NULL,
  OBChatMuteTime varchar(100) DEFAULT NULL,
  Citizenship varchar(10) DEFAULT NULL,
  City varchar(100) DEFAULT NULL,
  OBClientParameterCode varchar(100) DEFAULT NULL,
  OBClientVersion varchar(100) DEFAULT NULL,
  Code bigint DEFAULT NULL,
  Comments varchar(500) DEFAULT NULL,
  CompPoints decimal(18,6) DEFAULT NULL,
  CountryCode varchar(100) DEFAULT NULL,
  CouponName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(50) DEFAULT NULL,
  CurrencyConversionRemainder decimal(18,6) DEFAULT NULL,
  CurrentBet decimal(18,6) DEFAULT NULL,
  CurrentBonusBet decimal(18,6) DEFAULT NULL,
  Custom01 varchar(100) DEFAULT NULL,
  Custom02 varchar(100) DEFAULT NULL,
  Custom03 varchar(50) DEFAULT NULL,
  Custom04 varchar(50) DEFAULT NULL,
  Custom05 varchar(100) DEFAULT NULL,
  Custom06 varchar(100) DEFAULT NULL,
  OBCustom07 varchar(50) DEFAULT NULL,
  Custom08 varchar(50) DEFAULT NULL,
  CustomClient01 varchar(100) DEFAULT NULL,
  CustomClient02 varchar(100) DEFAULT NULL,
  DepositGroupCode int DEFAULT NULL,
  DepositLimitAmount decimal(18,6) DEFAULT NULL,
  DepositLimitSetDate varchar(50) DEFAULT NULL,
  DepositLimitTimePeriod varchar(100) DEFAULT NULL,
  DepositRestrictions int DEFAULT NULL,
  DisableAllDeposits int DEFAULT NULL,
  DisableGaming int DEFAULT NULL,
  DisableHeldFunds int DEFAULT NULL,
  DonotCall char(10) DEFAULT NULL,
  DonotProcessWithdrawals int DEFAULT NULL,
  DriverLicenseNo varchar(100) DEFAULT NULL,
  DupSearchExclude int DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  EmailVerified int DEFAULT NULL,
  EncryptionKeyVersion varchar(100) DEFAULT NULL,
  ExternalCreateType varchar(100) DEFAULT NULL,
  ExternalID varchar(100) DEFAULT NULL,
  FAX varchar(100) DEFAULT NULL,
  FirstDepositClientParameter int DEFAULT NULL,
  FirstLoginDate varchar(50) DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  FirstNameSoundEx varchar(100) DEFAULT NULL,
  FraudAdminCode int DEFAULT NULL,
  FraudCheckDate varchar(50) DEFAULT NULL,
  FreezeChat char(1) DEFAULT NULL,
  Frozen int DEFAULT NULL,
  Gender char(1) DEFAULT NULL,
  GlobalFirstDepositDate varchar(50) DEFAULT NULL,
  GroupParentCode int DEFAULT NULL,
  HaveIDCopyFAX int DEFAULT NULL,
  HeardFrom varchar(100) DEFAULT NULL,
  Iban varchar(100) DEFAULT NULL,
  IDCardNo varchar(100) DEFAULT NULL,
  IncludeFirstDeposit int DEFAULT NULL,
  IncludeSignup int DEFAULT NULL,
  InternalAccount int DEFAULT NULL,
  OBIPProxyAllowed varchar(100) DEFAULT NULL,
  OBKickOut varchar(100) DEFAULT NULL,
  KioskAdminCode int DEFAULT NULL,
  KioskCode int DEFAULT NULL,
  OBLanguageCode varchar(100) DEFAULT NULL,
  OBLastFailedLogin varchar(50) DEFAULT NULL,
  OBLastLoginClientType varchar(100) DEFAULT NULL,
  OBLastLoginDate varchar(50) DEFAULT NULL,
  OBLastLoginKioskCode varchar(100) DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  LastNameSoundEx varchar(100) DEFAULT NULL,
  LastNameUpper varchar(100) DEFAULT NULL,
  OBLastSupportChatSessionTime varchar(100) DEFAULT NULL,
  LoginCount varchar(50) DEFAULT NULL,
  LogMessages int DEFAULT NULL,
  MaxBalance decimal(18,6) DEFAULT NULL,
  MaxTotalBalance decimal(18,6) DEFAULT NULL,
  MobileGameRequestEmail char(100) DEFAULT NULL,
  MoneyReceiving int DEFAULT NULL,
  MoneySending int DEFAULT NULL,
  MoneyToRisk decimal(18,6) DEFAULT NULL,
  NoBonus int DEFAULT NULL,
  OBNtries varchar(100) DEFAULT NULL,
  Occupation varchar(100) DEFAULT NULL,
  OrigAdvertiserCode int DEFAULT NULL,
  OrigBannerID varchar(100) DEFAULT NULL,
  OrigProfileID varchar(100) DEFAULT NULL,
  OrigRefererURL varchar(500) DEFAULT NULL,
  PassportID varchar(100) DEFAULT NULL,
  OBPasswordChange char(1) DEFAULT NULL,
  OBPasswordChangeDate varchar(50) DEFAULT NULL,
  PendingBonusBalance decimal(18,6) DEFAULT NULL,
  PersonalID varchar(100) DEFAULT NULL,
  Phone varchar(100) DEFAULT NULL,
  PhoneTranslate varchar(100) DEFAULT NULL,
  PhoneUpper varchar(100) DEFAULT NULL,
  OBPINDisabled varchar(100) DEFAULT NULL,
  OBPINNumber varchar(100) DEFAULT NULL,
  OBPINRetryCount varchar(50) DEFAULT NULL,
  PlayerRiskProfileChangeDate varchar(50) DEFAULT NULL,
  PlayerRiskProfileCode int DEFAULT NULL,
  PlayersTS varchar(100) DEFAULT NULL,
  PlayerType int DEFAULT NULL,
  PokerBlocked int DEFAULT NULL,
  PokerCustom1 varchar(100) DEFAULT NULL,
  PokerCustom2 decimal(18,6) DEFAULT NULL,
  PokerFrozen int DEFAULT NULL,
  PokerNickname varchar(100) DEFAULT NULL,
  PokerVIPLevel int DEFAULT NULL,
  PostOfficeBOX varchar(100) DEFAULT NULL,
  ProfileID varchar(100) DEFAULT NULL,
  Province varchar(100) DEFAULT NULL,
  ProvinceCode int DEFAULT NULL,
  RefererURL varchar(500) DEFAULT NULL,
  RegionCode int DEFAULT NULL,
  RegistrationCheckDate varchar(50) DEFAULT NULL,
  RegulatorApproval int DEFAULT NULL,
  RemainingBonuses decimal(18,6) DEFAULT NULL,
  RemindAfterTimePeriod int DEFAULT NULL,
  RemindOnFirstBet int DEFAULT NULL,
  RemoteChangeTimestamp varchar(50) DEFAULT NULL,
  RemoteSync int DEFAULT NULL,
  ReservedBalance decimal(18,6) DEFAULT NULL,
  Serial varchar(100) DEFAULT NULL,
  SignupClientType varchar(50) DEFAULT NULL,
  SignupAdvertiserCode int DEFAULT NULL,
  SignupChannelCode int DEFAULT NULL,
  SignupClientParameterCode int DEFAULT NULL,
  SignupClientSkinCode int DEFAULT NULL,
  SignupDate varchar(50) DEFAULT NULL,
  SignupRemoteIP varchar(20) DEFAULT NULL,
  SignupVersion varchar(100) DEFAULT NULL,
  State varchar(100) DEFAULT NULL,
  SyncBetFairCompPoints int DEFAULT NULL,
  TempApproveDeposit int DEFAULT NULL,
  Title varchar(100) DEFAULT NULL,
  OBTokenStatus varchar(100) DEFAULT NULL,
  TotalCompPoints decimal(18,6) DEFAULT NULL,
  TrackingID1 varchar(100) DEFAULT NULL,
  TrackingID2 varchar(100) DEFAULT NULL,
  TrackingID3 decimal(18,6) DEFAULT NULL,
  TrackingID4 varchar(100) DEFAULT NULL,
  TrackingID5 varchar(100) DEFAULT NULL,
  TrackingID6 varchar(100) DEFAULT NULL,
  TrackingID7 varchar(100) DEFAULT NULL,
  TrackingID8 varchar(100) DEFAULT NULL,
  UnsubscribeDate varchar(50) DEFAULT NULL,
  Username varchar(100) DEFAULT NULL,
  OBVerificationAnswer varchar(100) DEFAULT NULL,
  OBVerificationQuestion varchar(100) DEFAULT NULL,
  VideoBet int DEFAULT NULL,
  VIPLevel int DEFAULT NULL,
  VIPLevelUPDate varchar(50) DEFAULT NULL,
  Wagering decimal(18,6) DEFAULT NULL,
  WageringRealLoss decimal(18,6) DEFAULT NULL,
  OBWantMail char(1) DEFAULT NULL,
  OBWantSMS char(1) DEFAULT NULL,
  WithdrawVerifyCode varchar(100) DEFAULT NULL,
  WorkPhone varchar(100) DEFAULT NULL,
  ZIP varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\Curl_Player.csv'
into table romaniastg.STG_IMS_CSV_PLAYER
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

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
from STG_IMS_CSV_PLAYER
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_IMS_CSV_PLAYER_OUT.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table romaniastg.STG_IMS_PLAYER;
CREATE TABLE romaniastg.STG_IMS_PLAYER (
  AccumulatedBetRefund decimal(18,6) DEFAULT NULL,
  ActivationCode bigint default null ,
  ActivationCodeRetryCount int DEFAULT NULL,
  ActivationCodeVerified int DEFAULT NULL,
  ActiveBonusCode varchar(100) DEFAULT NULL,
  ActivePendingBonusCode varchar(100) DEFAULT NULL,
  Address varchar(500) DEFAULT NULL,
  AddressTranslate varchar(500) DEFAULT NULL,
  AddressUpper varchar(500) DEFAULT NULL,
  Advertiser int DEFAULT NULL,
  AdvertiserCode bigint DEFAULT NULL,
  AgeVerification varchar(100) DEFAULT NULL,
  AgeVerificationDate datetime DEFAULT NULL,
  AllBetsIncluded int DEFAULT NULL,
  Balance decimal(18,6) DEFAULT NULL,
  BalanceVersion int DEFAULT NULL,
  BannerID varchar(100) DEFAULT NULL,
  BellaConnectAccount int DEFAULT NULL,
  BetFairCompPoints decimal(18,6) DEFAULT NULL,
  BillingSettingGroupCode varchar(100) DEFAULT NULL,
  BingoCustom1 varchar(100) DEFAULT NULL,
  BingoCustom2 decimal(18,6) DEFAULT NULL,
  BirthCity varchar(100) DEFAULT NULL,
  BirthCountryCode varchar(100) DEFAULT NULL,
  BirthDate date DEFAULT NULL,
  BirthDepartment varchar(100) DEFAULT NULL,
  BirthProvince varchar(100) DEFAULT NULL,
  BirthProvinceCode varchar(100) DEFAULT NULL,
  BlacklistCheckDate datetime DEFAULT NULL,
  Blacklisted int DEFAULT NULL,
  BonusBalance decimal(18,6) DEFAULT NULL,
  BonusBalanceVersion int DEFAULT NULL,
  BonusExcludedGameWin int DEFAULT NULL,
  BonusExcludedGameWinResetDate datetime DEFAULT NULL,
  BonusGroup varchar(100) DEFAULT NULL,
  BonusSeeker int DEFAULT NULL,
  CasinoCode int DEFAULT NULL,
  Cellphone varchar(20) DEFAULT NULL,
  ChangePokerPlayerCode varchar(100) DEFAULT NULL,
  Citizenship varchar(10) DEFAULT NULL,
  City varchar(100) DEFAULT NULL,
  PlayerID bigint DEFAULT NULL,
  Comments varchar(500) DEFAULT NULL,
  CompPoints decimal(18,6) DEFAULT NULL,
  CountryCode varchar(100) DEFAULT NULL,
  CouponName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(50) DEFAULT NULL,
  CurrencyConversionRemainder decimal(18,6) DEFAULT NULL,
  CurrentBet decimal(18,6) DEFAULT NULL,
  CurrentBonusBet decimal(18,6) DEFAULT NULL,
  Custom01 varchar(100) DEFAULT NULL,
  Custom02 varchar(100) DEFAULT NULL,
  Custom03 varchar(50) DEFAULT NULL,
  Custom04 varchar(50) DEFAULT NULL,
  Custom05 varchar(100) DEFAULT NULL,
  Custom06 varchar(100) DEFAULT NULL,
  Custom08 varchar(50) DEFAULT NULL,
  CustomClient01 varchar(100) DEFAULT NULL,
  CustomClient02 varchar(100) DEFAULT NULL,
  DepositGroupCode int DEFAULT NULL,
  DepositLimitAmount decimal(18,6) DEFAULT NULL,
  DepositLimitSetDate datetime DEFAULT NULL,
  DepositLimitTimePeriod varchar(100) DEFAULT NULL,
  DepositRestrictions int DEFAULT NULL,
  DisableAllDeposits int DEFAULT NULL,
  DisableGaming int DEFAULT NULL,
  DisableHeldFunds int DEFAULT NULL,
  DonotCall char(10) DEFAULT NULL,
  DonotProcessWithdrawals int DEFAULT NULL,
  DriverLicenseNo varchar(100) DEFAULT NULL,
  DupSearchExclude int DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  EmailVerified int DEFAULT NULL,
  EncryptionKeyVersion varchar(100) DEFAULT NULL,
  ExternalCreateType varchar(100) DEFAULT NULL,
  ExternalID varchar(100) DEFAULT NULL,
  FAX varchar(100) DEFAULT NULL,
  FirstDepositClientParameter int DEFAULT NULL,
  FirstLoginDate datetime DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  FirstNameSoundEx varchar(100) DEFAULT NULL,
  FraudAdminCode int DEFAULT NULL,
  FraudCheckDate datetime DEFAULT NULL,
  FreezeChat char(1) DEFAULT NULL,
  Frozen int DEFAULT NULL,
  Gender char(1) DEFAULT NULL,
  GlobalFirstDepositDate datetime DEFAULT NULL,
  GroupParentCode int DEFAULT NULL,
  HaveIDCopyFAX int DEFAULT NULL,
  HeardFrom varchar(100) DEFAULT NULL,
  Iban varchar(100) DEFAULT NULL,
  IDCardNo varchar(100) DEFAULT NULL,
  IncludeFirstDeposit int DEFAULT NULL,
  IncludeSignup int DEFAULT NULL,
  InternalAccount int DEFAULT NULL,
  KioskAdminCode int DEFAULT NULL,
  KioskCode int DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  LastNameSoundEx varchar(100) DEFAULT NULL,
  LastNameUpper varchar(100) DEFAULT NULL,
  LoginCount varchar(50) DEFAULT NULL,
  LogMessages int DEFAULT NULL,
  MaxBalance decimal(18,6) DEFAULT NULL,
  MaxTotalBalance decimal(18,6) DEFAULT NULL,
  MobileGameRequestEmail char(100) DEFAULT NULL,
  MoneyReceiving int DEFAULT NULL,
  MoneySending int DEFAULT NULL,
  MoneyToRisk decimal(18,6) DEFAULT NULL,
  NoBonus int DEFAULT NULL,
  Occupation varchar(100) DEFAULT NULL,
  OrigAdvertiserCode int DEFAULT NULL,
  OrigBannerID varchar(100) DEFAULT NULL,
  OrigProfileID varchar(100) DEFAULT NULL,
  OrigRefererURL varchar(500) DEFAULT NULL,
  PassportID varchar(100) DEFAULT NULL,
  PendingBonusBalance decimal(18,6) DEFAULT NULL,
  PersonalID varchar(100) DEFAULT NULL,
  Phone varchar(100) DEFAULT NULL,
  PhoneTranslate varchar(100) DEFAULT NULL,
  PhoneUpper varchar(100) DEFAULT NULL,
  PlayerRiskProfileChangeDate datetime DEFAULT NULL,
  PlayerRiskProfileCode int DEFAULT NULL,
  LastUpsTimestamp datetime DEFAULT NULL,
  PlayerType int DEFAULT NULL,
  PokerBlocked int DEFAULT NULL,
  PokerCustom1 varchar(100) DEFAULT NULL,
  PokerCustom2 decimal(18,6) DEFAULT NULL,
  PokerFrozen int DEFAULT NULL,
  PokerNickname varchar(100) DEFAULT NULL,
  PokerVIPLevel int DEFAULT NULL,
  PostOfficeBOX varchar(100) DEFAULT NULL,
  ProfileID varchar(100) DEFAULT NULL,
  Province varchar(100) DEFAULT NULL,
  ProvinceCode int DEFAULT NULL,
  RefererURL varchar(500) DEFAULT NULL,
  RegionCode int DEFAULT NULL,
  RegistrationCheckDate datetime DEFAULT NULL,
  RegulatorApproval int DEFAULT NULL,
  RemainingBonuses decimal(18,6) DEFAULT NULL,
  RemindAfterTimePeriod int DEFAULT NULL,
  RemindOnFirstBet int DEFAULT NULL,
  RemoteChangeTimestamp datetime DEFAULT NULL,
  RemoteSync int DEFAULT NULL,
  ReservedBalance decimal(18,6) DEFAULT NULL,
  Serial varchar(100) DEFAULT NULL,
  SignupClientType varchar(50) DEFAULT NULL,
  SignupAdvertiserCode int DEFAULT NULL,
  SignupChannelCode int DEFAULT NULL,
  SignupClientParameterCode int DEFAULT NULL,
  SignupClientSkinCode int DEFAULT NULL,
  SignupDate datetime DEFAULT NULL,
  SignupRemoteIP varchar(20) DEFAULT NULL,
  SignupVersion varchar(100) DEFAULT NULL,
  State varchar(100) DEFAULT NULL,
  SyncBetFairCompPoints int DEFAULT NULL,
  TempApproveDeposit int DEFAULT NULL,
  Title varchar(100) DEFAULT NULL,
  TotalCompPoints decimal(18,6) DEFAULT NULL,
  TrackingID1 varchar(100) DEFAULT NULL,
  TrackingID2 varchar(100) DEFAULT NULL,
  TrackingID3 decimal(18,6) DEFAULT NULL,
  TrackingID4 varchar(100) DEFAULT NULL,
  TrackingID5 varchar(100) DEFAULT NULL,
  TrackingID6 varchar(100) DEFAULT NULL,
  TrackingID7 varchar(100) DEFAULT NULL,
  TrackingID8 varchar(100) DEFAULT NULL,
  UnsubscribeDate datetime DEFAULT NULL,
  Username varchar(100) DEFAULT NULL,
  VideoBet int DEFAULT NULL,
  VIPLevel int DEFAULT NULL,
  VIPLevelUPDate datetime DEFAULT NULL,
  Wagering decimal(18,6) DEFAULT NULL,
  WageringRealLoss decimal(18,6) DEFAULT NULL,
  WithdrawVerifyCode varchar(100) DEFAULT NULL,
  WorkPhone varchar(100) DEFAULT NULL,
  ZIP varchar(100) DEFAULT NULL,
  RomDummy int
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_IMS_CSV_PLAYER_OUT.csv'
into table romaniastg.STG_IMS_PLAYER
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

drop table romaniamain.DIM_PLAYER;
CREATE TABLE romaniamain.DIM_PLAYER (
  AccumulatedBetRefund decimal(18,6) DEFAULT NULL,
  ActivationCode bigint default null ,
  ActivationCodeRetryCount int DEFAULT NULL,
  ActivationCodeVerified int DEFAULT NULL,
  ActiveBonusCode varchar(100) DEFAULT NULL,
  ActivePendingBonusCode varchar(100) DEFAULT NULL,
  Address varchar(500) DEFAULT NULL,
  AddressTranslate varchar(500) DEFAULT NULL,
  AddressUpper varchar(500) DEFAULT NULL,
  Advertiser int DEFAULT NULL,
  AdvertiserCode bigint DEFAULT NULL,
  AgeVerification varchar(100) DEFAULT NULL,
  AgeVerificationDate datetime DEFAULT NULL,
  AllBetsIncluded int DEFAULT NULL,
  Balance decimal(18,6) DEFAULT NULL,
  BalanceVersion int DEFAULT NULL,
  BannerID varchar(100) DEFAULT NULL,
  BellaConnectAccount int DEFAULT NULL,
  BetFairCompPoints decimal(18,6) DEFAULT NULL,
  BillingSettingGroupCode varchar(100) DEFAULT NULL,
  BingoCustom1 varchar(100) DEFAULT NULL,
  BingoCustom2 decimal(18,6) DEFAULT NULL,
  BirthCity varchar(100) DEFAULT NULL,
  BirthCountryCode varchar(100) DEFAULT NULL,
  BirthDate date DEFAULT NULL,
  BirthDepartment varchar(100) DEFAULT NULL,
  BirthProvince varchar(100) DEFAULT NULL,
  BirthProvinceCode varchar(100) DEFAULT NULL,
  BlacklistCheckDate datetime DEFAULT NULL,
  Blacklisted int DEFAULT NULL,
  BonusBalance decimal(18,6) DEFAULT NULL,
  BonusBalanceVersion int DEFAULT NULL,
  BonusExcludedGameWin int DEFAULT NULL,
  BonusExcludedGameWinResetDate datetime DEFAULT NULL,
  BonusGroup varchar(100) DEFAULT NULL,
  BonusSeeker int DEFAULT NULL,
  CasinoCode int DEFAULT NULL,
  Cellphone varchar(20) DEFAULT NULL,
  ChangePokerPlayerCode varchar(100) DEFAULT NULL,
  Citizenship varchar(10) DEFAULT NULL,
  City varchar(100) DEFAULT NULL,
  PlayerID bigint DEFAULT NULL,
  Comments varchar(500) DEFAULT NULL,
  CompPoints decimal(18,6) DEFAULT NULL,
  CountryCode varchar(100) DEFAULT NULL,
  CouponName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(50) DEFAULT NULL,
  CurrencyConversionRemainder decimal(18,6) DEFAULT NULL,
  CurrentBet decimal(18,6) DEFAULT NULL,
  CurrentBonusBet decimal(18,6) DEFAULT NULL,
  Custom01 varchar(100) DEFAULT NULL,
  Custom02 varchar(100) DEFAULT NULL,
  Custom03 varchar(50) DEFAULT NULL,
  Custom04 varchar(50) DEFAULT NULL,
  Custom05 varchar(100) DEFAULT NULL,
  Custom06 varchar(100) DEFAULT NULL,
  Custom08 varchar(50) DEFAULT NULL,
  CustomClient01 varchar(100) DEFAULT NULL,
  CustomClient02 varchar(100) DEFAULT NULL,
  DepositGroupCode int DEFAULT NULL,
  DepositLimitAmount decimal(18,6) DEFAULT NULL,
  DepositLimitSetDate datetime DEFAULT NULL,
  DepositLimitTimePeriod varchar(100) DEFAULT NULL,
  DepositRestrictions int DEFAULT NULL,
  DisableAllDeposits int DEFAULT NULL,
  DisableGaming int DEFAULT NULL,
  DisableHeldFunds int DEFAULT NULL,
  DonotCall char(10) DEFAULT NULL,
  DonotProcessWithdrawals int DEFAULT NULL,
  DriverLicenseNo varchar(100) DEFAULT NULL,
  DupSearchExclude int DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  EmailVerified int DEFAULT NULL,
  EncryptionKeyVersion varchar(100) DEFAULT NULL,
  ExternalCreateType varchar(100) DEFAULT NULL,
  ExternalID varchar(100) DEFAULT NULL,
  FAX varchar(100) DEFAULT NULL,
  FirstDepositClientParameter int DEFAULT NULL,
  FirstLoginDate datetime DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  FirstNameSoundEx varchar(100) DEFAULT NULL,
  FraudAdminCode int DEFAULT NULL,
  FraudCheckDate datetime DEFAULT NULL,
  FreezeChat char(1) DEFAULT NULL,
  Frozen int DEFAULT NULL,
  Gender char(1) DEFAULT NULL,
  GlobalFirstDepositDate datetime DEFAULT NULL,
  GroupParentCode int DEFAULT NULL,
  HaveIDCopyFAX int DEFAULT NULL,
  HeardFrom varchar(100) DEFAULT NULL,
  Iban varchar(100) DEFAULT NULL,
  IDCardNo varchar(100) DEFAULT NULL,
  IncludeFirstDeposit int DEFAULT NULL,
  IncludeSignup int DEFAULT NULL,
  InternalAccount int DEFAULT NULL,
  KioskAdminCode int DEFAULT NULL,
  KioskCode int DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  LastNameSoundEx varchar(100) DEFAULT NULL,
  LastNameUpper varchar(100) DEFAULT NULL,
  LoginCount varchar(50) DEFAULT NULL,
  LogMessages int DEFAULT NULL,
  MaxBalance decimal(18,6) DEFAULT NULL,
  MaxTotalBalance decimal(18,6) DEFAULT NULL,
  MobileGameRequestEmail char(100) DEFAULT NULL,
  MoneyReceiving int DEFAULT NULL,
  MoneySending int DEFAULT NULL,
  MoneyToRisk decimal(18,6) DEFAULT NULL,
  NoBonus int DEFAULT NULL,
  Occupation varchar(100) DEFAULT NULL,
  OrigAdvertiserCode int DEFAULT NULL,
  OrigBannerID varchar(100) DEFAULT NULL,
  OrigProfileID varchar(100) DEFAULT NULL,
  OrigRefererURL varchar(500) DEFAULT NULL,
  PassportID varchar(100) DEFAULT NULL,
  PendingBonusBalance decimal(18,6) DEFAULT NULL,
  PersonalID varchar(100) DEFAULT NULL,
  Phone varchar(100) DEFAULT NULL,
  PhoneTranslate varchar(100) DEFAULT NULL,
  PhoneUpper varchar(100) DEFAULT NULL,
  PlayerRiskProfileChangeDate datetime DEFAULT NULL,
  PlayerRiskProfileCode int DEFAULT NULL,
  LastUpsTimestamp datetime DEFAULT NULL,
  PlayerType int DEFAULT NULL,
  PokerBlocked int DEFAULT NULL,
  PokerCustom1 varchar(100) DEFAULT NULL,
  PokerCustom2 decimal(18,6) DEFAULT NULL,
  PokerFrozen int DEFAULT NULL,
  PokerNickname varchar(100) DEFAULT NULL,
  PokerVIPLevel int DEFAULT NULL,
  PostOfficeBOX varchar(100) DEFAULT NULL,
  ProfileID varchar(100) DEFAULT NULL,
  Province varchar(100) DEFAULT NULL,
  ProvinceCode int DEFAULT NULL,
  RefererURL varchar(500) DEFAULT NULL,
  RegionCode int DEFAULT NULL,
  RegistrationCheckDate datetime DEFAULT NULL,
  RegulatorApproval int DEFAULT NULL,
  RemainingBonuses decimal(18,6) DEFAULT NULL,
  RemindAfterTimePeriod int DEFAULT NULL,
  RemindOnFirstBet int DEFAULT NULL,
  RemoteChangeTimestamp datetime DEFAULT NULL,
  RemoteSync int DEFAULT NULL,
  ReservedBalance decimal(18,6) DEFAULT NULL,
  Serial varchar(100) DEFAULT NULL,
  SignupClientType varchar(50) DEFAULT NULL,
  SignupAdvertiserCode int DEFAULT NULL,
  SignupChannelCode int DEFAULT NULL,
  SignupClientParameterCode int DEFAULT NULL,
  SignupClientSkinCode int DEFAULT NULL,
  SignupDate datetime DEFAULT NULL,
  SignupRemoteIP varchar(20) DEFAULT NULL,
  SignupVersion varchar(100) DEFAULT NULL,
  State varchar(100) DEFAULT NULL,
  SyncBetFairCompPoints int DEFAULT NULL,
  TempApproveDeposit int DEFAULT NULL,
  Title varchar(100) DEFAULT NULL,
  TotalCompPoints decimal(18,6) DEFAULT NULL,
  TrackingID1 varchar(100) DEFAULT NULL,
  TrackingID2 varchar(100) DEFAULT NULL,
  TrackingID3 decimal(18,6) DEFAULT NULL,
  TrackingID4 varchar(100) DEFAULT NULL,
  TrackingID5 varchar(100) DEFAULT NULL,
  TrackingID6 varchar(100) DEFAULT NULL,
  TrackingID7 varchar(100) DEFAULT NULL,
  TrackingID8 varchar(100) DEFAULT NULL,
  UnsubscribeDate datetime DEFAULT NULL,
  Username varchar(100) DEFAULT NULL,
  VideoBet int DEFAULT NULL,
  VIPLevel int DEFAULT NULL,
  VIPLevelUPDate datetime DEFAULT NULL,
  Wagering decimal(18,6) DEFAULT NULL,
  WageringRealLoss decimal(18,6) DEFAULT NULL,
  WithdrawVerifyCode varchar(100) DEFAULT NULL,
  WorkPhone varchar(100) DEFAULT NULL,
  ZIP varchar(100) DEFAULT NULL,
  RomDummy int,
  PlayerSPId bigint default null,
  PlayerSPSegName varchar(200) DEFAULT NULL,
  AllowSPBonus varchar(10) DEFAULT NULL,
  PlayerSPCurrency varchar(10) DEFAULT NULL,
  PlayerSPRating decimal(18,6) DEFAULT NULL,
  PlayerSPRatingLive decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimit decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimitLive decimal(18,6) DEFAULT NULL,
  OperatorSP varchar(200) DEFAULT NULL,
  AdvertiserSP varchar(200) DEFAULT NULL,
  SPCasinoNameSP varchar(200) DEFAULT NULL,
  TestYNSP varchar(5) DEFAULT NULL,
  CreationDateSP datetime DEFAULT NULL
 )ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
select temp.* from
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
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_PLAYER.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\STG_PLAYER.csv'
into table romaniamain.DIM_PLAYER
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

#select count(1) from romaniamain.DIM_PLAYER where PlayerID is null;#13

###IB_Placed_Bets_Load.sql
drop table romaniastg.stg_placed_bets_csv;
CREATE TABLE romaniastg.stg_placed_bets_csv (
  BetslipId bigint(20) DEFAULT NULL,
  BetslipStatus varchar(20) DEFAULT NULL,
  BetId bigint(20) DEFAULT NULL,
  BetType varchar(20) DEFAULT NULL,
  BetTime varchar(50) DEFAULT NULL,
  BetStatus varchar(20) DEFAULT NULL,
  ReferredYN varchar(50) DEFAULT NULL,
  CancelReason varchar(500) DEFAULT NULL,
  NumLegs int(11) DEFAULT NULL,
  NumPart int(11) DEFAULT NULL,
  LegSort varchar(20) DEFAULT NULL,
  SelectionId bigint(20) DEFAULT NULL,
  SelectionName varchar(1000) DEFAULT NULL,
  SelectionSort varchar(20) DEFAULT NULL,
  MarketId bigint(20) DEFAULT NULL,
  MarketName varchar(1000) DEFAULT NULL,
  MarketSort varchar(20) DEFAULT NULL,
  EventId bigint(20) DEFAULT NULL,
  EventName varchar(1000) DEFAULT NULL,
  EventStartTime varchar(50) DEFAULT NULL,
  MeetingName varchar(1000) DEFAULT NULL,
  RaceType varchar(500) DEFAULT NULL,
  TypeId bigint(20) DEFAULT NULL,
  TypeName varchar(1000) DEFAULT NULL,
  ClassId bigint(20) DEFAULT NULL,
  ClassName varchar(1000) DEFAULT NULL,
  SportCode varchar(20) DEFAULT NULL,
  SportName varchar(100) DEFAULT NULL,
  PlayerId bigint(20) DEFAULT NULL,
  UserName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(20) DEFAULT NULL,
  NumLines int(11) DEFAULT NULL,
  StakePerLine decimal(18,6) DEFAULT NULL,
  StakePerLineBC decimal(18,6) DEFAULT NULL,
  StakeAmt decimal(18,6) DEFAULT NULL,
  StakeAmtBC decimal(18,6) DEFAULT NULL,
  BonusId bigint(20) DEFAULT NULL,
  CampaignId bigint(20) DEFAULT NULL,
  BonusStakeAmt decimal(18,6) DEFAULT NULL,
  BonusStakeAmtBC decimal(18,6) DEFAULT NULL,
  BonusBalanceStake decimal(18,6) DEFAULT NULL,
  BonusBalanceStakeBC decimal(18,6) DEFAULT NULL,
  LiveYN varchar(5) DEFAULT NULL,
  OddsType varchar(5) DEFAULT NULL,
  Odds decimal(18,6) DEFAULT NULL,
  EitherwaySort varchar(5) DEFAULT NULL,
  ViewId int(11) DEFAULT NULL,
  Channel varchar(20) DEFAULT NULL,
  Operator varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\Placed_Bets.csv' 
INTO TABLE romaniastg.stg_placed_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
from stg_placed_bets_csv
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\stg_placed_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

drop table stg_placed_bets;
CREATE TABLE stg_placed_bets (
  BetslipId bigint(20) DEFAULT NULL,
  BetslipStatus varchar(20) DEFAULT NULL,
  BetId bigint(20) DEFAULT NULL,
  BetType varchar(20) DEFAULT NULL,
  BetTime datetime DEFAULT NULL,
  BetDate date DEFAULT NULL,
  BetStatus varchar(20) DEFAULT NULL,
  ReferredYN varchar(50) DEFAULT NULL,
  CancelReason varchar(500) DEFAULT NULL,
  NumLegs int(11) DEFAULT NULL,
  NumPart int(11) DEFAULT NULL,
  LegSort varchar(20) DEFAULT NULL,
  SelectionId bigint(20) DEFAULT NULL,
  SelectionName varchar(1000) DEFAULT NULL,
  SelectionSort varchar(20) DEFAULT NULL,
  MarketId bigint(20) DEFAULT NULL,
  MarketName varchar(1000) DEFAULT NULL,
  MarketSort varchar(20) DEFAULT NULL,
  EventId bigint(20) DEFAULT NULL,
  EventName varchar(1000) DEFAULT NULL,
  EventStartTime datetime DEFAULT NULL,
  MeetingName varchar(1000) DEFAULT NULL,
  RaceType varchar(500) DEFAULT NULL,
  TypeId bigint(20) DEFAULT NULL,
  TypeName varchar(1000) DEFAULT NULL,
  ClassId bigint(20) DEFAULT NULL,
  ClassName varchar(1000) DEFAULT NULL,
  SportCode varchar(20) DEFAULT NULL,
  SportName varchar(100) DEFAULT NULL,
  PlayerId bigint(20) DEFAULT NULL,
  UserName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(20) DEFAULT NULL,
  NumLines int(11) DEFAULT NULL,
  StakePerLine decimal(18,6) DEFAULT NULL,
  StakePerLineBC decimal(18,6) DEFAULT NULL,
  StakeAmt decimal(18,6) DEFAULT NULL,
  StakeAmtBC decimal(18,6) DEFAULT NULL,
  BonusId bigint(20) DEFAULT NULL,
  CampaignId bigint(20) DEFAULT NULL,
  BonusStakeAmt decimal(18,6) DEFAULT NULL,
  BonusStakeAmtBC decimal(18,6) DEFAULT NULL,
  BonusBalanceStake decimal(18,6) DEFAULT NULL,
  BonusBalanceStakeBC decimal(18,6) DEFAULT NULL,
  LiveYN varchar(5) DEFAULT NULL,
  OddsType varchar(5) DEFAULT NULL,
  Odds decimal(18,6) DEFAULT NULL,
  EitherwaySort varchar(5) DEFAULT NULL,
  ViewId int(11) DEFAULT NULL,
  Channel varchar(20) DEFAULT NULL,
  Operator varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\stg_placed_bets.csv' 
INTO TABLE romaniastg.stg_placed_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
from stg_placed_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\stg_placed_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


######!!!!!!!!!!!!!! below line has to be run only if above all load completes successfully #####################

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\stg_placed_bets.csv' 
INTO TABLE  romaniamain.fd_placed_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

##################################################################################################################


###################################################Conditional Loads##############################################

# recreating the Dim Client Parameter table
drop table romaniamain.DIM_CLIENT_PARAMETER;
create table romaniamain.DIM_CLIENT_PARAMETER (
  ClientPlatform varchar(200)
, ClientType varchar(200)
, ClientParameterCode int
, UsedInAdRevenue int
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\DIM_CLIENT_PARAMETER.csv' 
INTO TABLE  romaniamain.DIM_CLIENT_PARAMETER
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

# recreating the Dim Game List table
drop table romaniamain.dim_game_list;
CREATE TABLE romaniamain.dim_game_list (
 ATTRIBUTES varchar(200)
,COIN varchar(200)
,DESCRIPTION varchar(500)
,EARNINGPOTENTIAL decimal(18,6)
,FROZEN int
,GAMEGROUP varchar(200)
,GAMETYPE varchar(200)
,HASMARVELJACKPOT varchar(10)
,HASSIDEGAMES varchar(10)
,JACKPOTRATIO decimal(18,0)
,JACKPOTSEED decimal(18,0)
,LIVEGAME int
,LIVEGAMEGROUP varchar(50)
,LONGNAME varchar(500)
,MOBILEGAME int 
,MPGAMEGROUP varchar(50)
,NAME varchar(500)
,NMGAMECODE  bigint(20)
,PHPCLASSNAME varchar(500)
,SHORTNAME varchar(50)
,SIDEGAME int
,SLOTLINES int
,TYPE varchar(20)
,USEBONUS int
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Games\\dim_game_list.csv' 
INTO TABLE  romaniamain.dim_game_list
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#if advertisers are more than 1187
drop table romaniaStg.Advertisers;
Create table romaniaStg.Advertisers(
ADDRESS	varchar(100)	DEFAULT NULL,
ADVANCEDVIEW	integer	DEFAULT NULL,
ADVERTISERS_TS	date	DEFAULT NULL,
ADVERTISERTYPE	varchar(50)	DEFAULT NULL,
ADVSELECTEDFIELDS	varchar(500)	DEFAULT NULL,
ADVSYSTEMCODE	integer	DEFAULT NULL,
AUTOMATICREVENUEWRITEOFF	integer	DEFAULT NULL,
AVAILABLEBALANCE	integer	DEFAULT NULL,
BALANCE	integer	DEFAULT NULL,
BANNERID	varchar(50)	DEFAULT NULL,
BIRTHDATE	date	DEFAULT NULL,
CASHIERLIMIT	integer	DEFAULT NULL,
CITY	varchar(50)	DEFAULT NULL,
CODE	integer	DEFAULT NULL,
COMMENTS	varchar(50)	DEFAULT NULL,
COMPANY	varchar(50)	DEFAULT NULL,
CONTROLEXIT	integer	DEFAULT NULL,
COUNTRYCODE	varchar(50)	DEFAULT NULL,
CURRENCYCODE	varchar(10)	DEFAULT NULL,
DEFAULTVIPLEVEL	integer	DEFAULT NULL,
EMAIL	varchar(50)	DEFAULT NULL,
ENABLEDREPORTS	varchar(200)	DEFAULT NULL,
EXITURL	varchar(50)	DEFAULT NULL,
FAX	varchar(50)	DEFAULT NULL,
FIRSTNAME	varchar(50)	DEFAULT NULL,
FROZEN	integer	DEFAULT NULL,
GENDER	varchar(10)	DEFAULT NULL,
GROUPCODE	integer	DEFAULT NULL,
INACTIVE	integer	DEFAULT NULL,
INTERNALACCOUNT	integer	DEFAULT NULL,
ISCASHIER	integer	DEFAULT NULL,
ISSPAMMER	integer	DEFAULT NULL,
LANGUAGECODE	varchar(10)	DEFAULT NULL,
LASTLOGINDATE	date	DEFAULT NULL,
LASTNAME	varchar(50)	DEFAULT NULL,
LOGINCOUNT	integer	DEFAULT NULL,
MIGRATION_DATE	date	DEFAULT NULL,
MINPAYOUT	integer	DEFAULT NULL,
MOBILE	varchar(50)	DEFAULT NULL,
NOPAYMENTFEES	integer	DEFAULT NULL,
OCCUPATION	varchar(50)	DEFAULT NULL,
PAGETOPMENUITEMS	varchar(50)	DEFAULT NULL,
PASSWORD	varchar(50)	DEFAULT NULL,
PAYMENTPROGRAM	varchar(50)	DEFAULT NULL,
PAYMENTSTAMP	integer	DEFAULT NULL,
PERCENTTYPECODE	integer	DEFAULT NULL,
PHONE	integer	DEFAULT NULL,
PLAYERNAMESINSTATS	integer	DEFAULT NULL,
PPFIRSTDEPOSIT	integer	DEFAULT NULL,
PPREVENUE	varchar(50)	DEFAULT NULL,
PRIMARYPAYMENTMETHODCODE	integer	DEFAULT NULL,
PROFILEID	varchar(50)	DEFAULT NULL,
REFERERURL	varchar(50)	DEFAULT NULL,
REMOTECREATE	integer	DEFAULT NULL,
REVENUECALCTYPE	varchar(50)	DEFAULT NULL,
RISKPROFILE	integer	DEFAULT NULL,
SALESMAN	integer	DEFAULT NULL,
SALESMANCODE	varchar(50)	DEFAULT NULL,
SALESMANCOEFF	varchar(50)	DEFAULT NULL,
SHOWFIELDS	varchar(500)	DEFAULT NULL,
SHOWGETTINGSTARTED	integer	DEFAULT NULL,
SHOWINSTATS	integer	DEFAULT NULL,
SIGNUPDATE	datetime	DEFAULT NULL,
STATE	varchar(50)	DEFAULT NULL,
UNCHECKED	integer	DEFAULT NULL,
UNSUBSCRIBEDATE	date	DEFAULT NULL,
USERNAME	varchar(50)	DEFAULT NULL,
WANTMAIL	integer	DEFAULT NULL,
WEBSITE	varchar(50)	DEFAULT NULL,
ZIP	integer	DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\CURL_Advertisers.csv'
into table romaniaStg.Advertisers
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';