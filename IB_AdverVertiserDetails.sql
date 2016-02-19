select 
 ch.calendar_date as FTD
, coalesce(ch.AdvCode,'NA') AdvCode
, coalesce(ch.AdvUsername,'NA') AdvUsername
, coalesce(ch.AdvEmail,'NA') AdvEmail
, ch.AdvChannel
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
, ((CashView.SPCCStakeAmt - CashView.SPCCWinAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))) as TotalGrossWinAmt
, (((CashView.SPCCStakeAmt - CashView.SPCCWinAmt)*0.84) + ((CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))*0.84)) as TotalNetGrossWinAmt
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
	cal1.calendar_date,AdvCode,AdvUsername,AdvEmail,AdvChannel 
	from romaniamain.dim_calendar cal1
	cross join (select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel from romaniafl.dim_player_channel group by 1,2,3,4) ch
	where cal1.calendar_date >= '2015-11-26' 
) as ch
left outer join 
(
	select 
	coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
	,count(distinct PlayerId) as FirstTimeDepositors
	from romaniamain.dim_calendar as cal
	left outer join romaniafl.Dim_Player_Channel as p on cal.calendar_date = date(coalesce(p.GlobalFirstDepositDate,'3000-12-31'))
	where cal.calendar_date >= '2015-11-26' 
	group by 1,2,3,4,5
) as FTD on ch.calendar_date = FTD.ftd and ch.AdvCode = FTD.AdvCode and ch.AdvUsername = ftd.AdvUsername and ch.AdvEmail = ftd.AdvEmail and ch.AdvChannel = ftd.AdvChannel
left outer join 
(
	select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd	
	,count(distinct PlayerId) as UniqueSignUps
	from romaniamain.dim_calendar as cal
	left outer join romaniafl.Dim_Player_Channel as p on cal.calendar_date = date(p.SignupDate)
	where cal.calendar_date >= '2015-11-26' 
	group by 1,2,3,4,5
) as SignUp on ch.calendar_date = SignUp.ftd and ch.AdvCode = SignUp.AdvCode and ch.AdvUsername = SignUp.AdvUsername and ch.AdvEmail = SignUp.AdvEmail and ch.AdvChannel = SignUp.AdvChannel
left outer join 
(
	select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
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
	where p.SignupDate >= '2015-11-26'
	group by 1,2,3,4,5
) as Cashier on ch.calendar_date = Cashier.ftd and ch.AdvCode = Cashier.AdvCode and ch.AdvUsername = Cashier.AdvUsername and ch.AdvEmail = Cashier.AdvEmail and ch.AdvChannel = Cashier.AdvChannel
left outer join 
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as SystemAPD
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as EGamingAPD
	FROM 
	romaniamain.sd_gv_daily_player_summary as dps
	join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by 1,2,3,4,5
) as GameView on ch.calendar_date = GameView.ftd and ch.AdvCode = GameView.AdvCode and ch.AdvUsername = GameView.AdvUsername and ch.AdvEmail = GameView.AdvEmail and ch.AdvChannel = GameView.AdvChannel
left outer join
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
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
	group by 1,2,3,4,5
) as CashView on ch.calendar_date = CashView.ftd and ch.AdvCode = CashView.AdvCode and ch.AdvUsername = CashView.AdvUsername and ch.AdvEmail = CashView.AdvEmail and ch.AdvChannel = CashView.AdvChannel
left outer join
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
	,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as CumulativeSystemUAP
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as CumulativeSportsUAP
	,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as CumulativeEGamingUAP
	FROM romaniamain.sd_gv_daily_player_summary as dps 
	left outer join romaniafl.Dim_Player_Channel as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
 and dps.SummaryDate >= '2015-11-26'
	group by 1,2,3,4,5
) as Cumulative on ch.calendar_date = Cumulative.ftd and ch.AdvCode = Cumulative.AdvCode and ch.AdvUsername = Cumulative.AdvUsername and ch.AdvEmail = Cumulative.AdvEmail and ch.AdvChannel = Cumulative.AdvChannel
left outer join
(
	select coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
	,SUM(coalesce(Balance,0)) as TotalBalance
	,SUM(coalesce(BonusBalance,0)) as TotalBonusBalance
	,count(distinct bl.PlayerId) 
	from romaniamain.FD_DAILY_PLAYER_BALANCE bl
	left outer join romaniafl.Dim_Player_Channel as p on bl.PlayerId = p.PlayerId
	where bl.SignupDate >= '2015-11-26'
	group by 1,2,3,4,5
) as Balance on ch.calendar_date = Balance.ftd and ch.AdvCode = Balance.AdvCode and ch.AdvUsername = Balance.AdvUsername and ch.AdvEmail = Balance.AdvEmail and ch.AdvChannel = Balance.AdvChannel
left outer join
(
	SELECT coalesce(AdvCode,'NA') AdvCode,coalesce(AdvUsername,'NA') AdvUsername,coalesce(AdvEmail,'NA') AdvEmail,
 coalesce(AdvChannel,'AFFILIATE') AdvChannel
	,date(coalesce(p.GlobalFirstDepositDate,'3000-12-31')) ftd
	,SUM(BonusWinnings) BonusWinnings 
	FROM romaniamain.customer_pnl pl
	left outer join romaniafl.Dim_Player_Channel as p on pl.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'
	#where date(SettledDate) <= '2016-02-09'
	group by 1,2,3,4,5
) as TokenPL on ch.calendar_date = TokenPL.ftd and ch.AdvCode = TokenPL.AdvCode and ch.AdvUsername = TokenPL.AdvUsername and ch.AdvEmail = TokenPL.AdvEmail and ch.AdvChannel = TokenPL.AdvChannel
where 
ch.calendar_date >= '2015-11-26' and ch.calendar_date <= '2016-02-09'
order by 1,2;
