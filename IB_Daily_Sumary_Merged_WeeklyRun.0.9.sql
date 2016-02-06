##date to be changed 2016-02-04
##file to be saved as DayLevelSummary.csv
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
romaniamain.dim_calendar as cal
left outer join 
(
	select cal.calendar_date as SummaryDate,
	count(distinct PlayerId) as FirstTimeDepositors
	from romaniamain.dim_calendar as cal
	left outer join romaniafl.Dim_Player_Channel as p on cal.calendar_date = date(p.GlobalFirstDepositDate)
	where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-04'
	group by 1
) as FTD on cal.calendar_date = FTD.SummaryDate
left outer join 
(
	select cal.calendar_date as SummaryDate,
	count(distinct PlayerId) as UniqueSignUps
	from romaniamain.dim_calendar as cal
	left outer join romaniafl.Dim_Player_Channel as p on cal.calendar_date = date(p.SignupDate)
	where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-04'
	group by 1
) as SignUp on cal.calendar_date = SignUp.SummaryDate
left outer join 
(
	select dcs.SummaryDate,
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
	from romaniamain.sd_daily_cashier_summary AS dcs
	join romaniafl.Dim_Player_Channel as p ON dcs.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by SummaryDate
) as Cashier on cal.calendar_date = Cashier.SummaryDate
left outer join 
(
	SELECT dps.SummaryDate
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as SystemAPD
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as EGamingAPD
	FROM 
	romaniamain.sd_gv_daily_player_summary as dps
	join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by SummaryDate
) as GameView  on cal.calendar_date = GameView.SummaryDate
left outer join
(
	SELECT dps.SummaryDate
	,SUM(dps.SPTotalStakeAmt+dps.EGBet) as TotalStakeAmt
	,SUM(dps.SPCashStakeAmt+dps.EGCashBet) as TotalCashStakeAmt
	,SUM(dps.SPBonusStakeAmt+dps.EGBonusBet) as TotalBonusStakeAmt
	,SUM(dps.SPTotalReturn+dps.EGWin) as TotalReturnAmt
	,SUM(dps.SPCashReturn+dps.EGCashWin) as TotalCashReturnAmt
	,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as SPCCStakeAmt
	,SUM(dps.SPCashReturn+dps.SPCashOutWin) as SPCCWinAmt
	,Sum(dps.SPTotalStakeAmt) as SPTotalStakeAmt
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
	FROM 
	romaniamain.sd_cv_daily_player_summary as dps
	join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by SummaryDate
) as CashView  on cal.calendar_date = CashView.SummaryDate
left outer join
(
	SELECT cal.calendar_date as SummaryDate
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as CumulativeSystemUAP
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as CumulativeSportsUAP
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as CumulativeEGamingUAP
	FROM 
	romaniamain.dim_calendar as cal
	left outer join romaniamain.sd_gv_daily_player_summary as dps on dps.SummaryDate <= cal.calendar_date and cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-04' and dps.SummaryDate >= '2015-11-26'
	left outer join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by cal.calendar_date
) as Cumulative on cal.calendar_date = Cumulative.SummaryDate
left outer join
(
	select SummaryDate, 
	SUM(coalesce(Balance,0)) as TotalBalance, 
	SUM(coalesce(BonusBalance,0)) as TotalBonusBalance,  
	count(distinct PlayerId) 
	from romaniamain.FD_DAILY_PLAYER_BALANCE
	where SignupDate >= '2015-11-26'
	group by SummaryDate
) as Balance on cal.calendar_date = Balance.SummaryDate
where 
cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-04'
order by 1 ;