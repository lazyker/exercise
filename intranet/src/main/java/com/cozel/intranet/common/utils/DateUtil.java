package com.cozel.intranet.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang3.time.FastDateFormat;

public class DateUtil {

	private static final int MS 	= 1000;
	
	public static final int SUN	= 1;
	public static final int MON	= 2;
	public static final int TUE = 3;
	public static final int WED	= 4;
	public static final int THU	= 5;
	public static final int FRI	= 6;
	public static final int SAT	= 7;
	
	public static final int YEAR = 1;
	public static final int MONTH = 2;
	public static final int WEEK = 3;
	public static final int DAY = 4;
		  
    public static String getFirstOfMonth(String date){
		return date.substring(0, 7) + "-01";
	}
    
    public static String getToDay(Date date) throws Exception {
    	FastDateFormat fdf = FastDateFormat.getInstance("yyyyMMdd");
    	return fdf.format(date);
    }
    
    public static String getYear(Date date) throws Exception {
    	FastDateFormat fdf = FastDateFormat.getInstance("yyyy");
    	return fdf.format(date);
    }
    
    public static String getMonth(Date date) throws Exception {
    	FastDateFormat fdf = FastDateFormat.getInstance("MM");
    	return fdf.format(date);
    }
    
    public static String getDay(Date date) throws Exception {
    	FastDateFormat fdf = FastDateFormat.getInstance("dd");
    	return fdf.format(date);
    }
    
    public static String getCurrentTime(Date date, String format) throws Exception {
    	FastDateFormat fdf = FastDateFormat.getInstance(format);
    	return fdf.format(date);
    }
    
    public static String getLastOfMonth(String dateStr) throws ParseException{
		Calendar base = Calendar.getInstance();
		base.setTime(parseDate(dateStr, "yyyy-MM-dd"));
		int maxday = base.getActualMaximum(Calendar.DATE);

		dateStr = dateStr.substring(0, 7) + "-" + maxday;
		return dateStr;
	}
    
    public static String parseString(Date date, String format){
    	if(date == null)
    		return "";
    	FastDateFormat fdf 
			= FastDateFormat.getInstance(format);
    	return fdf.format(date);
    }
    
    public static Date parseDate(String date, String format) throws ParseException{
    	if(date == null || "".equals(date))
    		return null;
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.parse(date);
    }
    
    public static int diffDays(Date date1, Date date2) {
        return (int) (Math.abs(date1.getTime() - date2.getTime()) / MS);
    }
    
    public static Date addTimes(Date date, int times, int base) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(base,times);

		return cal.getTime();
	}
    
    public static Date addHours(Date date, int hours) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR_OF_DAY,hours);

		return cal.getTime();
	}
    
    public static Date addMinutes(Date date, int minutes) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MINUTE, minutes);

		return cal.getTime();
	}
    
    public static Date addSecond(Date date, int second) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.SECOND, second);

		return cal.getTime();
	}    
    
    public static Date addDay(Date date, int day) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, day);

		return cal.getTime();
	}
    
    public static Date addMonth(Date date, int month) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, month);

		return cal.getTime();
	}
    
    public static Date addYear(Date date, int year) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.YEAR, year);

		return cal.getTime();
	}
    
    public static boolean equals(Date date1, Date date2, String format){
		String currentTime1 = parseString(date1, format);
		String currentTime2 = parseString(date2, format);
		return currentTime1.equals(currentTime2);
    }
    
    public static int getDayOfWeek(Date date){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        return dayOfWeek;
    }
    
    
    /**
     * FullCalendar의 EndDate의 경우 -1을 해야 정상 날짜가 된다.
     * @param date
     * @return
     * @throws ParseException
     */
    public static String getCalEndYmd(String date) throws ParseException {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date endDate = sdf.parse(date);
    	
		Calendar cal = Calendar.getInstance();
		cal.setTime(endDate);
		cal.add(Calendar.DATE, -1);
		
		String endYmd= sdf.format(cal.getTime());
    	
    	return endYmd;
    }
    
    
    /**
     * 현재 시간 기준으로 시간을 인자값으로 계산
     * @return
     */
    public static String addMinuteStep(String option, int minuteStep) {
    	Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		if("startTm".equals(option)) {
			cal.add(Calendar.HOUR, +1);
		}else{
			cal.add(Calendar.HOUR, +2);
		}
		
		FastDateFormat sdf = FastDateFormat.getInstance("HH:mm", Locale.getDefault());
		String time = sdf.format(cal.getTime());
		String times[] = time.split(":");
		
		int hh = Integer.parseInt(times[0]);
		double mm = Integer.parseInt(times[1]);
		
		String Mn = "";
		int  endMm = (int) Math.ceil(mm / minuteStep) * minuteStep;
		if(endMm == 60) 	Mn = "00";	else	Mn = String.valueOf(endMm);
		
		StringBuilder sb = new StringBuilder(hh + Mn);
		return sb.toString();
    }
    
    /**
     * 두 날짜의 차이를 일수로 구하기
     * @param Date startDate 시작날짜
     * @param Date endDate 종료날짜
     * @param int rpetcyc 반복일수
     * @param String rpetType 반복타입
     * @return int days
     */
    public static int DateDiff(Date startDate, Date endDate, int rpetcyc, String rpetType) throws ParseException {
    	Calendar cal = Calendar.getInstance( );
		cal.setTime (startDate);
		long d1 = cal.getTime().getTime(); //초로 변환
		 
		Calendar cal2 = Calendar.getInstance( );
		cal2.setTime(endDate);
		long d2 = cal2.getTime().getTime();
		int days = 0;
		
		if ("W".equals(rpetType))	//매주
		{
			rpetcyc = rpetcyc * 7;
		}
		else if ("M".equals(rpetType))	//매월
		{
			rpetcyc = rpetcyc * 30;
		}
		else if ("Y".equals(rpetType))		//매년
		{
			rpetcyc = rpetcyc * 365;
		}
		
		if (rpetcyc == 0) {
			days =(int)((d2-d1)/(1000*60*60*24));
		} else {
			days =(int)((d2-d1)/(1000*60*60*24)) / rpetcyc; 
		}
		 
		return days;
    }
    
}
