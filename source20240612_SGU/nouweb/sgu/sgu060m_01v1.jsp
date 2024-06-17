<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_01v1
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 顯示頁面
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<html>
<head>
    <%@ include file="/utility/viewpageinit.jsp"%>
    <script src="<%=vr%>script/framework/query1_2_0_2.jsp"></script>
    <script src="sgu060m_01c1.jsp"></script>
    <noscript>
        <p>您的瀏覽器不支援JavaScript語法，但是並不影響您獲取本網站的內容</p>
    </noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="背景圖" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 定義查詢的 Form 起始 -->
<form name="QUERY" method="post" onsubmit="doQuery();" style="margin:0,0,5,0;">
    <input type=hidden name="control_type">
    <input type=hidden name="pageSize">
    <input type=hidden name="pageNo">
    <input type=hidden name="EXPORT_FILE_NAME">
    <input type=hidden name="EXPORT_COLUMN_FILTER">

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
                        <td align=left>【查詢畫面】</td>
                        <td align=right>
                            <div id="serach_btn">
                                <input type=button class="btn" value='招生資料批次寫入' name='RT1_BTN' onclick="doSolBatchAdd();">
                                <input type=button name="ADD_BTN" class="btn" value='新  增' onkeypress='doAdd();'onclick='doAdd();'>
                                <input type=button class="btn" value='清  除' onkeypress="doReset();"onclick="doReset();">
                                <input type=submit class="btn" value='查  詢' name='QUERY_BTN'>
                            </div>
                        </td>
                    </tr>
                </table>
                <!-- 按鈕畫面結束 -->

                <!-- 查詢畫面起始 -->
                <table id="table1" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" summary="排版用表格">
                    <tr>
                        <td align='right'>學年期<font color=red></font>：</td>
                        <td><input type=text name='AYEAR'>
                            <select name='SMS'>
                                <option value=''>請選擇</option>
                                <script>Form.getSelectFromPhrase("SGU060M_01_SELECT", null, null);</script>
                            </select>
                        </td>
                        <td align='right'>學號：</td>
                        <td colspan='3'>
                        <input type='text' Column='STNO' name='STNO' onblur='Form.blurData("SGU060M_05_BLUR", "STNO", this.value, ["STNO", "NAME"], [_i("QUERY", "STNO"),_i("QUERY", "NAME")], true);'>
                        <input type=text Column='NAME' name='NAME' readonly>
                        </td>
                        <td align='right'>中心：</td>
                        <td>
                            <select name='CENTER_CODE'>
                                <script>Form.getSelectFromPhrase("SGU060M_09_SELECT", null, null);</script>
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
                        　　<span class="title">SGU060M_維護新住民子女資料</span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
		<td align=left nowrap>
			<div id="page">
				<font color=purple><b>程式說明：1.招生資料查詢條件，學籍狀態為[在籍生]，招生中心審核通過尚未寫入學務系統之學生資料。<br>
									　　　　　2.執行招生批次，學年期資料為必填欄位。</b></font><br>
			</div>
		</td>
	</tr>
</table>
<!-- 標題畫面結束 -->

<!-- 定義查詢結果的 Form 起始 -->
<form name="RESULT" method="post" style="margin:10,0,0,0;">
    <input type=hidden name="control_type">
    <input type=hidden keyColumn="Y" name="AYEAR">
    <input type=hidden keyColumn="Y" name="SMS">
    <input type=hidden keyColumn="Y" name="STNO">

    <!-- 查詢結果畫面起始 -->
    <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="排版用表格">
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_01.gif" alt="排版用圖示" width="13" height="14"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_02.gif" alt="排版用圖示" width="100%" height="14"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_03.gif" alt="排版用圖示" width="13" height="14"></td>
        </tr>
        <tr>
            <td width="13" background="<%=vr%>images/ap_index_mtb_04.gif" alt="排版用圖示">&nbsp;</td>
            <td width="100%" bgcolor="#FFFFFF">
                <table width="100%" border="0" cellspacing="0" cellpadding="2" summary="排版用表格">
                    <tr>
                        <!-- 查詢結果按鈕起始 -->
                        <td align=left>
                            <input type=button class="btn" value='全    選' name="SELALL_BTN" onkeypress="Form.setCheckBox(1, 'RESULT');"onclick="Form.setCheckBox(1, 'RESULT');">
                            <input type=button class="btn" value='全 不 選' name="SELNONE_BTN" onkeypress="Form.setCheckBox(0, 'RESULT');"onclick="Form.setCheckBox(0, 'RESULT');">
                            <input type=button class="btn" value='刪    除' name="DEL_BTN" onkeypress="doDelete('multi');"onclick="doDelete('multi');">
                        </td>
                        <!-- 查詢結果按鈕結束 -->

                        <!-- 分頁字串起始 -->
                        <td align=right nowrap>
                            <div id="page">
                                <b>
                                    <span id="pageStr"></span>
                                    【<input type='text' name='_scrollSize' size=2 value='10' style="text-align:center">
                                    <input type=button value='筆' onkeypress="setPageSize();"onclick="setPageSize();">
                                    <input type='text' name='_goToPage' size=2 value='1' style="text-align:right">
                                    / <span id="totalPage"></span> <input type=button value='頁' onkeypress='gotoPage(null)'onclick='gotoPage(null)'>
                                    <span id="totalRow">0</span> 筆】

                                </b>
                            </div>
                        </td>
                        <!-- 分頁字串結束 -->
                    </tr>
                </table>
                <!-- 查詢結果功能畫面起始 -->
                <div id="grid-scroll" style="overflow:auto;width:100%;height:300;"></div>
                <input type=hidden name='EXPORT_FILE_NAME'>
                <textarea name='EXPORT_CONTENT' cols=80 rows=3 style='display:none'></textarea>
                <textarea name='ALL_CONTENT' cols=80 rows=3 style='display:none'></textarea>
                <!-- 查詢結果功能畫面結束 -->
            </td>
            <td width="13" background="<%=vr%>images/ap_index_mtb_06.gif" alt="排版用圖示">&nbsp;</td>
        </tr>
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_07.gif" alt="排版用圖示" width="13" height="15"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_08.gif" alt="排版用圖示" width="100%" height="15"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_09.gif" alt="排版用圖示" width="13" height="15"></td>
        </tr>
    </table>
    <!-- 查詢結果畫面結束 -->
</form>
<!-- 定義查詢結果的 Form 結束 -->

<script>
    document.write ("<font color=\"white\">" + document.lastModified + "</font>");
    window.attachEvent("onload", page_init);
    window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>