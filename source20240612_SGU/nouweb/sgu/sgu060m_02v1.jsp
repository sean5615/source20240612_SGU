<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_02v1
Author            : Jason
Description        : SGU060M_���@�s����l�k��� - �s����ܭ���
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
        <p>�z���s�������䴩JavaScript�y�k�A���O�ä��v�T�z��������������e</p>
    </noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="�I����" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- �w�q�s�誺 Form �_�l -->
<form name="EDIT" method="post" onsubmit="doSave();" style="margin:5,0,0,0;">
    <input type=hidden name="control_type">
    <input type=hidden name="ROWSTAMP">

    <!-- �s����e���_�l -->
    <TABLE id="EDIT_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="�ƪ��Ϊ��">
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_01.gif" alt="�ƪ��ιϥ�" width="13" height="14"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_02.gif" alt="�ƪ��ιϥ�" width="100%" height="14"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_03.gif" alt="�ƪ��ιϥ�" width="13" height="14"></td>
        </tr>
        <tr>
            <td width="13" background="<%=vr%>images/ap_index_mtb_04.gif" alt="�ƪ��ιϥ�">�@</td>
            <td width="100%" valign="top" bgcolor="#FFFFFF">
                <!-- ���s�e���_�l -->
                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
                    <tr class="mtbGreenBg">
                        <td align=left>�i�s��e���j- <span id='EditStatus'>�s�W</span></td>
                        <td align=right>
                            <div id="edit_btn">
                                <input type=button class="btn" value='�^�d�߭�' onkeypress='doBack();'onclick='doBack();'>
                                <input type=button name="ADD_BTN" class="btn" value='�s  �W' onkeypress='doAdd();'onclick='doAdd();'>
                                <input type=button class="btn" value='�M  ��' onkeypress='doClear();'onclick='doClear();'>
                                <input type=submit name="SAVE_BTN" class="btn" value='�s  ��'>
                            </div>
                        </td>
                    </tr>
                </table>
                <!-- ���s�e������ -->

                <!-- �s��e���_�l -->
                <table id="table2" width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
                    <tr>
                        <td align='right' class='tdgl1'>�Ǧ~��<font color=red>��</font>�G</td>
                        <td class='tdGrayLight'><input type=text name='AYEAR'>
                            <select name='SMS'>
                                <option value=''>�п��</option>
                                <script>Form.getSelectFromPhrase("SGU060M_01_SELECT", null, null);</script>
                            </select>
                        </td>
                        <td align='right' class='tdgl1'>�Ǹ�<font color=red>��</font>�G</td>
                        <td class='tdGrayLight' colspan='3'>
                        <input type='text' Column='STNO' name='STNO' onblur='Form.blurData("SGU060M_05_BLUR", "STNO", this.value, ["STNO", "NAME"], [_i("EDIT", "STNO"),_i("EDIT", "NAME")], true);'>
                        <input type=text Column='NAME' name='NAME' readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl2'>���˩m�W<font color=red>��</font>�G</td>
                        <td class='tdGrayLight'>
                            <input type=text name='FATHER_NAME'>
                        </td>
                        <td align='right' class='tdgl2'>���˰�O<font color=red>��</font>�G</td>
                        <td class='tdGrayLight' colspan='3'>
                            <select name='FATHER_ORIGINAL_COUNTRY'>
                                <option value=''>�п��</option>
                                <script>Form.getSelectFromPhrase("SGU060M_02_SELECT", null, null);</script>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl2'>���˩m�W<font color=red>��</font>�G</td>
                        <td class='tdGrayLight'>
                            <input type=text name='MOTHER_NAME'>
                        </td>
                        <td align='right' class='tdgl2'>���˰�O<font color=red>��</font>�G</td>
                        <td class='tdGrayLight' colspan='3'>
                            <select name='MOTHER_ORIGINAL_COUNTRY'>
                                <option value=''>�п��</option>
                                <script>Form.getSelectFromPhrase("SGU060M_02_SELECT", null, null);</script>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align='right' class='tdgl1'>�f�d���O<font color=red>��</font>�G</td>
                        <td colspan='5' class='tdGrayLight'>
                            <input type="radio" value="3" name="AUDIT_MK">���q�L<input type="radio" name="AUDIT_MK" value="2">�q�L</td>
                    </tr>
                </table>
                <!-- �s��e������ -->
            </td>
            <td width="13" background="<%=vr%>images/ap_index_mtb_06.gif" alt="�ƪ��ιϥ�">�@</td>
        </tr>
        <tr>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_07.gif" alt="�ƪ��ιϥ�" width="13" height="15"></td>
            <td width="100%"><img src="<%=vr%>images/ap_index_mtb_08.gif" alt="�ƪ��ιϥ�" width="100%" height="15"></td>
            <td width="13"><img src="<%=vr%>images/ap_index_mtb_09.gif" alt="�ƪ��ιϥ�" width="13" height="15"></td>
        </tr>
    </table>
    <!-- �s����e������ -->
</form>
<!-- �w�q�s�誺 Form ���� -->

<!-- ���D�e���_�l -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="�ƪ��Ϊ��">
    <tr>
        <td>
            <table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td background="<%=vr%>images/ap_index_title.jpg" alt="�ƪ��ιϥ�">
                        �@�@<span class="title">SGU060M_���@�s����l�k���</span>
                    </td>
                </tr>
            </table>
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