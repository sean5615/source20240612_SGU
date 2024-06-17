<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 主要頁面
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%
session.setAttribute("SGU060M_01_SELECT", "SGU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='SMS' AND CODE != '3' ORDER BY CODE");
session.setAttribute("SGU060M_02_SELECT", "SGU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='NATIONCODE' ORDER BY CODE");
session.setAttribute("SGU060M_03_SELECT", "SGU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='NATIONCODE' ORDER BY CODE");
session.setAttribute("SGU060M_05_BLUR"  , "SGU#SELECT STUT003.STNO,STUT002.NAME FROM STUT003 JOIN STUT002 ON STUT003.IDNO = STUT002.IDNO AND STUT003.BIRTHDATE = STUT002.BIRTHDATE WHERE STUT003.STNO = '[STNO]'");
session.setAttribute("SGU060M_09_SELECT", "SGU#SELECT '' as SELECT_VALUE, '' as SELECT_TEXT, '0' AS ORDER_SELECT FROM DUAL UNION SELECT TO_CHAR(CENTER_CODE) AS SELECT_VALUE, TO_CHAR(CENTER_ABBRNAME) AS SELECT_TEXT, TO_CHAR(CENTER_CODE) AS ORDER_SELECT FROM SYST002 WHERE CENTER_CODE <> '00' ORDER BY ORDER_SELECT");

%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/titleSetup.jsp"%>
<%@ page import="com.nou.sol.signup.tool.Permision"%>
<%@ page import="java.util.Hashtable"%>
<script>
    <%
    /** 傳遞 Key 參數 */
    String    keyParam    =    com.acer.util.Utility.checkNull(request.getParameter("keyParam"), "");
	String keyParam2 = keyParam;
	DBManager dbManager = null;
	MyLogger logger	= new MyLogger("SGU060M");
	String ayear = null;
	String sms = null;
	try 
	{
		dbManager = new DBManager(logger);
		com.nou.sys.SYSGETSMSDATA sysgetsmsdata = new com.nou.sys.SYSGETSMSDATA(dbManager);
		sysgetsmsdata.setSYS_DATE(DateUtil.getNowDate());
		sysgetsmsdata.setSMS_TYPE("1");
		int rtn = sysgetsmsdata.execute();
	
		ayear = sysgetsmsdata.getAYEAR();
		sms = sysgetsmsdata.getSMS();
		
		// 取得登入者的身分--如為中心則僅顯示該中心
		Hashtable autHt = Permision.processAllPermision(session);
		if(Utility.nullToSpace(autHt.get("DEP_TYPE")).equals("43"))
			session.setAttribute("SGU060M_09_SELECT", "SGU#SELECT CENTER_CODE AS SELECT_VALUE, CENTER_ABBRNAME AS SELECT_TEXT FROM SYST002 WHERE CENTER_CODE <> '00' AND CENTER_CODE IN ('"+Utility.nullToSpace(autHt.get("DEP_CODES")).replaceAll(",","','")+"') ORDER BY SELECT_VALUE");
	} 
	finally 
	{
		if (dbManager != null) dbManager.close();
	}
	
	/** 傳遞 Key 參數 */
	if(keyParam2.equals(""))
		keyParam2 = "?AYEAR=" + ayear + "&SMS=" + sms;
	else
		keyParam2 += "&AYEAR=" + ayear + "&SMS=" + sms;
    %>
    top.viewFrame.location.href    =    'about:blank';
    top.hideView();
    /** 導向第一個處理的頁面 */
    top.mainFrame.location.href    =    'sgu060m_01v1.jsp<%=keyParam%>';
    /** 導向編輯頁面 */
    top.viewFrame.location.href    =    'sgu060m_02v1.jsp<%=keyParam%>';
</script>