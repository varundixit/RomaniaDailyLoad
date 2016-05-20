select 
overall.SummaryDate, TotalTurnOver, TotalWin, SportsAPD, PurePlayer, newPlayersCnt,
FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed, SlipCountFixed, AUFixed, PureFixed,
LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive , AULive , PureLive , EventCnt
from 
(
	SELECT date(dps.SummaryDate) SummaryDate
	,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as TotalTurnOver
	,SUM(dps.SPCashReturn+dps.SPCashOutWin) as TotalWin
	FROM romaniamain.sd_cv_daily_player_summary as dps
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'
	and date_format(dps.SummaryDate,'%Y-%m-01') = date_format(current_date ,'%Y-%m-01') 
	group by dps.SummaryDate
) overall
join (
	SELECT 
    date(dgps.SummaryDate) SummaryDate
	, COUNT(distinct case when (dgps.SPStakeAmt) > 0 then dgps.PlayerId end) as SportsAPD
	, count(distinct case dgps.EGBet when 0 then dgps.playerid end) PurePlayer 
	, count(distinct case when flsp = SummaryDate then dgps.playerid end) newPlayersCnt
	FROM romaniamain.sd_gv_daily_player_summary as dgps
	join romaniamain.dim_player as p on dgps.PlayerId = p.PlayerId and p.signupdate >='2015-11-26'
	left outer join ( select playerid,date(LEAST(gfl.SglLvFirstBetTime,gfl.CmbFirstBetTime)) flsp
			from romaniafl.sp_cv_player_first_last_totals gfl group by 1
		) ab on ab.playerid = dgps.PlayerID
	group by date(dgps.SummaryDate)
	) apd on overall.SummaryDate = apd.SummaryDate
join (
	select overall.SummaryDate, FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed,SlipCountFixed,  
		  LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive  
	from 
	(select date(SummaryDate) SummaryDate,
	sum(case when LiveYN = 'N'                   then TotalStake end) TotalBetFixed,
	sum(case when LiveYN = 'N'                   then TotalReturn end) TotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalStake end) SingleTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalReturn end) SingleTotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalStake end) CombiTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalReturn end) CombiTotalWinFixed,
	sum(case when LiveYN = 'Y'                   then TotalStake end) TotalBetLive,
	sum(case when LiveYN = 'Y'                   then TotalReturn end) TotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalStake end) SingleTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalReturn end) SingleTotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalStake end) CombiTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalReturn end) CombiTotalWinLive
	from Romaniastg.DailyPlayerBetSummaries ab
	where date_format(ab.SummaryDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1) as overall
	join (select date(BetDate) SummaryDate,
		count(distinct case when LiveYN ='N' then BetId end) SlipCountFixed, 
		count(distinct case when LiveYN ='Y' then BetId end) SlipCountLive 
		from romaniamain.fd_placed_bets gm 
		where date_format(gm.BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
		group by 1) slp on overall.SummaryDate = slp.SummaryDate
	left outer join (
		select date(SummaryDate) SummaryDate,FixedOpenBets,LiveOpenBets from romaniafl.DayWiseOpenBetSummary 
		where date(SummaryDate) in (
			select maxda from (select date(SummaryDate)  mon,max(SummaryDate) maxda from romaniafl.DayWiseOpenBetSummary group by 1) ab)
		) op on overall.SummaryDate= op.SummaryDate 
) fixliv on overall.SummaryDate = fixliv.SummaryDate
join (
	select date(SummaryDate) SummaryDate,
	count(distinct case when li > 0 then PlayerId end                  ) AULive,
	count(distinct case when EG=0 and fx=0 and li > 0 then PlayerId end) PureLive,
	count(distinct case when fx>0 then PlayerId end                    ) AUFixed,
	count(distinct case when EG=0 and fx>0 and li = 0 then PlayerId end) PureFixed from (
	select date(BetDate) SummaryDate, b.PlayerId,
	sum(case LiveYN when 'Y' then 1 else 0 end) Li,
	sum(case LiveYN when 'N' then 1 else 0 end) Fx,
	sum(EGBet) EG
	from romaniamain.fd_placed_bets b join romaniamain.sd_gv_daily_player_summary gps on b.PlayerId = gps.PlayerId and date(b.BetDate) = gps.SummaryDate
	where date_format(BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1,2) ab
	group by 1
) pl on overall.SummaryDate = pl.SummaryDate
left outer join (
	select date(BetDate) SummaryDate, count(distinct case LiveYN when 'Y' then EventId end) EventCnt
	from romaniamain.fd_placed_bets b
	where date_format(BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1 
) eve on eve.SummaryDate = overall.SummaryDate ;