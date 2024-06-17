<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_01m1.jsp
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 處理邏輯頁面
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/modulepageinit.jsp"%>
<%@ page import="com.nou.sgu.dao.*,com.nou.stu.dao.*"%>
<%@ page import="com.acer.util.DateUtil"%>

<%!
/** 處理查詢 Grid 資料 */
public void doQuery(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    Connection conn=null;
    try
    {

        Vector result = new Vector();

        conn       =    dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));
        int        pageNo        =    Integer.parseInt(Utility.checkNull(requestMap.get("pageNo"), "1"));
        int        pageSize    =    Integer.parseInt(Utility.checkNull(requestMap.get("pageSize"), "10"));
        SGUT039GATEWAY  sgut039gateway  =    new SGUT039GATEWAY(dbManager, conn,pageNo,pageSize);

        result =  sgut039gateway.getSgut039Stut002Stut003ForUse(requestMap);

        out.println(DataToJson.vtToJson(result));

    }
    catch (Exception ex)
    {
        throw ex;
    }
    finally
    {
        if (conn != null)
            conn.close();
        dbManager.close();
        conn    =    null;
    }
}

/**  新增招生新住民子女資料 */
public void doSolBatchAdd(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn = null;
	DBResult rs = null;
	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SYS", session));
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT M.AYEAR, M.SMS, M.STNO, M.NEW_RESIDENT_CHD, M.FATHER_NAME, M.FATHER_ORIGINAL_COUNTRY, M.MOTHER_NAME, M.MOTHER_ORIGINAL_COUNTRY, '2' AS AUDIT_MK ");
		sql.append("FROM SOLT003 M ");
		sql.append("JOIN SOLT006 R1 ON M.AYEAR = R1.AYEAR AND M.SMS = R1.SMS AND M.ASYS = R1.ASYS AND M.IDNO = R1.IDNO AND M.BIRTHDATE = R1.BIRTHDATE AND R1.NEW_RESIDENT_AUDIT_MK = '0' ");
		sql.append("JOIN STUT003 R2 ON R2.STNO = M.STNO AND R2.ENROLL_STATUS = '2' ");
		sql.append("WHERE M.ayear = '"+Utility.checkNull(requestMap.get("AYEAR"), "")+"' ");
		sql.append("and M.sms ='"+Utility.checkNull(requestMap.get("SMS"), "")+"' ");
		sql.append("AND M.NEW_RESIDENT_CHD = '2'  ");
		sql.append("AND M.STTYPE != '2'  ");
		sql.append("AND M.STNO NOT IN (SELECT A.STNO FROM SGUT039 A)  ");
		
		if(!Utility.checkNull(requestMap.get("CENTER_CODE"), "").equals("")) {
            sql.append("AND M.CENTER_CODE = '" +Utility.checkNull(requestMap.get("CENTER_CODE"), "")+"' ");
        }
		rs = dbManager.getSimpleResultSet(conn);
        rs.open();
		rs.executeQuery(sql.toString());
		
		while(rs.next()){
			//System.out.println("rs = = = = = " + rs.getString("STNO"));
			SGUT039DAO	SGUT039	=	new SGUT039DAO(dbManager, conn, session.getAttribute("USER_ID").toString());
			SGUT039.setAYEAR(rs.getString("AYEAR"));
			SGUT039.setSMS(rs.getString("SMS"));
			SGUT039.setSTNO(rs.getString("STNO"));
			SGUT039.setNEW_RESIDENT("2");			
			SGUT039.setFATHER_NAME(rs.getString("FATHER_NAME"));
			SGUT039.setFATHER_ORIGINAL_COUNTRY(rs.getString("FATHER_ORIGINAL_COUNTRY"));
			SGUT039.setMOTHER_NAME(rs.getString("MOTHER_NAME"));
			SGUT039.setMOTHER_ORIGINAL_COUNTRY(rs.getString("MOTHER_ORIGINAL_COUNTRY"));
			SGUT039.setAUDIT_MK(rs.getString("AUDIT_MK"));
			SGUT039.setAUDIT_DATE(rs.getString("AUDIT_MK"));
			SGUT039.setAUDIT_USER((String)session.getAttribute("USER_ID"));
			
			try	{SGUT039.insert();}catch (Exception ex){}
			System.out.println("111111111");
		}
		
		dbManager.commit();
		
		out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		/** Rollback Transaction */
		dbManager.rollback();
		throw ex;
	}
	finally
	{
		if(rs != null) {
			rs.close();
		}
		if (conn != null)
			conn.close();
		conn	=	null;
	}
}

/** 處理新增存檔 */
public void doAdd(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn    =    dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));

        /** 處理新增動作 */
        SGUT039DAO    SGUT039    =    new SGUT039DAO(dbManager, conn, requestMap, session);
        SGUT039.setAUDIT_DATE(DateUtil.getNowDate());
        if (Utility.checkNull(requestMap.get("AUDIT_MK"), "").equals("")){
            SGUT039.setAUDIT_MK("1");
            System.out.println("111111111");
        }
        SGUT039.setNEW_RESIDENT("2");
        SGUT039.setAUDIT_USER((String)session.getAttribute("USER_ID"));
        SGUT039.setUPD_MK("1");
        SGUT039.insert();

        /** Commit Transaction */
        dbManager.commit();

        out.println(DataToJson.successJson());
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();

        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

/** 修改帶出資料 */
public void doQueryEdit(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    Connection    conn    =    dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));
    SGUT039DAO    SGUT039    =    new SGUT039DAO(dbManager, conn);
    SGUT039.setResultColumn("AYEAR, SMS, STNO, NEW_RESIDENT, FATHER_NAME, FATHER_ORIGINAL_COUNTRY, MOTHER_NAME, MOTHER_ORIGINAL_COUNTRY, AUDIT_MK, ROWSTAMP");
    SGUT039.setAYEAR(Utility.dbStr(requestMap.get("AYEAR")));
    SGUT039.setSMS(Utility.dbStr(requestMap.get("SMS")));
    SGUT039.setSTNO(Utility.dbStr(requestMap.get("STNO")));

    DBResult    rs    =    SGUT039.query();

    out.println(DataToJson.rsToJson (rs));

    dbManager.close();
}

/** 修改存檔 */
public void doModify(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn    =    dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));

        /** 修改條件 */
        String    condition    =    "AYEAR    =    '" + Utility.dbStr(requestMap.get("AYEAR")) + "' AND " +
									"SMS      =    '" + Utility.dbStr(requestMap.get("SMS")) + "' AND " +
									"STNO     =    '" + Utility.dbStr(requestMap.get("STNO")) + "' ";

        /** 處理修改動作 */
        SGUT039DAO    SGUT039    =    new SGUT039DAO(dbManager, conn, requestMap, session);
        int    updateCount    =    SGUT039.update(condition);

        /** Commit Transaction */
        dbManager.commit();

        if (updateCount == 0)
            out.println(DataToJson.faileJson("此筆資料已被異動過, <br>請重新查詢修改!!"));
        else
            out.println(DataToJson.successJson());
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();

        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

/** 刪除資料 */
public void doDelete(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn        =    dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));

        /** 刪除條件 */
        StringBuffer    conditionBuff    =    new StringBuffer();

        String[]    AYEAR    =    Utility.split(requestMap.get("AYEAR").toString(), ",");
        String[]    SMS    	 =    Utility.split(requestMap.get("SMS").toString(), ",");
        String[]    STNO     =    Utility.split(requestMap.get("STNO").toString(), ",");

        for (int i = 0; i < AYEAR.length; i++)
        {
            if (i > 0)
                conditionBuff.append (" OR ");

            conditionBuff.append
            (
                "(" +
                "    AYEAR    =    '" + Utility.dbStr(AYEAR[i]) + "' AND " +
                "    SMS    =    '" + Utility.dbStr(SMS[i]) + "' AND " +
                "    STNO    =    '" + Utility.dbStr(STNO[i]) + "' " +
                ")"
            );
        }

        /** 處理刪除動作 */
        SGUT039DAO    SGUT039    =    new SGUT039DAO(dbManager, conn, requestMap, session);
        SGUT039.delete(conditionBuff.toString());

        /** Commit Transaction */
        dbManager.commit();

        out.println(DataToJson.successJson());
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();

        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

%>