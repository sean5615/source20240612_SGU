<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r
Author			: Maggie
Description		: SGU123R_�ץX�s����[�l�k�W�U���- ��ܭ���
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
	// �w�]�Ǧ~��
		String	keyParam	=	"";
		MyLogger log = new MyLogger("SGU123R");
		DBManager db = new DBManager(log);
		SYSGETSMSDATA sys = new SYSGETSMSDATA(db);
		
		//���o�{�b�����,�ó]�w�bsys��
		java.util.Calendar cal = java.util.Calendar.getInstance();	
		SimpleDateFormat smipleDate = new SimpleDateFormat("yyyyMMdd");
		String nowDate = smipleDate.format(cal.getTime());
		sys.setSYS_DATE(nowDate);
		sys.setSMS_TYPE("1");  //1.��� 2.�e�� 3.��� 4.�e�Ǧ~ 5.��Ǧ~
		
		//�b�ѼƤ��[�J�Ǧ~,�Ǵ��Ѽ�
		int result = sys.execute();
		if(result==1)
		{
			String ayear = sys.getAYEAR();
			String sms = sys.getSMS();
			keyParam		= "?AYEAR="+ayear+"&SMS="+sms;
		}
		
		// �Ǵ�
		session.setAttribute("SGU123R_01_SELECT","NOU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='[KIND]' ORDER BY SELECT_VALUE");
	%>
	top.hideView();
	/** �ɦV�Ĥ@�ӳB�z������ */
	top.mainFrame.location.href	=	'sgu123r_01v1.jsp<%=keyParam%>';
</script>