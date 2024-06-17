package com.nou.sgu.dao;

import com.acer.db.DBManager;
import com.acer.db.query.DBResult;
import com.acer.util.DateUtil;
import com.acer.util.Utility;
import com.acer.apps.Page;
import com.nou.sol.dao.SOLT003DAO;
import com.nou.sol.dao.SOLT006DAO;

import java.sql.Connection;
import java.util.Vector;
import java.util.Hashtable;

/*
 * (SGUT039) Gateway/*
 *-------------------------------------------------------------------------------*
 * Author    : 美智      2024/05/06
 * Modification Log :
 * Vers     Date           By             Notes
 *--------- -------------- -------------- ----------------------------------------
 * V0.0.1   2024/05/06     美智           建立程式
 *                                        新增 getSgut039ForUse(Hashtable ht)
 * V0.0.2   2024/05/22     美智           新增 getSgut039Stut002Stut003ForUse(Hashtable ht)
 *--------------------------------------------------------------------------------
 */
public class SGUT039GATEWAY {

    /** 資料排序方式 */
    private String orderBy = "";
    private DBManager dbmanager = null;
    private Connection conn = null;
    /* 頁數 */
    private int pageNo = 0;
    /** 每頁筆數 */
    private int pageSize = 0;

    /** 記錄是否分頁 */
    private boolean pageQuery = false;

    /** 用來存放 SQL 語法的物件 */
    private StringBuffer sql = new StringBuffer();

    /** <pre>
     *  設定資料排序方式.
     *  Ex: "AYEAR, SMS DESC"
     *      先以 AYEAR 排序再以 SMS 倒序序排序
     *  </pre>
     */
    public void setOrderBy(String orderBy) {
        if(orderBy == null) {
            orderBy = "";
        }
        this.orderBy = orderBy;
    }

    /** 取得總筆數 */
    public int getTotalRowCount() {
        return Page.getTotalRowCount();
    }

    /** 不允許建立空的物件 */
    private SGUT039GATEWAY() {}

    /** 建構子，查詢全部資料用 */
    public SGUT039GATEWAY(DBManager dbmanager, Connection conn) {
        this.dbmanager = dbmanager;
        this.conn = conn;
    }

    /** 建構子，查詢分頁資料用 */
    public SGUT039GATEWAY(DBManager dbmanager, Connection conn, int pageNo, int pageSize) {
        this.dbmanager = dbmanager;
        this.conn = conn;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        pageQuery = true;
    }

    /**
     *
     * @param ht 條件值
     * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
     *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
     *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
     * @throws Exception
     */
    public Vector getSgut039ForUse(Hashtable ht) throws Exception {
        if(ht == null) {
            ht = new Hashtable();
        }
        Vector result = new Vector();
        if(sql.length() > 0) {
            sql.delete(0, sql.length());
        }
        sql.append(
            "SELECT S39.STNO, S39.NEW_RESIDENT, S39.AYEAR, S39.SMS, S39.NEWNATION, S39.FATHER_NAME, S39.FATHER_ORIGINAL_COUNTRY, S39.MOTHER_NAME, S39.MOTHER_ORIGINAL_COUNTRY, S39.AUDIT_MK, S39.AUDIT_DATE, S39.AUDIT_USER, S39.RMK, S39.ROWSTAMP, S39.UPD_DATE, S39.UPD_TIME, S39.UPD_USER_ID, S39.UPD_MK " +
            "FROM SGUT039 S39 " +
            "WHERE 1 = 1 "
        );
        if(!Utility.nullToSpace(ht.get("STNO")).equals("")) {
            sql.append("AND S39.STNO = '" + Utility.nullToSpace(ht.get("STNO")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("NEW_RESIDENT")).equals("")) {
            sql.append("AND S39.NEW_RESIDENT = '" + Utility.nullToSpace(ht.get("NEW_RESIDENT")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("AYEAR")).equals("")) {
            sql.append("AND S39.AYEAR = '" + Utility.nullToSpace(ht.get("AYEAR")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("SMS")).equals("")) {
            sql.append("AND S39.SMS = '" + Utility.nullToSpace(ht.get("SMS")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("NEWNATION")).equals("")) {
            sql.append("AND S39.NEWNATION = '" + Utility.nullToSpace(ht.get("NEWNATION")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("FATHER_NAME")).equals("")) {
            sql.append("AND S39.FATHER_NAME = '" + Utility.nullToSpace(ht.get("FATHER_NAME")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("FATHER_ORIGINAL_COUNTRY")).equals("")) {
            sql.append("AND S39.FATHER_ORIGINAL_COUNTRY = '" + Utility.nullToSpace(ht.get("FATHER_ORIGINAL_COUNTRY")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("MOTHER_NAME")).equals("")) {
            sql.append("AND S39.MOTHER_NAME = '" + Utility.nullToSpace(ht.get("MOTHER_NAME")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("MOTHER_ORIGINAL_COUNTRY")).equals("")) {
            sql.append("AND S39.MOTHER_ORIGINAL_COUNTRY = '" + Utility.nullToSpace(ht.get("MOTHER_ORIGINAL_COUNTRY")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("AUDIT_MK")).equals("")) {
            sql.append("AND S39.AUDIT_MK = '" + Utility.nullToSpace(ht.get("AUDIT_MK")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("AUDIT_DATE")).equals("")) {
            sql.append("AND S39.AUDIT_DATE = '" + Utility.nullToSpace(ht.get("AUDIT_DATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("AUDIT_USER")).equals("")) {
            sql.append("AND S39.AUDIT_USER = '" + Utility.nullToSpace(ht.get("AUDIT_USER")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RMK")).equals("")) {
            sql.append("AND S39.RMK = '" + Utility.nullToSpace(ht.get("RMK")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("ROWSTAMP")).equals("")) {
            sql.append("AND S39.ROWSTAMP = '" + Utility.nullToSpace(ht.get("ROWSTAMP")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_DATE")).equals("")) {
            sql.append("AND S39.UPD_DATE = '" + Utility.nullToSpace(ht.get("UPD_DATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_TIME")).equals("")) {
            sql.append("AND S39.UPD_TIME = '" + Utility.nullToSpace(ht.get("UPD_TIME")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_USER_ID")).equals("")) {
            sql.append("AND S39.UPD_USER_ID = '" + Utility.nullToSpace(ht.get("UPD_USER_ID")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_MK")).equals("")) {
            sql.append("AND S39.UPD_MK = '" + Utility.nullToSpace(ht.get("UPD_MK")) + "' ");
        }
 
        if(!orderBy.equals("")) {
            String[] orderByArray = orderBy.split(",");
            for(int i = 0; i < orderByArray.length; i++) {
                orderByArray[i] = "S39." + orderByArray[i].trim();

                if(i == 0) {
                    orderBy += "ORDER BY ";
                } else {
                    orderBy += ", ";
                }
                orderBy += orderByArray[i].trim();
            }
            sql.append(orderBy.toUpperCase());
            orderBy = "";
        }

        DBResult rs = null;
        try {
            if(pageQuery) {
                // 依分頁取出資料
                rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
            } else {
                // 取出所有資料
                rs = dbmanager.getSimpleResultSet(conn);
                rs.open();
                rs.executeQuery(sql.toString());
            }
            Hashtable rowHt = null;
            while (rs.next()) {
                rowHt = new Hashtable();
                /** 將欄位抄一份過去 */
                for (int i = 1; i <= rs.getColumnCount(); i++)
                    rowHt.put(rs.getColumnName(i), rs.getString(i));

                result.add(rowHt);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return result;
    }
    /*
     * 維護新住民資料
     *
     */
    public Vector getSgut039Stut002Stut003ForUse(Hashtable ht) throws Exception {

        Vector result = new Vector();
        if(sql.length() > 0) {
            sql.delete(0, sql.length());
        }

        sql.append
        (
            "SELECT SGUT039.AYEAR,SGUT039.SMS,S6.CODE_NAME AS CSMS,SGUT039.STNO,STUT002.NAME,STUT003.CENTER_CODE, " +
            "SYST002.CENTER_NAME AS CENTER_CODE1,SYST002.CENTER_ABBRNAME,STUT002.SEX,S1.CODE_NAME AS SEX1,  " +
            "STUT003.STTYPE,S2.CODE_NAME AS STTYPE1,STUT002.IDNO,STUT002.BIRTHDATE,STUT002.MOBILE, STUT002.CRRSADDR_ZIP||STUT002.CRRSADDR AS ADDRESS,  " +
            "to_char(SGUT039.NEW_RESIDENT) as NEW_RESIDENT, SGUT039.NEWNATION, S3.CODE_NAME AS CNEWNATION, " +
            "SGUT039.FATHER_NAME, SGUT039.FATHER_ORIGINAL_COUNTRY, S4.CODE_NAME AS CFATHER_ORIGINAL_COUNTRY,  "+
            "SGUT039.MOTHER_NAME, SGUT039.MOTHER_ORIGINAL_COUNTRY, S5.CODE_NAME AS CMOTHER_ORIGINAL_COUNTRY,  " +
			"SGUT039.AUDIT_MK, DECODE(SGUT039.AUDIT_MK,'3','不通過','2','通過','未審查') AS AUDIT_MK1, " +
            "substr(STUT003.ENROLL_AYEARSMS,1,3)||DECODE(substr(STUT003.ENROLL_AYEARSMS,4,3),'1','上學期','2','下學期','暑期') AS ENROLL_AYEARSMS " +
            ",'SGUT039' AS TABLE_RMK   " +
            "FROM SGUT039 JOIN STUT003 ON SGUT039.STNO = STUT003.STNO  " +
            "JOIN STUT002 ON STUT003.BIRTHDATE = STUT002.BIRTHDATE AND STUT003.IDNO = STUT002.IDNO  " +
            "JOIN SYST002 ON STUT003.CENTER_CODE = SYST002.CENTER_CODE " +
            "LEFT JOIN SYST001 S1 ON S1.KIND='SEX' AND S1.CODE = STUT002.SEX  " +
            "LEFT JOIN SYST001 S2 ON S2.KIND='STTYPE' AND S2.CODE = STUT003.STTYPE  " +
            "LEFT JOIN SYST001 S3 ON S3.KIND='NATIONCODE' AND S3.CODE = SGUT039.NEWNATION " +
            "LEFT JOIN SYST001 S4 ON S4.KIND='NATIONCODE' AND S4.CODE = SGUT039.FATHER_ORIGINAL_COUNTRY " +
            "LEFT JOIN SYST001 S5 ON S5.KIND='NATIONCODE' AND S5.CODE = SGUT039.MOTHER_ORIGINAL_COUNTRY " +
            "LEFT JOIN SYST001 S6 ON S6.KIND = 'SMS' AND S6.CODE = SGUT039.SMS " +
            "WHERE 1  =  1  "
        );

        /** == 查詢條件 ST == */
        if(!Utility.nullToSpace(ht.get("AYEAR")).equals("")&&!Utility.nullToSpace(ht.get("SMS")).equals("")) {
           sql.append(" AND SGUT039.AYEAR= '"+Utility.nullToSpace(ht.get("AYEAR"))+"' AND SGUT039.SMS ='"+Utility.nullToSpace(ht.get("SMS"))+"' ");
        }
        
        if(!Utility.nullToSpace(ht.get("STNO")).equals("")) {
            sql.append("AND SGUT039.STNO = '" + Utility.nullToSpace(ht.get("STNO")) + "' ");
        }
		if(!Utility.nullToSpace(ht.get("ASYS")).equals("")) {
            sql.append("AND STUT003.ASYS = '" + Utility.nullToSpace(ht.get("ASYS")) + "' ");
        }
		if(!Utility.nullToSpace(ht.get("CENTER_CODE")).equals("")) {
            sql.append("AND STUT003.CENTER_CODE = '" + Utility.nullToSpace(ht.get("CENTER_CODE")) + "' ");
        }

        // 申請種類新住民/新住民子女
        if(!Utility.nullToSpace(ht.get("NEW_RESIDENT")).equals(""))
        	sql.append("AND SGUT039.NEW_RESIDENT = '" + Utility.nullToSpace(ht.get("NEW_RESIDENT")) + "' ");
        //查詢條件 審核狀態
        //if(Utility.nullToSpace(ht.get("AUDIT_MK")).equals("1")){
        //	sql.append("AND SGUT039.AUDIT_MK = '1' ");
        //}else if(Utility.nullToSpace(ht.get("AUDIT_MK")).equals("2")){
        //	sql.append("AND SGUT039.AUDIT_MK = '2' ");
        //}else if(Utility.nullToSpace(ht.get("AUDIT_MK")).equals("")){
        //	sql.append("AND SGUT039.AUDIT_MK IS NULL ");
        // }
         //查詢條件 學籍狀態       
        if(!Utility.nullToSpace(ht.get("ENROLL_STATUS")).equals("")){
	        if(Utility.nullToSpace(ht.get("ENROLL_STATUS")).equals("1")){
	        	sql.append("AND STUT003.ENROLL_STATUS = '2' ");
	        }else if(Utility.nullToSpace(ht.get("ENROLL_STATUS")).equals("2")){
	        	sql.append("AND STUT003.ENROLL_STATUS <> '2' ");
	        }	
        }
        //招生資料檔 
        sql.append
        (
        	"UNION " +
        	"SELECT SOLT003.AYEAR,SOLT003.SMS,S6.CODE_NAME AS CSMS,SOLT003.STNO,STUT002.NAME,STUT003.CENTER_CODE, SYST002.CENTER_NAME AS CENTER_CODE1,SYST002.CENTER_ABBRNAME,STUT002.SEX,S1.CODE_NAME AS SEX1, " +
            "STUT003.STTYPE,S2.CODE_NAME AS STTYPE1,STUT002.IDNO,STUT002.BIRTHDATE,STUT002.MOBILE, STUT002.CRRSADDR_ZIP||STUT002.CRRSADDR AS ADDRESS,  '2' AS NEW_RESIDENT, SOLT003.NEWNATION,  " +
            "S3.CODE_NAME AS CNEWNATION, SOLT003.FATHER_NAME, SOLT003.FATHER_ORIGINAL_COUNTRY, S4.CODE_NAME AS CFATHER_ORIGINAL_COUNTRY,  SOLT003.MOTHER_NAME, SOLT003.MOTHER_ORIGINAL_COUNTRY,  " +
            "S5.CODE_NAME AS CMOTHER_ORIGINAL_COUNTRY,  SOLT006.NEW_RESIDENT_AUDIT_MK AS AUDIT_MK, DECODE(SOLT006.NEW_RESIDENT_AUDIT_MK,'1','不通過','0','通過','3','待審查','2','其他','4','待補件') AS AUDIT_MK1," +
            "substr(STUT003.ENROLL_AYEARSMS,1,3)||DECODE(substr(STUT003.ENROLL_AYEARSMS,4,3),'1','上學期','2','下學期','3','暑期','') AS ENROLL_AYEARSMS  "+
            ",'SOLT003' AS TABLE_RMK   " +
			"FROM SOLT003 " +
            "JOIN SOLT006 ON SOLT006.ASYS = SOLT003.ASYS AND SOLT006.AYEAR = SOLT003.AYEAR AND SOLT006.SMS = SOLT003.SMS AND SOLT006.IDNO = SOLT003.IDNO  AND SOLT006.BIRTHDATE = SOLT003.BIRTHDATE " +
            "JOIN STUT003 ON SOLT003.STNO = STUT003.STNO AND STUT003.ENROLL_STATUS = '2'  " +
            "JOIN STUT002 ON STUT003.BIRTHDATE = STUT002.BIRTHDATE AND STUT003.IDNO = STUT002.IDNO  " +
            "JOIN SYST002 ON SOLT003.CENTER_CODE = SYST002.CENTER_CODE " +
            "LEFT JOIN SYST001 S1 ON S1.KIND='SEX' AND S1.CODE = STUT002.SEX  " +
            "LEFT JOIN SYST001 S2 ON S2.KIND='STTYPE' AND S2.CODE = STUT003.STTYPE  " +
            "LEFT JOIN SYST001 S3 ON S3.KIND='NATIONCODE' AND S3.CODE = SOLT003.NEWNATION " +
            "LEFT JOIN SYST001 S4 ON S4.KIND='NATIONCODE' AND S4.CODE = SOLT003.FATHER_ORIGINAL_COUNTRY " +
            "LEFT JOIN SYST001 S5 ON S5.KIND='NATIONCODE' AND S5.CODE = SOLT003.MOTHER_ORIGINAL_COUNTRY " +
            "LEFT JOIN SYST001 S6 ON S6.KIND = 'SMS' AND S6.CODE = SOLT003.SMS " +
            "WHERE 1  =  1 " +
            //"AND SOLT003.AYEAR= '"+Utility.nullToSpace(ht.get("AYEAR"))+"' AND SOLT003.SMS ='"+Utility.nullToSpace(ht.get("SMS"))+"' " +
            "AND SOLT003.NEW_RESIDENT_CHD ='2' " +
            "AND SOLT003.STTYPE !='2' " +
            "AND SOLT003.STNO NOT IN (SELECT A.STNO FROM SGUT039 A) " 
            
        );

        /** == 查詢條件 ST == */
        if(!Utility.nullToSpace(ht.get("AYEAR")).equals("")) {
            sql.append("AND SOLT003.AYEAR = '" + Utility.nullToSpace(ht.get("AYEAR")) + "' ");
        }
        
        if(!Utility.nullToSpace(ht.get("SMS")).equals("")) {
            sql.append("AND SOLT003.SMS = '" + Utility.nullToSpace(ht.get("SMS")) + "' ");
        }
        
        if(!Utility.nullToSpace(ht.get("STNO")).equals("")) {
            sql.append("AND SOLT003.STNO = '" + Utility.nullToSpace(ht.get("STNO")) + "' ");
        }
		if(!Utility.nullToSpace(ht.get("ASYS")).equals("")) {
            sql.append("AND SOLT003.ASYS = '" + Utility.nullToSpace(ht.get("ASYS")) + "' ");
        }
		if(!Utility.nullToSpace(ht.get("CENTER_CODE")).equals("")) {
            sql.append("AND SOLT003.CENTER_CODE = '" + Utility.nullToSpace(ht.get("CENTER_CODE")) + "' ");
        }
        
        sql.append(" ORDER BY TABLE_RMK, 5, 3  ");
        /** == 查詢條件 ED == */
        
        DBResult rs = null;
        try {
            if(pageQuery) {
                // 依分頁取出資料
                rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
            } else {
                // 取出所有資料
                rs = dbmanager.getSimpleResultSet(conn);
                rs.open();
                rs.executeQuery(sql.toString());
            }
            Hashtable rowHt = null;
            while (rs.next()) {
                rowHt = new Hashtable();
                /** 將欄位抄一份過去 */
                for (int i = 1; i <= rs.getColumnCount(); i++)
                    rowHt.put(rs.getColumnName(i), rs.getString(i));

                result.add(rowHt);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return result;
    }

	public void getSgu123rPrint(Vector vt, Hashtable ht) throws Exception {
		DBResult rs = null;
		DBResult rs2 = null;
		try
		{
			if(sql.length() >0)
				sql.delete(0, sql.length());
	
			String	CENTER_CODE1	=	Utility.checkNull((String)ht.get("CENTER_CODE1"), "");	//中心1
			
			sql.append
			(
				"SELECT DISTINCT b.asys asys1, b.CENTER_CODE, d.CENTER_NAME, a.STNO, c.NAME, b.IDNO, a.PARENTS_RACE, e.CODE_NAME, c.SEX, b.NOU_EMAIL,F.CODE_NAME AS ASYS,nvl(G.faculty_abbrname, '無') as faculty_abbrname,c.mobile, c.email, c.crrsaddr_zip||c.crrsaddr as crrsaddr  " +
				", H.CODE_NAME AS ORIGINRACEAREA_KIND, I.CODE_NAME AS ORIGINRACEAREA, J.KIND_NAME AS ORIGINRACELANG_KIND , K.CODE_NAME AS ORIGINRACELANG  " +
				"FROM REGT005 R1 " +
				"JOIN SGUT004 a ON A. HAND_NATIVE = '1' AND a.AUDIT_MK='2'  AND R1.STNO = A.STNO  " +
				"JOIN STUT003 b ON B.STNO = A.STNO " +
				"JOIN STUT002 c ON C.IDNO = B.IDNO AND C.BIRTHDATE = B.BIRTHDATE " +
				"JOIN SYST002 d ON b.CENTER_CODE=d.CENTER_CODE " +
				"JOIN SYST001 e ON e.KIND='ORIGIN_RACE' AND a.PARENTS_RACE=e.CODE " +
				"JOIN SYST001 F ON F.KIND = 'ASYS' AND F.CODE = B.ASYS " +
				"LEFT JOIN SYST008 G ON G.faculty_code = B.pre_major_faculty and G.total_crs_no = B.j_faculty_code  " +
				"LEFT JOIN SYST001 H ON H.KIND = 'ORIGINRACEAREA' AND H.CODE = A.ORIGINRACEAREA_KIND  " +
				"LEFT JOIN SYST001 I ON I.KIND = 'ORIGINRACEAREA'||'_'||A.ORIGINRACEAREA_KIND AND I.CODE = A.ORIGINRACEAREA  " +
				"LEFT JOIN SYST001 J ON J.KIND = 'ORIGINRACELANG_'||A.ORIGINRACELANG_KIND  " +
				"LEFT JOIN SYST001 K ON K.KIND = 'ORIGINRACELANG_'||A.ORIGINRACELANG_KIND AND K.CODE = A.ORIGINRACELANG  " +
				"WHERE 1=1 AND R1.PAYMENT_STATUS <>'1' AND R1.TAKE_ABNDN='N'  " 
			);
			
			sql.append("AND R1.AYEAR = '" + Utility.dbStr(ht.get("AYEAR")) + "' ");
			sql.append("AND R1.SMS = '" + Utility.dbStr(ht.get("SMS")) + "' ");
	
			if(!Utility.nullToSpace(ht.get("STTYPE")).equals(""))
	        	sql.append("AND b.STTYPE = '" + Utility.nullToSpace(ht.get("STTYPE")) + "' ");
			if(!Utility.nullToSpace(ht.get("ASYS")).equals(""))
	        	sql.append("AND b.ASYS = '" + Utility.nullToSpace(ht.get("ASYS")) + "' ");
			if(!Utility.nullToSpace(ht.get("CENTER_CODE")).equals(""))
	        	sql.append("AND b.CENTER_CODE = '" + Utility.nullToSpace(ht.get("CENTER_CODE")) + "' ");
			if(!Utility.nullToSpace(ht.get("PARENTS_RACE")).equals(""))
	        	sql.append("AND a.PARENTS_RACE = '" + Utility.nullToSpace(ht.get("PARENTS_RACE")) + "' ");
	
			sql.append("AND F.KIND = 'ASYS' AND F.CODE = B.ASYS ");
	
	
	    	if(!CENTER_CODE1.equals(""))
	    	{
	    		String[] CENTER_CODE1Array = CENTER_CODE1.split(",");
	            String CENTER_CODE_IN = "";
	            for(int i = 0; i < CENTER_CODE1Array.length; i++)
	            {
	                if(i == 0)
	                {
	                	CENTER_CODE_IN += "B.CENTER_CODE IN ( ";
	                }
	                else
	                {
	                	CENTER_CODE_IN += ", ";
	                }
	                CENTER_CODE_IN += "'" + CENTER_CODE1Array[i].trim() + "' ";
	            }
	            CENTER_CODE_IN += ") ";
	            sql.append("AND " + CENTER_CODE_IN);
	    	}
	
	
			sql.append("ORDER BY b.CENTER_CODE ASC, a.STNO ASC" );
	
			if(pageQuery) {
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
			} else {
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}
			rs2 = dbmanager.getSimpleResultSet(conn);
			rs2.open();
	
			Hashtable rowHt = null;
			while (rs.next())
			{
				rowHt = new Hashtable();
				for (int i = 1; i <= rs.getColumnCount(); i++)
					rowHt.put(rs.getColumnName(i), rs.getString(i));
	
				String STNO = rs.getString("STNO");
				rs2.executeQuery("SELECT STNO FROM SGUT003 WHERE AUDIT_RESULT='Y' AND SCHOLAR_TYPE_CODE<>'04' AND SCHOLAR_TYPE_CODE<>'4' AND AYEAR='"+Utility.dbStr(ht.get("AYEAR"))+"' AND SMS='"+Utility.dbStr(ht.get("SMS"))+"' AND STNO='"+STNO+"' ");
				String ghv = "否";
				if(rs2.next())
					ghv = "是";
	
				rowHt.put("GHAVE_MK", ghv);
	
				//rs2.executeQuery("SELECT a.STNO, a.REDUCE_TYPE, b.CODE_NAME FROM REGT004 a, SYST001 b WHERE a.REDUCE_TYPE=b.CODE AND b.KIND='REDUCE_TYPE' AND a.AYEAR='"+Utility.dbStr(ht.get("AYEAR"))+"' AND a.SMS='"+Utility.dbStr(ht.get("SMS"))+"' AND a.STNO='"+STNO+"' ");
				
				StringBuffer reduceSql = new StringBuffer();
				reduceSql.append("SELECT  ");
				reduceSql.append("a.STNO,a.REDUCE_TYPE,b.CODE_NAME as REDUCE_NAME, ");
				reduceSql.append("(select REDUCE_CRD_FEE_RATE from regt003 r where a.REDUCE_TYPE = r.REDUCE_TYPE and r.ayear = a.ayear and r.sms = a.sms and r.ayear = a.ayear and r.EXPENSE_TYPE_CODE ='01' ) as RATE_1, ");
				reduceSql.append("(select REDUCE_CRD_FEE_RATE from regt003 r where a.REDUCE_TYPE = r.REDUCE_TYPE and r.ayear = a.ayear and r.sms = a.sms and r.ayear = a.ayear and r.EXPENSE_TYPE_CODE ='02' ) as RATE_2, ");
				reduceSql.append("(select REDUCE_CRD_FEE_RATE from regt003 r where a.REDUCE_TYPE = r.REDUCE_TYPE and r.ayear = a.ayear and r.sms = a.sms and r.ayear = a.ayear and r.EXPENSE_TYPE_CODE ='03' ) as RATE_3 ");
				reduceSql.append("FROM REGT004 a ");
				reduceSql.append("join syst001 b on a.REDUCE_TYPE = b.CODE and b.KIND = 'REDUCE_TYPE' ");
				reduceSql.append("WHERE a.audit_status = '1' AND a.AYEAR='"+Utility.dbStr(ht.get("AYEAR"))+"'  ");
				reduceSql.append("AND a.SMS='"+Utility.dbStr(ht.get("SMS"))+"'  ");
				reduceSql.append("AND a.STNO ='"+Utility.dbStr(rs.getString("STNO"))+"' ");
				
				rs2.executeQuery(reduceSql.toString());
				String dhv = "否";
				String reduce = "&nbsp;";
				double reduce_crd_fee_rate_1 = 0;
				double reduce_crd_fee_rate_2 = 0;
				double reduce_crd_fee_rate_3 = 0;
				
				String reduce_crd_fee_rate_s = "否";
				
				if(rs2.next())
				{
					String rt = rs2.getString("REDUCE_TYPE");
					if( rt.equals("07") ){
						dhv = "是";
					}
					
					reduce = rs2.getString("REDUCE_NAME");
					
					reduce_crd_fee_rate_1 = rs2.getDouble("RATE_1");
					reduce_crd_fee_rate_2 = rs2.getDouble("RATE_2");
					reduce_crd_fee_rate_3 = rs2.getDouble("RATE_3");
					
					if(reduce_crd_fee_rate_1 >= 1.0 && (reduce_crd_fee_rate_1 == reduce_crd_fee_rate_2) )
					{
						reduce_crd_fee_rate_s = "減免全部學分學雜費";
					}
					else
					{
						//學分
						String num = String.valueOf(reduce_crd_fee_rate_1);
						if(reduce_crd_fee_rate_1 >= 1.0)
						{
							reduce_crd_fee_rate_s = "減免全部學分費";
						}
						else if("0.67".equals(num))
						{	
							reduce_crd_fee_rate_s = "減免三分之二學分費";
						}
						else if(num.indexOf(".") != -1)
						{
							num = num.substring(num.indexOf(".") + 1,num.indexOf(".")+2);
							num = com.nou.UtilityX.getChtNum(Integer.parseInt(num));	
							reduce_crd_fee_rate_s = "減免十分之"+num+"學分費";
						}
						
						//學雜
						num = String.valueOf(reduce_crd_fee_rate_2);
						if(reduce_crd_fee_rate_2 >= 1.0)
						{
							reduce_crd_fee_rate_s = "減免全部學雜費";
						}
						else if("0.67".equals(num))
						{
							reduce_crd_fee_rate_s += "</br>減免三分之二學雜費";
						}
						else if(num.indexOf(".") != -1)
						{
							num = num.substring(num.indexOf(".") + 1,num.indexOf(".")+2);
							num = com.nou.UtilityX.getChtNum(Integer.parseInt(num));	
							reduce_crd_fee_rate_s += "</br>減免十分之"+num+"學雜費";
						}
						
					}
				}
	
				rowHt.put("reduce_crd_fee_rate_s", reduce_crd_fee_rate_s);
				rowHt.put("REDUCE", reduce);
				rowHt.put("DHAVE_MK", dhv);
	
				vt.add(rowHt);
			}
	
		}
		catch(Exception e)
		{
			throw e;
		}
		finally
		{
			if (rs != null)
				rs.close();
			if (rs2 != null)
				rs2.close();
		}
	}

}

