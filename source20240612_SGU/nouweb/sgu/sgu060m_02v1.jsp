<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_02v1
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 編輯顯示頁面
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
    <script src="sgu060m_02c1.jsp"></script>
    <noscript>
        <p>您的瀏覽器不支援JavaScript語法，但是並不影響您獲取本網站的內容</p>
    </noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="背景圖" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 定義編輯的 Form 起始 -->
<form name="EDIT" method="post" onsubmit="doSave();" style="margin:5,0,0,0;">
    <input type=hidden name="control_type">
    <input type=hidden name="ROWSTAMP">

    <!-- 編輯全畫面起始 -->
    <TABLE id="EDIT_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="排版用表格">
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_01.gif" alt="排版用圖示" width="13" height="14"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_02.gif" alt="排版用圖示" width="100%" height="14"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_03.gif" alt="排版用圖示" width="13" height="14"></td>
        </tr>
        <tr>
            <td width="13" background="<%=vr%>images/ap_index_mtb_04.gif" alt="排版用圖示">　</td>
            <td width="100%" valign="top" bgcolor="#FFFFFF">
                <!-- 按鈕畫面起始 -->
                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
                    <tr class="mtbGreenBg">
                        <td align=left>【編輯畫面】- <span id='EditStatus'>新增</span></td>
                        <td align=right>
                            <div id="edit_btn">
                                <input type=button class="btn" value='回查詢頁' onkeypress='doBack();'onclick='doBack();'>
                                <input type=button name="ADD_BTN" class="btn" value='新  增' onkeypress='doAdd();'onclick='doAdd();'>
                                <input type=button class="btn" value='清  除' onkeypress='doClear();'onclick='doClear();'>
                                <input type=submit name="SAVE_BTN" class="btn" value='存  檔'>
                            </div>
                        </td>
                    </tr>
                </table>
                <!-- 按鈕畫面結束 -->

                <!-- 編輯畫面起始 -->
                <table id="table2" width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
                    <tr>
                        <td align='right' class='tdgl1'>學年期<font color=red>＊</font>：</td>
                        <td class='tdGrayLight'><input type=text name='AYEAR'>
                            <select name='SMS'>
                                <option value=''>請選擇</option>
                                <script>Form.getSelectFromPhrase("SGU060M_01_SELECT", null, null);</script>
                            </select>
                        </td>
                        <td align='right' class='tdgl1'>學號<font color=red>＊</font>：</td>
                        <td class='tdGrayLight' colspan='3'>
                        <input type='text' Column='STNO' name='STNO' onblur='Form.blurData("SGU060M_05_BLUR", "STNO", this.value, ["STNO", "NAME"], [_i("EDIT", "STNO"),_i("EDIT", "NAME")], true);'>
                        <input type=text Column='NAME' name='NAME' readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl2'>父親姓名<font color=red>＊</font>：</td>
                        <td class='tdGrayLight'>
                            <input type=text name='FATHER_NAME'>
                        </td>
                        <td align='right' class='tdgl2'>父親國別<font color=red>＊</font>：</td>
                        <td class='tdGrayLight' colspan='3'>
                            <select name='FATHER_ORIGINAL_COUNTRY'>
                                <option value=''>請選擇</option>
                                <script>Form.getSelectFromPhrase("SGU060M_02_SELECT", null, null);</script>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl2'>母親姓名<font color=red>＊</font>：</td>
                        <td class='tdGrayLight'>
                            <input type=text name='MOTHER_NAME'>
                        </td>
                        <td align='right' class='tdgl2'>母親國別<font color=red>＊</font>：</td>
                        <td class='tdGrayLight' colspan='3'>
                            <select name='MOTHER_ORIGINAL_COUNTRY'>
                                <option value=''>請選擇</option>
                                <script>Form.getSelectFromPhrase("SGU060M_02_SELECT", null, null);</script>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl1'>審查註記<font color=red>＊</font>：</td>
                        <td colspan='5' class='tdGrayLight'>
                            <input type="radio" value="3" name="AUDIT_MK">不通過<input type="radio" name="AUDIT_MK" value="2">通過</td>
                    </tr>
                </table>
                <!-- 編輯畫面結束 -->
            </td>
            <td width="13" background="<%=vr%>images/ap_index_mtb_06.gif" alt="排版用圖示">　</td>
        </tr>
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_07.gif" alt="排版用圖示" width="13" height="15"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_08.gif" alt="排版用圖示" width="100%" height="15"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_09.gif" alt="排版用圖示" width="13" height="15"></td>
        </tr>
    </table>
    <!-- 編輯全畫面結束 -->
</form>
<!-- 定義編輯的 Form 結束 -->

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
</table>
<!-- 標題畫面結束 -->

<script>
    document.write ("<font color=\"white\">" + document.lastModified + "</font>");
    window.attachEvent("onload", page_init);
    window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>