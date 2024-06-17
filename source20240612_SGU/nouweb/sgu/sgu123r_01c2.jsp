<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01c2.jsp
Author			: Maggie
Description		: SGU123R_匯出新住民暨子女名冊資料- 顯示頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page errorPage="/utility/ajaxerrorpage.jsp" pageEncoding="MS950"%>
<%@page import="com.nou.aut.*"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/controlpageinit.jsp"%>
<%@ include file="sgu123r_01m1.jsp"%>

<%
int	logFlag	=	-1;
try
{
	/** 起始 Log */
	logger		=	new MyLogger(request.getRequestURI().toString() + "(" + control_type + ")");
	logger.iniUserInfo(Log4jInit.getIP(request));

	/** 起始 DBManager Container */
	dbManager	=	new DBManager(logger);

	if (control_type.equals("EXPORT_ALL_MODE"))
	{
		logFlag	=	-2; 
		doExport(response,out, dbManager, request, session,requestMap);
	}
}
catch(Exception ex)
{
	logErrMessage(ex, logger);
	throw ex;
}
finally
{
	try
	{
		/** 異動註記 */
		if (logFlag != -2)
		{
			com.nou.aut.AUTLOG	autlog	=	new com.nou.aut.AUTLOG(dbManager);
			autlog.setUSER_ID((String)session.getAttribute("USER_ID"));
			autlog.setPROG_CODE("sgu123r");
			autlog.setUPD_MK(String.valueOf(logFlag));
			autlog.setIP_ADDR(Log4jInit.getIP(request));
			autlog.execute();
		}
		
		dbManager.close();
	}
	catch(Exception ex)
	{
		logErrMessage(ex, logger);
		throw ex;
	}

	if (logger != null)
	{
		long	endTime	=	System.currentTimeMillis();
		logger.append("全部執行時間：" + String.valueOf(endTime - startTime) + " ms");
		logger.log();
	}

	requestMap	=	null;
	logger		=	null;
}
%>