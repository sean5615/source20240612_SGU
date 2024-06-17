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
		UtilityX.getExcelData( dbManager, conn, response,lsSql,lsTitle) ;//�C�qSQL�񤣦Psheet
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
	if(SMS.equals("1"))			CSMS = "�W�Ǵ�";
	else if(SMS.equals("2"))	CSMS = "�U�Ǵ�";
	else						CSMS = "����";

    //sql 1<!--- 1. ��ҷs����W�U--->
    StringBuffer sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as �Ǹ�,   ");
		sql.append("R2.CENTER_NAME AS ���ߧO, M.STNO AS �Ǹ�, S2.NAME AS �m�W, S2.IDNO AS �����Ҧr��, R6.CODE_NAME AS �ʧO, ");
		sql.append("R3.CODE_NAME AS ��Ͱ��y�O, R5.CODE_NAME AS �~��, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','�|���M�w',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS ��t, ");
		sql.append("'�_' AS ���O,'�_' AS ���F����,  ");
		sql.append("case when (SELECT x2.audit_status  FROM REGT004 X2 WHERE X2.AYEAR='"+AYEAR+"' AND X2.SMS='"+SMS+"' AND X2.STNO= R.STNO AND X2.REDUCE_TYPE = '07') = '1' then '�O' else '�_' end AS �C���J,  ");
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
		/*�����Ҧr���Ĥ@�X�ư��@�Ӹ��X�D�Ʀr�A�ĤT�X '6', '7', '8', '9'���~�ӤH�f*/
		sql.append("AND (Substr(s2.idno, 1, 1) NOT IN ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ) AND Substr(s2.idno, 3, 1) IN ( '6', '7', '8', '9' ))  "); 
   
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add(""+AYEAR+"�Ǧ~"+CSMS+"��ҷs����W�U");
	
	//sql 1<!--- 1.���շs����W�U--->
    sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as �Ǹ�,   ");
		sql.append("R2.CENTER_NAME AS ���ߧO, M.STNO AS �Ǹ�, S2.NAME AS �m�W, S2.IDNO AS �����Ҧr��, R6.CODE_NAME AS �ʧO, ");
		sql.append("R3.CODE_NAME AS ��Ͱ��y�O, R5.CODE_NAME AS �~��, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','�|���M�w',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS ��t, ");
		sql.append("'�@' AS ���O,'�@' AS ���F����,'�@' AS �C���J,S2.EMAIL AS E_mail  ");
		sql.append("FROM STUT003 M  ");
		sql.append("JOIN STUT002 S2 ON S2.IDNO =M.IDNO AND S2.BIRTHDATE = M.BIRTHDATE  ");
		sql.append("JOIN SYST002 R2 ON R2.CENTER_CODE = M.CENTER_CODE  ");
		sql.append("JOIN SYST001 R3 ON R3.KIND = 'NATIONCODE' AND R3.CODE = S2.NEWNATION  ");
		sql.append("JOIN SYST001 R4 ON R4.KIND = 'STTYPE' AND R4.CODE = M.STTYPE  ");
		sql.append("JOIN SYST001 R5 ON R5.KIND = 'ASYS' AND R5.CODE = M.ASYS  ");
		sql.append("JOIN SYST001 R6 ON R6.KIND = 'SEX' AND R6.CODE = S2.SEX  ");
		sql.append("WHERE 1=1  ");
		sql.append("AND M.ENROLL_STATUS  = '2'  ");
		/*�����Ҧr���Ĥ@�X�ư��@�Ӹ��X�D�Ʀr�A�ĤT�X '6', '7', '8', '9'���~�ӤH�f*/
		sql.append("AND (Substr(s2.idno, 1, 1) NOT IN ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ) AND Substr(s2.idno, 3, 1) IN ( '6', '7', '8', '9' ))  "); 
		sql.append("ORDER BY S2.IDNO  ");
	lsSql.add(sql.toString());
	lsTitle.add("���զb�y�s����W�U");	
	
	//sql 1<!--- 2. ��ҾǦ~���s����l�k�W�U--->
	sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as �Ǹ�,   ");
		sql.append("R2.CENTER_NAME AS ���ߧO, M.STNO AS �Ǹ�, S2.NAME AS �m�W, S2.IDNO AS �����Ҧr��, R6.CODE_NAME AS �ʧO, ");
		sql.append("SGUT039.FATHER_NAME AS ���˩m�W, R3.CODE_NAME AS ����˰��y�O,  ");
		sql.append("SGUT039.MOTHER_NAME AS ���˩m�W, R7.CODE_NAME AS ����˰��y�O, R5.CODE_NAME AS �~��, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','�|���M�w',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS ��t, ");
		sql.append("'�_' AS ���O,'�_' AS ���F����,  ");
		sql.append("case when (SELECT x2.audit_status  FROM REGT004 X2 WHERE X2.AYEAR='112' AND X2.SMS='2' AND X2.STNO= sgut039.STNO AND X2.REDUCE_TYPE = '07') = '1' then '�O' else '�_' end AS �C���J,  ");
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
	lsTitle.add(""+AYEAR+"�Ǧ~"+CSMS+"��ҷs����l�k�W�U");
	
	//sql 1<!--- 2. ���զb�y�s����l�k�W�U--->
	sql = new StringBuffer();
		sql.append("SELECT row_number()over(ORDER BY S2.IDNO asc) as �Ǹ�,   ");
		sql.append("R2.CENTER_NAME AS ���ߧO, M.STNO AS �Ǹ�, S2.NAME AS �m�W, S2.IDNO AS �����Ҧr��, R6.CODE_NAME AS �ʧO, ");
		sql.append("SGUT039.FATHER_NAME AS ���˩m�W, R3.CODE_NAME AS ����˰��y�O,  ");
		sql.append("SGUT039.MOTHER_NAME AS ���˩m�W, R7.CODE_NAME AS ����˰��y�O, R5.CODE_NAME AS �~��, ");
		sql.append("CASE WHEN M.ASYS = '1' THEN (SELECT TO_CHAR(DECODE(M.PRE_MAJOR_FACULTY,'00','�|���M�w',X1.FACULTY_NAME)) FROM SYST003 X1 WHERE X1.FACULTY_CODE = M.PRE_MAJOR_FACULTY)  ");
		sql.append("      WHEN M.ASYS = '2' THEN (SELECT TO_CHAR(X2.TOTAL_CRS_NAME) FROM SYST008 X2 WHERE X2.ASYS = '2' AND X2.FACULTY_CODE||X2.TOTAL_CRS_NO = M.PRE_MAJOR_FACULTY||M.J_FACULTY_CODE)  END AS ��t, ");
		sql.append("'�@' AS ���O,'�@' AS ���F����,'�@' AS �C���J,S2.EMAIL AS E_mail  ");
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
	lsTitle.add("���զb�y�s����l�k�W�U");	
		
	
}
%>