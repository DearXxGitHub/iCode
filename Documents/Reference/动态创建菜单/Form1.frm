VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3030
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   NegotiateMenus  =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   4560
   StartUpPosition =   3  '����ȱʡ
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Call CreateActiveMenu
End Sub

Sub CreateActiveMenu()
    Dim hMenu As Long, hSubMenu As Long
    Dim hPopMenuTmp As Long
    ReDim MenuText(0)
    
    hMenu = GetMenu(Me.hwnd) '���弶�˵����
    If hMenu = 0 Then
        '������û�в˵�ʱ�������˵������������������ƽ׶����ô����NegotiatMenu=False�˵�������ʾ������
        hMenu = CreateMenu()
    End If
    
    '��ӵ�0���˵�
    hSubMenu = hMenu
    FullAllSubMenu hSubMenu
    
    '��ӵ�1���˵�
    hSubMenu = GetSubMenu(hSubMenu, GetMenuItemCount(hSubMenu) - 1) '��ȡ���һ��0���˵��ľ��
    FullAllSubMenu hSubMenu
    
    '��ӵ�2���˵�
    hSubMenu = GetSubMenu(hSubMenu, GetMenuItemCount(hSubMenu) - 1)
    FullAllSubMenu hSubMenu
    
    '��ӵ�3���˵�
    hSubMenu = GetSubMenu(hSubMenu, GetMenuItemCount(hSubMenu) - 1)
    FullAllSubMenu hSubMenu
    
    SetMenu Me.hwnd, hMenu
    DrawMenuBar Me.hwnd
    Me.Refresh
    
    OldWinProc = SetWindowLong(Me.hwnd, GWL_WNDPROC, AddressOf OnMenu)
End Sub

Sub FullAllSubMenu(hFather As Long)
    '����ȫ���Ӳ˵�
    Dim hPopMenuTmp As Long
    Dim i As Integer
    hPopMenuTmp = CreatePopupMenu()
    For i = 0 To 4
        MenuCount = MenuCount + 1
        '����˵��ı������ڲ˵��¼�����ʱʶ�����ѡ��Ĳ˵�����
        ReDim Preserve MenuText(MenuCount)
        MenuText(MenuCount) = "�ļ�" & MenuCount
        '�����Ӳ˵�������ID>1000��˵����Ϊ�Զ����ɵĲ˵�
        AppendMenu1 hPopMenuTmp, MF_STRING, 1000 + MenuCount, MenuText(MenuCount)
        '����Ǽ���ߣ���wFlags=MF_SEPARATOR
        '���ҪCheck����wFlags=MF_STRING + MF_CHECKED��������ã����ټ�MF_GRAYED
    Next
    AppendMenu1 hFather, MF_POPUP, hPopMenuTmp, "&Files"
End Sub
