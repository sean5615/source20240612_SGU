<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01m1.jsp
Author			: Maggie
Description		: SGU123R_�ץX�s����[�l�k�W�U���- ��ܭ���
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/printpageinit.jsp"%>
<%@ include file="sgu123r_01m1.jsp"%>

<%
try
{
	/** �_�l Log */
	logger		=	new MyLogger(request.getRequestURI().toString() + "(PRINT_MODE)");
	logger.iniUserInfo(Log4jInit.getIP(request));
	
	/** �_�l DBManager Container */
	dbManager	=	new DBManager(logger);
	
	/** �B�z�C�L */
	doPrint(out, dbManager, requestMap, session);
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
		com.nou.aut.AUTLOG	autlog	=	new com.nou.aut.AUTLOG(dbManager);
		autlog.setUSER_ID((String)session.getAttribute("USER_ID"));
		autlog.setPROG_CODE("sgu123r");
		autlog.setUPD_MK("5");
		autlog.setIP_ADDR(Log4jInit.getIP(request));
		autlog.execute();
		
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
		logger.append("��������ɶ��G" + String.valueOf(endTime - startTime) + " ms");
		logger.log();
	}
	
	requestMap	=	null;
	logger		=	null;
}
%>