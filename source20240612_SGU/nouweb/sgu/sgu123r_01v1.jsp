<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01v1
Author			: Maggie
Description		: SGU123R_�ץX�s����[�l�k�W�U���- ��ܭ���
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<html>
<head>
	<%@ include file="/utility/viewpageinit.jsp"%>
	<script src="<%=vr%>script/framework/query3_1_0_2.jsp"></script>
	<script src="sgu123r_01c1.jsp"></script>
	<noscript>
		<p>�z���s�������䴩JavaScript�y�k�A���O�ä��v�T�z��������������e</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="�I����" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- �w�q�d�ߪ� Form �_�l -->
<form name="QUERY" method="post" onsubmit="doQuery();" style="margin:0,0,5,0;">
	<input type=hidden name="control_type">


	<!-- �d�ߥ��e���_�l -->
	<TABLE id="QUERY_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="�ƪ��Ϊ��">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_01.jpg" alt="�ƪ��ιϥ�" width="13" height="12"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_02.jpg" alt="�ƪ��ιϥ�" width="100%" height="12"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_03.jpg" alt="�ƪ��ιϥ�" width="13" height="12"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_search_04.jpg" alt="�ƪ��ιϥ�">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#C5E2C3">
				<!-- ���s�e���_�l -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
					<tr class="mtbGreenBg">
						<td align=left>�i�C�L�e���j</td>
						<td align=right>
							<div id="serach_btn">
								<input type=button class="btn" value='�M  ��' onclick='doReset();' onkeypress='doReset();'>
								<input type=button class="btn" value='��  �X' id="EXPORT_ALL_BTN" name='EXPORT_ALL_BTN' onclick='doExport()'>								
							</div>
						</td>
					</tr>
				</table>
				<!-- ���s�e������ -->

				<!-- �d�ߵe���_�l -->
				<table id="table1" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" summary="�ƪ��Ϊ��">
					<tr>
						<td align='right'>�Ǧ~��<font color=red>��</font>�G</td>
						<td><input type=text name='AYEAR'>
						    <select name='SMS'>
                                     <script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
                            </select>
                        </td>
					</tr>
				</table>
				<!-- �d�ߵe������ -->
			</td>
			<td width="13" background="<%=vr%>images/ap_search_06.jpg" alt="�ƪ��ιϥ�">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_07.jpg" alt="�ƪ��ιϥ�" width="13" height="13"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_08.jpg" alt="�ƪ��ιϥ�" width="100%" height="13"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_09.jpg" alt="�ƪ��ιϥ�" width="13" height="13"></td>
		</tr>
	</table>
	<!-- �d�ߥ��e������ -->
</form>
<!-- �w�q�d�ߪ� Form ���� -->

<!-- ���D�e���_�l -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="�ƪ��Ϊ��">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="�ƪ��ιϥ�">
						�@�@<span class="title">SGU123R_�ץX�s����[�l�k�W�U���</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align=left nowrap>
			<div id="page">
				<font color=purple><b>��ƻ����G</b></font><br>
				<font color=purple><b>�@�B�P�ɲ��X"��ҾǦ~���s����W�U"�B"���զb�y�s����W�U"�B"��ҾǦ~���s����l�k�W�U"��"���զb�y�s����l�k�W�U"�A���C���P�u�@��I</b></font><br>
				<font color=purple><b>�G�B�s�����ƧP�_�����Ҧr���Ĥ@�X�ư��@�Ӹ��X�D�Ʀr�A�ĤT�X '6', '7', '8', '9'���~�ӤH�f</b></font><br>
				<font color=purple><b></b></font><br>
				<font color=purple><b></b></font>
			</div>
		</td>
	</tr>
</table>
<!-- ���D�e������ -->

<script>
	document.write ("<font color=\"white\">" + document.lastModified + "</font>");
	window.attachEvent("onload", page_init);
	window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>