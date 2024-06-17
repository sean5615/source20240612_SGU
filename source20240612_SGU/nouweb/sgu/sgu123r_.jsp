<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r
Author			: Maggie
Description		: SGU123R_匯出新住民暨子女名冊資料- 顯示頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/titleSetup.jsp"%>
<%@page import="java.util.Vector"%>
<%@ page import="com.nou.sys.SYSGETSMSDATA"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.nou.aut.AUTGETRANGE"%>
<%@page import="com.acer.util.DateUtil"%>
<script>
	<%
	// 預設學年期
		String	keyParam	=	"";
		MyLogger log = new MyLogger("SGU123R");
		DBManager db = new DBManager(log);
		SYSGETSMSDATA sys = new SYSGETSMSDATA(db);
		
		//取得現在的日期,並設定在sys中
		java.util.Calendar cal = java.util.Calendar.getInstance();	
		SimpleDateFormat smipleDate = new SimpleDateFormat("yyyyMMdd");
		String nowDate = smipleDate.format(cal.getTime());
		sys.setSYS_DATE(nowDate);
		sys.setSMS_TYPE("1");  //1.當期 2.前期 3.後期 4.前學年 5.後學年
		
		//在參數中加入學年,學期參數
		int result = sys.execute();
		if(result==1)
		{
			String ayear = sys.getAYEAR();
			String sms = sys.getSMS();
			keyParam		= "?AYEAR="+ayear+"&SMS="+sms;
		}
		
		// 學期
		session.setAttribute("SGU123R_01_SELECT","NOU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='[KIND]' ORDER BY SELECT_VALUE");
	%>
	top.hideView();
	/** 導向第一個處理的頁面 */
	top.mainFrame.location.href	=	'sgu123r_01v1.jsp<%=keyParam%>';
</script>