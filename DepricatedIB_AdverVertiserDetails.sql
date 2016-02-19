##date to be changed 2016-02-08
##file to be saved as DayLevelSummary.csv
##################################################### REPORT DATA ######################################################

select 
  ch.AdvCode
, ch.AdvUsername
, ch.AdvEmail
, ch.AdvChannel	
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
, ((CashView.SPCCStakeAmt - CashView.SPCCWinAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))) as GrossWinAmt
, (((CashView.SPCCStakeAmt - CashView.SPCCWinAmt)*0.84) + ((CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))*0.84)) as NetGrossWinAmt
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
, (CashView.SPCCStakeAmt - CashView.SPCCWinAmt) as SPGrossWinAmt
, ((CashView.SPCCStakeAmt - CashView.SPCCWinAmt)*0.84) as SPNetGrossWinAmt
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
, (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt)) as EGGrossWinAmt
, ((CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))*0.84) as EGNetGrossWinAmt
, GameView.SystemAPD
, GameView.SportsAPD
, GameView.EGamingAPD
, Cumulative.CumulativeSystemUAP
, Cumulative.CumulativeSportsUAP
, Cumulative.CumulativeEGamingUAP
, Balance.TotalBalance
, Balance.TotalBonusBalance
, TokenPL.BonusWinnings
from 
(
	select 
	coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	from romaniafl.dim_player_channel
    group by 1,2,3,4
) as ch
left outer join 
(
	select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,count(case when GlobalFirstDepositDate is not null then PlayerId end) as FirstTimeDepositors
	from romaniafl.Dim_Player_Channel as p 
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08' 
	group by 1,2,3,4
) as FTD on ch.AdvCode = FTD.AdvCode and ch.AdvUsername = ftd.AdvUsername and ch.AdvEmail = ftd.AdvEmail and ch.AdvChannel = ftd.AdvChannel
left outer join 
(
	select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,count(case when SignupDate is not null then PlayerId end) as UniqueSignUps
	from romaniafl.Dim_Player_Channel as p 
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as SignUp on ch.AdvCode = SignUp.AdvCode and ch.AdvUsername = SignUp.AdvUsername and ch.AdvEmail = SignUp.AdvEmail and ch.AdvChannel = SignUp.AdvChannel
left outer join 
(
	 select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,SUM(dcs.TotalDepAttemptAmt) as TotalDepAttemptAmt
	,SUM(dcs.TotalDepAttemptCnt) as TotalDepAttemptCnt
	,SUM(dcs.TotalDepDeclineAmt) as TotalDepDeclineAmt
	,SUM(dcs.TotalDepDeclineCnt) as TotalDepDeclineCnt
	,SUM(dcs.TotalDepApproveAmt) as TotalDepApproveAmt
	,SUM(dcs.TotalDepApproveCnt) as TotalDepApproveCnt
	,COUNT(distinct case when dcs.TotalDepAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttemptDepositors
	,COUNT(distinct case when dcs.TotalDepDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedDepositors
	,COUNT(distinct case when dcs.TotalDepApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedDepositors
	,SUM(dcs.TotalWithdAttemptAmt) as TotalWithdAttemptAmt
	,SUM(dcs.TotalWithdAttemptCnt) as TotalWithdAttemptCnt
	,SUM(dcs.TotalWithdDeclineAmt) as TotalWithdDeclineAmt
	,SUM(dcs.TotalWithdDeclineCnt) as TotalWithdDeclineCnt
	,SUM(dcs.TotalWithdApproveAmt) as TotalWithdApproveAmt
	,SUM(dcs.TotalWithdApproveCnt) as TotalWithdApproveCnt
	,COUNT(distinct case when dcs.TotalWithdAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttempWithdrawers
	,COUNT(distinct case when dcs.TotalWithdDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedWithdrawers
	,COUNT(distinct case when dcs.TotalWithdApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedWithdrawers
	from romaniamain.sd_daily_cashier_summary AS dcs
	join romaniafl.Dim_Player_Channel as p ON dcs.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as Cashier on ch.AdvCode = Cashier.AdvCode and ch.AdvUsername = Cashier.AdvUsername and ch.AdvEmail = Cashier.AdvEmail and ch.AdvChannel = Cashier.AdvChannel
left outer join 
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as SystemAPD
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as EGamingAPD
	FROM 
	romaniamain.sd_gv_daily_player_summary as dps
	join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as GameView on ch.AdvCode = GameView.AdvCode and ch.AdvUsername = GameView.AdvUsername and ch.AdvEmail = GameView.AdvEmail and ch.AdvChannel = GameView.AdvChannel
left outer join
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,SUM(dps.SPTotalStakeAmt+dps.EGBet) as TotalStakeAmt
	,SUM(dps.SPCashStakeAmt+dps.EGCashBet) as TotalCashStakeAmt
	,SUM(dps.SPBonusStakeAmt+dps.EGBonusBet) as TotalBonusStakeAmt
	,SUM(dps.SPTotalReturn+dps.EGWin) as TotalReturnAmt
	,SUM(dps.SPCashReturn+dps.EGCashWin) as TotalCashReturnAmt
	,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as SPCCStakeAmt
	,SUM(dps.SPCashReturn+dps.SPCashOutWin) as SPCCWinAmt
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
	,SUM(dps.EGJackpotBet - dps.EGJackpotWin) as EGJackpotContributionAmt
	FROM romaniamain.sd_cv_daily_player_summary as dps
	join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as CashView on ch.AdvCode = CashView.AdvCode and ch.AdvUsername = CashView.AdvUsername and ch.AdvEmail = CashView.AdvEmail and ch.AdvChannel = CashView.AdvChannel
left outer join
(
	SELECT 
    coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as CumulativeSystemUAP
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as CumulativeSportsUAP
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as CumulativeEGamingUAP
	FROM romaniamain.sd_gv_daily_player_summary as dps 
	left outer join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as Cumulative on ch.AdvCode = Cumulative.AdvCode and ch.AdvUsername = Cumulative.AdvUsername and ch.AdvEmail = Cumulative.AdvEmail and ch.AdvChannel = Cumulative.AdvChannel
left outer join
(
	select 
	coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,SUM(coalesce(Balance,0)) as TotalBalance
	,SUM(coalesce(BonusBalance,0)) as TotalBonusBalance
	,count(distinct bl.PlayerId) PlayerCnt
	from romaniamain.FD_DAILY_PLAYER_BALANCE bl
	left outer join romaniafl.Dim_Player_Channel as p on bl.PlayerId = p.PlayerId
	where bl.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4 
) as Balance on ch.AdvCode = Balance.AdvCode and ch.AdvUsername = Balance.AdvUsername and ch.AdvEmail = Balance.AdvEmail and ch.AdvChannel = Balance.AdvChannel
left outer join
(
	SELECT 
	coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel	
	,SUM(BonusWinnings) BonusWinnings 
	FROM romaniamain.customer_pnl pl
	left outer join romaniafl.Dim_Player_Channel as p on pl.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'
	where p.SignupDate >= '2015-11-26' and date(p.SignupDate) <= '2016-02-08'
	group by 1,2,3,4
) as TokenPL on ch.AdvCode = TokenPL.AdvCode and ch.AdvUsername = TokenPL.AdvUsername and ch.AdvEmail = TokenPL.AdvEmail and ch.AdvChannel = TokenPL.AdvChannel
order by 1,2,3,4 ;