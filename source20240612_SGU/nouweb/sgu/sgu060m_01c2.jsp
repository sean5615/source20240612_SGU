<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_01c2.jsp
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 控制頁面(JSP)
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page errorPage="/utility/ajaxerrorpage.jsp" pageEncoding="MS950"%>
<%@page import="com.nou.aut.*"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/controlpageinit.jsp"%>
<%@ include file="sgu060m_01m1.jsp"%>

<%
int    logFlag    =    -1;
try
{
    /** 起始 Log */
    logger        =    new MyLogger(request.getRequestURI().toString() + "(" + control_type + ")");
    logger.iniUserInfo(Log4jInit.getIP(request));

    /** 起始 DBManager Container */
    dbManager    =    new DBManager(logger);

    /** 查詢 Grid 資料 */
    if (AUTICFM.securityCheck (session, "QRY") && control_type.equals("QUERY_MODE"))
    {
        logFlag    =    4;
        doQuery(out, dbManager, requestMap, session);
    }
    /** 新增存檔 */
    else if (AUTICFM.securityCheck (session, "ADD") && control_type.equals("ADD_MODE"))
    {
        logFlag    =    1;
        doAdd(out, dbManager, requestMap, session);
    }   
    /** 修改帶出資料 */
    else if (AUTICFM.securityCheck (session, "UPD") && control_type.equals("EDIT_QUERY_MODE"))
    {
        logFlag    =    -2;
        doQueryEdit(out, dbManager, requestMap, session);
    }
    /** 修改存檔 */
    else if (AUTICFM.securityCheck (session, "UPD") && control_type.equals("EDIT_MODE"))
    {
        logFlag    =    2;
        doModify(out, dbManager, requestMap, session);
    }
    /** 刪除資料 */
    else if (AUTICFM.securityCheck (session, "DEL") && control_type.equals("DEL_MODE"))
    {
        logFlag    =    3;
        doDelete(out, dbManager, requestMap, session);
    }
    else if (AUTICFM.securityCheck (session, "RT1") && control_type.equals("DO_SOL_BATCH_ADD_MODE"))
	{
		logFlag    =    4;
		doSolBatchAdd(out, dbManager, requestMap, session);
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
            com.nou.aut.AUTLOG    autlog    =    new com.nou.aut.AUTLOG(dbManager);
            autlog.setUSER_ID((String)session.getAttribute("USER_ID"));
            autlog.setPROG_CODE("sgu060m");
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
        long    endTime    =    System.currentTimeMillis();
        logger.append("全部執行時間：" + String.valueOf(endTime - startTime) + " ms");
        logger.log();
    }

    requestMap    =    null;
    logger        =    null;
}
%>