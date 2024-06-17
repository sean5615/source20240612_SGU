<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01v1
Author			: Maggie
Description		: SGU123R_匯出新住民暨子女名冊資料- 顯示頁面
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
		<p>您的瀏覽器不支援JavaScript語法，但是並不影響您獲取本網站的內容</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="背景圖" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 定義查詢的 Form 起始 -->
<form name="QUERY" method="post" onsubmit="doQuery();" style="margin:0,0,5,0;">
	<input type=hidden name="control_type">


	<!-- 查詢全畫面起始 -->
	<TABLE id="QUERY_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="排版用表格">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_01.jpg" alt="排版用圖示" width="13" height="12"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_02.jpg" alt="排版用圖示" width="100%" height="12"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_03.jpg" alt="排版用圖示" width="13" height="12"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_search_04.jpg" alt="排版用圖示">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#C5E2C3">
				<!-- 按鈕畫面起始 -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
					<tr class="mtbGreenBg">
						<td align=left>【列印畫面】</td>
						<td align=right>
							<div id="serach_btn">
								<input type=button class="btn" value='清  除' onclick='doReset();' onkeypress='doReset();'>
								<input type=button class="btn" value='匯  出' id="EXPORT_ALL_BTN" name='EXPORT_ALL_BTN' onclick='doExport()'>								
							</div>
						</td>
					</tr>
				</table>
				<!-- 按鈕畫面結束 -->

				<!-- 查詢畫面起始 -->
				<table id="table1" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" summary="排版用表格">
					<tr>
						<td align='right'>學年期<font color=red>＊</font>：</td>
						<td><input type=text name='AYEAR'>
						    <select name='SMS'>
                                     <script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
                            </select>
                        </td>
					</tr>
				</table>
				<!-- 查詢畫面結束 -->
			</td>
			<td width="13" background="<%=vr%>images/ap_search_06.jpg" alt="排版用圖示">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_07.jpg" alt="排版用圖示" width="13" height="13"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_08.jpg" alt="排版用圖示" width="100%" height="13"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_09.jpg" alt="排版用圖示" width="13" height="13"></td>
		</tr>
	</table>
	<!-- 查詢全畫面結束 -->
</form>
<!-- 定義查詢的 Form 結束 -->

<!-- 標題畫面起始 -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="排版用表格">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="排版用圖示">
						　　<span class="title">SGU123R_匯出新住民暨子女名冊資料</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align=left nowrap>
			<div id="page">
				<font color=purple><b>資料說明：</b></font><br>
				<font color=purple><b>一、同時產出"選課學年期新住民名冊"、"全校在籍新住民名冊"、"選課學年期新住民子女名冊"及"全校在籍新住民子女名冊"，分列不同工作表！</b></font><br>
				<font color=purple><b>二、新住民資料判斷身分證字號第一碼排除護照號碼非數字，第三碼 '6', '7', '8', '9'為外來人口</b></font><br>
				<font color=purple><b></b></font><br>
				<font color=purple><b></b></font>
			</div>
		</td>
	</tr>
</table>
<!-- 標題畫面結束 -->

<script>
	document.write ("<font color=\"white\">" + document.lastModified + "</font>");
	window.attachEvent("onload", page_init);
	window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>