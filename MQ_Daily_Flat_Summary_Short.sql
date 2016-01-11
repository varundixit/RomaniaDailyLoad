##output to be saved as CRM_Report
use romaniafl;
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

, ed.ExtremeDeposit
, dw.LastDepositAmount
, Case when dw.LastDepositAmount > ed.ExtremeDeposit then 'ExtremeDepositor' else 'NA' end as IMSDepPlayerOutlier

, (LastCashBetAmt+LastBonusBetAmt-LastCashWinAmt-LastBonusWinAmt) as LastGrossProfit
, eb.ExtremeWin
, eb.ExtremeLoss
, Case when LastCashBetAmt+LastBonusBetAmt-LastCashWinAmt-LastBonusWinAmt < eb.ExtremeWin or 
			LastCashBetAmt+LastBonusBetAmt-LastCashWinAmt-LastBonusWinAmt > eb.ExtremeLoss then 'HighWinLoss' else 'NA' end EGBetPlayerOutlier

, spp.PreferredSport
, spp.PreferredLeague
, spp.PreferredTeam

, egpp.CategoryPref
, egpp.MarketPref

, spch.Channel SportsChannelPreference
, egch.Channel EGChannelPreference

, pv.playerValue

, '' BonusSB
, '' BonusEG

, apd.LTSportsAPD
, apd.LTEGamingAPD
, apd.LTSystemAPD

#quality variables
, egp.LTEGPoint
, LTSpPoint
, SGLAvgOdds
, SGLSTDOdds
, SGLCovOdds
, CMBAvgOdds
, CMBSTDOdds
, CMBCovOdds
, SGLTotalWinninStake
, SGLTotalStake
, SGLTotalReturn
, SGLTotalWinningBetCount
, SGLTotalBetCount
, CMBTotalWinninStake
, CMBTotalStake
, CMBTotalReturn
, CMBTotalWinningBetCount
, CMBTotalBetCount
, SGLWinningRatioBetCounts
, SGLWinningRatioStake
, CMBWinningRatioBetCounts
, CMBWinningRatioStake

, ch.AdvChannel
from
romaniafl.stg_dim_player as p
left outer join romaniafl.Dim_Player_Channel ch on p.playerId = ch.playerid
left outer join romaniafl.user_dep_with_first_last as dw on p.PlayerId = dw.PlayerId
left outer join romaniafl.sp_gv_player_first_last as gv on p.PlayerId = gv.PlayerId
left outer join romaniafl.sp_cv_player_first_last_totals as cv on p.PlayerId = cv.PlayerId
left outer join romaniafl.eg_player_first_last_totals as eg on p.PlayerId = eg.PlayerId
left outer join romaniafl.player_login_first_last as L on p.PlayerId = L.PlayerId
left outer join romaniafl.cashier_extreme_deposits as ed on p.PlayerID = ed.PlayerID
left outer join romaniafl.eg_player_extreme_bets as eb on p.PlayerID = eb.PlayerID

left outer join romaniafl.SportsPreferedProduct as spp on p.PlayerID = spp.PlayerId
left outer join romaniafl.EGPreferedProduct as egpp on p.PlayerID = egpp.PlayerId
left outer join romaniafl.stg_sports_channel_pref as spch on p.PlayerID = spch.playerid 
left outer join romaniafl.stg_eg_channel_pref as egch on p.PlayerID = egch.playerid 
left outer join romaniafl.PlayerValue as pv on p.PlayerId = pv.PlayerID 
left outer join romaniafl.f_player_lifetime_apd apd on p.playerId = apd.playerId
left outer join romaniafl.sp_cv_player_volatility as vo on p.PLayerId = vo.playerId
left outer join romaniafl.eg_LT_player_points as egp on p.PlayerId = egp.PlayerId;
