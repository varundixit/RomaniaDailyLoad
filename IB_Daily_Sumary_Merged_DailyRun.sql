##date to be changed 2016-02-16
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
, ((TokenPL.BonusWinnings - WinRed.WinRedeemed) + CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt + coalesce(EGBonus.BonusRedeemed,0)) as TotalBonusCost
, ((((CashView.SPCCStakeAmt - CashView.SPCCWinAmt)*0.84) - (TokenPL.BonusWinnings - WinRed.WinRedeemed)) + (((CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))*0.84) - ((CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt + coalesce(EGBonus.BonusRedeemed,0))))) as NetGamingRevenue
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
, (TokenPL.BonusWinnings - WinRed.WinRedeemed) as SPBonusCost
, (((CashView.SPCCStakeAmt - CashView.SPCCWinAmt)*0.84) - (TokenPL.BonusWinnings - WinRed.WinRedeemed)) as SPNetGamingRevenue
  ### as Winnings Redeemed is negative, substracting will add the values (which is intended)
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
, (CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt + coalesce(EGBonus.BonusRedeemed,0)) as EGamingBonusCost
, (((CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotContributionAmt))*0.84) - ((CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt + coalesce(EGBonus.BonusRedeemed,0)))) as EGNetGamingRevenue
, GameView.SystemAPD
, GameView.SportsAPD
, GameView.EGamingAPD
, Cumulative.CumulativeSystemUAP
, Cumulative.CumulativeSportsUAP
, Cumulative.CumulativeEGamingUAP
, Balance.TotalBalance
, Balance.TotalBonusBalance
, TokenPL.BonusWinnings
, EGBonus.BonusRedeemed
, WinRed.WinRedeemed SPWinningsRedeemed
/*, Txn.dist_depositors
, Txn.depositCnt
, Txn.depositAmt
, Txn.dist_withdrawers
, Txn.WithdrawCnt
, Txn.WithdrawAmt*/
from 
romaniamain.dim_calendar as cal
left outer join 
(
	select cal.calendar_date as SummaryDate,
	count(distinct PlayerId) as FirstTimeDepositors
	from romaniamain.dim_calendar as cal
	left outer join romaniamain.dim_player as p on cal.calendar_date = date(p.GlobalFirstDepositDate)
	where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-16'
	group by 1
) as FTD on cal.calendar_date = FTD.SummaryDate
left outer join 
(
	select cal.calendar_date as SummaryDate,
	count(distinct PlayerId) as UniqueSignUps
	from romaniamain.dim_calendar as cal
	left outer join romaniamain.dim_player as p on cal.calendar_date = date(p.SignupDate)
	where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-16'
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
	join romaniamain.dim_player as p ON dcs.PlayerId = p.PlayerId
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
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
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
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
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
	left outer join romaniamain.sd_gv_daily_player_summary as dps on dps.SummaryDate <= cal.calendar_date and cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-16' and dps.SummaryDate >= '2015-11-26'
	left outer join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
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
left outer join
(
	SELECT date(SettledDate) SummaryDate, sum(BonusWinnings) BonusWinnings FROM romaniamain.customer_pnl pl
	left outer join romaniafl.Dim_Player_Channel as p on pl.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'	
	where  date(SettledDate) <= '2016-02-16'
	group by date(SettledDate)
) as TokenPL on cal.calendar_date = TokenPL.SummaryDate
left outer join
(
	SELECT date(Awarded_Date) SummaryDate, sum(redeemed) BonusRedeemed FROM romaniastg.Bonus_Details
	where  date(Awarded_Date) <= '2016-02-16'
	group by date(Awarded_Date)
) as EGBonus on cal.calendar_date = EGBonus.SummaryDate
/*left outer join
(
	select TxnDate SummaryDate,
	count(distinct case Type when 'deposit' then PlayerId end) dist_depositors,
	count(case Type when 'deposit' then PlayerId end) depositCnt,
	sum(case Type when 'deposit' then Amount end) depositAmt ,
	count(distinct case Type when 'withdraw' then PlayerId end) dist_withdrawers,
	count(case Type when 'withdraw' then PlayerId end) WithdrawCnt,
	sum(case Type when 'withdraw' then Amount end) WithdrawAmt 
	from romaniamain.daily_player_transactions
	where Status='approved'
	and date(TxnDate) <= '2016-02-16'
	group by TxnDate 
) as Txn on cal.calendar_date = Txn.SummaryDate*/
left outer join
(
	select date(pl.SummaryDate) SummaryDate, coalesce(WinningsRedeemed/xc.ExchangeRate,0) WinRedeemed 
	from romaniamain.pnl_summary pl 
	left outer join romaniamain.dd_exchange_rate xc on date(pl.SummaryDate) = date(xc.SummaryDate) and xc.CurrencyCode='RON'
	where date(pl.SummaryDate) <= '2016-02-16'
	and pl.AsOf = '2016-02-16'
) as WinRed on cal.calendar_date = WinRed.SummaryDate
where 
cal.calendar_date >= '2015-11-26' and cal.calendar_date <= '2016-02-16'
order by 1 ;