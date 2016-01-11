#table ReCreate

#IB_Dim_Player_Load.sql
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

########Exchange Rates
drop table romaniastg.STG_Exchange_Rate;
CREATE TABLE romaniastg.STG_Exchange_Rate (
  EffectiveTimestamp datetime DEFAULT NULL,
  LastUpdTimestamp datetime DEFAULT NULL,
  CurrencyCode varchar(20) DEFAULT NULL,
  XchangeRate double(24,18) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

