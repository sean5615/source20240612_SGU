<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01m1.jsp
Author			: Maggie
Description		: SGU123R_匯出新住民暨子女名冊資料- 顯示頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/modulepageinit.jsp"%>
<%@page import="com.nou.sgu.dao.*"%>

<%!
public void doExport(HttpServletResponse response,JspWriter out, DBManager dbManager,HttpServletRequest request, HttpSession session,Hashtable requestMap) throws Exception {
	String filenm = "sgu123r_" + DateUtil.getNowDate() + DateUtil.getNowTimeMs() + ".xls";
	response.setHeader("Content-disposition","attachment; filename=" + filenm);
	response.setContentType("application/vnd.ms-excel;charset=big5");
	response.setHeader("Cache-Control", "max-age=60"); 
	out.clear();
	jxl.write.WritableWorkbook wb = null;
    jxl.write.WritableSheet ws = null;
	try
	{
		Connection conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SGU", session));
		ArrayList lsSql = new ArrayList();
		ArrayList lsTitle = new ArrayList();
		getSql(requestMap,lsSql,lsTitle);
		UtilityX.getExcelData( dbManager, conn, response,lsSql,lsTitle) ;//每段SQL放不同sheet
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}
public void getSql(Hashtable requestMap,ArrayList lsSql,ArrayList lsTitle) throws Exception
{    		
	String AYEAR =  Utility.dbStr(requestMap.get("AYEAR"));
	String SMS =  Utility.dbStr(requestMap.get("SMS"));	
	String CSMS = Utility.dbStr(requestMap.get("SMS"));	
	if(SMS.equals("1"))			CSMS = "上學期";
	else if(SMS.equals("2"))	CSMS = "下學期";
	else						CSMS = "暑期";

    //sql 1<!--- 1. 選課新住民名冊--->
    StringBuffer sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as 序號,   ");
		sql.append("R2.CENTER_NAME AS 中心別, M.STNO AS 學號, S2.NAME AS 姓名, S2.IDNO AS 身分證字號, R6.CODE_NAME AS 性別, ");
		sql.append("R3.CODE_NAME AS 原生國籍別, R5.CODE_NAME AS 年制, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','尚未決定',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS 科系, ");
		sql.append("'否' AS 公費,'否' AS 具領政府所,  ");
		sql.append("case when (SELECT x2.audit_status  FROM REGT004 X2 WHERE X2.AYEAR='"+AYEAR+"' AND X2.SMS='"+SMS+"' AND X2.STNO= R.STNO AND X2.REDUCE_TYPE = '07') = '1' then '是' else '否' end AS 低收入,  ");
		sql.append("S2.EMAIL AS E_mail  ");
		sql.append("FROM REGT005 R  ");
		sql.append("JOIN STUT003 M ON R.STNO = M.STNO  ");
		sql.append("JOIN STUT002 S2 ON S2.IDNO =M.IDNO AND S2.BIRTHDATE = M.BIRTHDATE  ");
		sql.append("JOIN SYST002 R2 ON R2.CENTER_CODE = M.CENTER_CODE  ");
		sql.append("LEFT JOIN SYST001 R3 ON R3.KIND = 'NATIONCODE' AND R3.CODE = S2.NEWNATION  ");
		sql.append("JOIN SYST001 R4 ON R4.KIND = 'STTYPE' AND R4.CODE = M.STTYPE  ");
		sql.append("JOIN SYST001 R5 ON R5.KIND = 'ASYS' AND R5.CODE = M.ASYS  ");
		sql.append("JOIN SYST001 R6 ON R6.KIND = 'SEX' AND R6.CODE = S2.SEX  ");
		sql.append("WHERE (S2.NEWNATION IS NOT NULL OR S2.NEWNATION != '00')  ");
		sql.append("AND M.ENROLL_STATUS  = '2'  ");
		sql.append("AND R.AYEAR = '"+AYEAR+"'  AND R.SMS = '"+SMS+"' AND R.PAYMENT_STATUS <> '1' AND R.TAKE_ABNDN = 'N' AND R.TOTAL_CRD_CNT > '0'  ");
		/*身分證字號第一碼排除護照號碼非數字，第三碼 '6', '7', '8', '9'為外來人口*/
		sql.append("AND (Substr(s2.idno, 1, 1) NOT IN ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ) AND Substr(s2.idno, 3, 1) IN ( '6', '7', '8', '9' ))  "); 
   
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add(""+AYEAR+"學年"+CSMS+"選課新住民名冊");
	
	//sql 1<!--- 1.全校新住民名冊--->
    sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as 序號,   ");
		sql.append("R2.CENTER_NAME AS 中心別, M.STNO AS 學號, S2.NAME AS 姓名, S2.IDNO AS 身分證字號, R6.CODE_NAME AS 性別, ");
		sql.append("R3.CODE_NAME AS 原生國籍別, R5.CODE_NAME AS 年制, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','尚未決定',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS 科系, ");
		sql.append("'　' AS 公費,'　' AS 具領政府所,'　' AS 低收入,S2.EMAIL AS E_mail  ");
		sql.append("FROM STUT003 M  ");
		sql.append("JOIN STUT002 S2 ON S2.IDNO =M.IDNO AND S2.BIRTHDATE = M.BIRTHDATE  ");
		sql.append("JOIN SYST002 R2 ON R2.CENTER_CODE = M.CENTER_CODE  ");
		sql.append("JOIN SYST001 R3 ON R3.KIND = 'NATIONCODE' AND R3.CODE = S2.NEWNATION  ");
		sql.append("JOIN SYST001 R4 ON R4.KIND = 'STTYPE' AND R4.CODE = M.STTYPE  ");
		sql.append("JOIN SYST001 R5 ON R5.KIND = 'ASYS' AND R5.CODE = M.ASYS  ");
		sql.append("JOIN SYST001 R6 ON R6.KIND = 'SEX' AND R6.CODE = S2.SEX  ");
		sql.append("WHERE 1=1  ");
		sql.append("AND M.ENROLL_STATUS  = '2'  ");
		/*身分證字號第一碼排除護照號碼非數字，第三碼 '6', '7', '8', '9'為外來人口*/
		sql.append("AND (Substr(s2.idno, 1, 1) NOT IN ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ) AND Substr(s2.idno, 3, 1) IN ( '6', '7', '8', '9' ))  "); 
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add("全校在籍新住民名冊");	
	
	//sql 1<!--- 2. 選課學年期新住民子女名冊--->
	sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as 序號,   ");
		sql.append("R2.CENTER_NAME AS 中心別, M.STNO AS 學號, S2.NAME AS 姓名, S2.IDNO AS 身分證字號, R6.CODE_NAME AS 性別, ");
		sql.append("SGUT039.FATHER_NAME AS 父親姓名, R3.CODE_NAME AS 原父親國籍別,  ");
		sql.append("SGUT039.MOTHER_NAME AS 母親姓名, R7.CODE_NAME AS 原母親國籍別, R5.CODE_NAME AS 年制, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','尚未決定',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS 科系, ");
		sql.append("'否' AS 公費,'否' AS 具領政府所,  ");
		sql.append("case when (SELECT x2.audit_status  FROM REGT004 X2 WHERE X2.AYEAR='112' AND X2.SMS='2' AND X2.STNO= sgut039.STNO AND X2.REDUCE_TYPE = '07') = '1' then '是' else '否' end AS 低收入,  ");
		sql.append("S2.EMAIL AS E_mail  ");
		sql.append("FROM SGUT039 ");
		sql.append("JOIN STUT003 M ON M.STNO = SGUT039.STNO  ");
		sql.append("JOIN STUT002 S2 ON S2.IDNO =M.IDNO AND S2.BIRTHDATE = M.BIRTHDATE  ");
		sql.append("JOIN SYST002 R2 ON R2.CENTER_CODE = M.CENTER_CODE  ");
		sql.append("JOIN SYST001 R3 ON R3.KIND = 'NATIONCODE' AND R3.CODE = SGUT039.FATHER_ORIGINAL_COUNTRY  ");
		sql.append("JOIN SYST001 R4 ON R4.KIND = 'STTYPE' AND R4.CODE = M.STTYPE  ");
		sql.append("JOIN SYST001 R5 ON R5.KIND = 'ASYS' AND R5.CODE = M.ASYS  ");
		sql.append("JOIN SYST001 R6 ON R6.KIND = 'SEX' AND R6.CODE = S2.SEX  ");
		sql.append("JOIN SYST001 R7 ON R7.KIND = 'NATIONCODE' AND R7.CODE = SGUT039.MOTHER_ORIGINAL_COUNTRY  ");
		sql.append("WHERE 1=1  ");
		sql.append("AND M.ENROLL_STATUS  = '2'  ");
		sql.append("AND SGUT039.AUDIT_MK= '2'  ");
		sql.append("AND SGUT039.STNO IN (SELECT R.STNO FROM REGT005 R WHERE R.AYEAR = '"+AYEAR+"'  AND R.SMS = '"+SMS+"' AND R.PAYMENT_STATUS <> '1' AND R.TAKE_ABNDN = 'N' AND R.TOTAL_CRD_CNT > '0')  ");
		
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add(""+AYEAR+"學年"+CSMS+"選課新住民子女名冊");
	
	//sql 1<!--- 2. 全校在籍新住民子女名冊--->
	sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as 序號,   ");
		sql.append("R2.CENTER_NAME AS 中心別, M.STNO AS 學號, S2.NAME AS 姓名, S2.IDNO AS 身分證字號, R6.CODE_NAME AS 性別, ");
		sql.append("SGUT039.FATHER_NAME AS 父親姓名, R3.CODE_NAME AS 原父親國籍別,  ");
		sql.append("SGUT039.MOTHER_NAME AS 母親姓名, R7.CODE_NAME AS 原母親國籍別, R5.CODE_NAME AS 年制, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','尚未決定',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS 科系, ");
		sql.append("'　' AS 公費,'　' AS 具領政府所,'　' AS 低收入,S2.EMAIL AS E_mail  ");
		sql.append("FROM SGUT039  ");
		sql.append("JOIN STUT003 M ON M.STNO = SGUT039.STNO  ");
		sql.append("JOIN STUT002 S2 ON S2.IDNO =M.IDNO AND S2.BIRTHDATE = M.BIRTHDATE  ");
		sql.append("JOIN SYST002 R2 ON R2.CENTER_CODE = M.CENTER_CODE  ");
		sql.append("JOIN SYST001 R3 ON R3.KIND = 'NATIONCODE' AND R3.CODE = SGUT039.FATHER_ORIGINAL_COUNTRY  ");
		sql.append("JOIN SYST001 R4 ON R4.KIND = 'STTYPE' AND R4.CODE = M.STTYPE  ");
		sql.append("JOIN SYST001 R5 ON R5.KIND = 'ASYS' AND R5.CODE = M.ASYS  ");
		sql.append("JOIN SYST001 R6 ON R6.KIND = 'SEX' AND R6.CODE = S2.SEX  ");
		sql.append("JOIN SYST001 R7 ON R7.KIND = 'NATIONCODE' AND R7.CODE = SGUT039.MOTHER_ORIGINAL_COUNTRY  ");
		sql.append("WHERE 1=1  ");
		sql.append("AND M.ENROLL_STATUS  = '2'  ");
		sql.append("AND SGUT039.AUDIT_MK= '2'  ");
   
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add("全校在籍新住民子女名冊");	
		
	
}
%>