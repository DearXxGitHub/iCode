VERSION 5.00
Begin VB.UserControl TipsBar 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00F2F2F2&
   ClientHeight    =   2085
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6660
   ForeColor       =   &H00585858&
   ScaleHeight     =   139
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   444
   Begin VB.PictureBox XImg 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   2820
      ScaleHeight     =   17
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   4
      Top             =   1260
      Width           =   315
   End
   Begin VB.PictureBox XImg 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   2280
      ScaleHeight     =   17
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   3
      Top             =   1260
      Width           =   315
   End
   Begin VB.PictureBox XButton 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   1140
      ScaleHeight     =   17
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   2
      Top             =   1260
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.PictureBox Tip 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      FillColor       =   &H00CFCFCF&
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   120
      ScaleHeight     =   15
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   55
      TabIndex        =   1
      Top             =   1260
      Width           =   855
   End
   Begin VB.Timer Timer_Cursor 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3900
      Top             =   1260
   End
   Begin VB.PictureBox XImg 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1800
      ScaleHeight     =   17
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   0
      Top             =   1260
      Width           =   315
   End
   Begin VB.Timer Timer1 
      Left            =   3360
      Top             =   1260
   End
   Begin VB.Menu mnuTipsBar 
      Caption         =   "TipsBar"
      Visible         =   0   'False
      Begin VB.Menu mnuCloseThis 
         Caption         =   "�رմ˱�ǩ(&T)"
      End
      Begin VB.Menu mnuCloseOthers 
         Caption         =   "�ر�������ǩ(&E)"
      End
      Begin VB.Menu mnuCloseLeft 
         Caption         =   "�ر�����ǩ(&L)"
      End
      Begin VB.Menu mnuCloseRight 
         Caption         =   "�ر��Ҳ��ǩ(&R)"
      End
      Begin VB.Menu mnuCloseAll 
         Caption         =   "�ر����б�ǩ(&A)"
      End
      Begin VB.Menu mnuLine1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuShuiPing 
         Caption         =   "ˮƽƽ��(&H)"
      End
      Begin VB.Menu mnuChuiZhi 
         Caption         =   "��ֱƽ��(&V)"
      End
      Begin VB.Menu mnuCengDie 
         Caption         =   "���(&C)"
      End
   End
End
Attribute VB_Name = "TipsBar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Type POINTAPI
        x As Long
        y As Long
End Type
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long

'�û���������TipClick��TipClose�¼��������Զ��л�����/�Ƴ���ǩ
Event TipClick(ByVal ID As Long)
Event TipClose(ByVal ID As Long)
Event mnuCengDie()
Event mnuShuiPing()
Event mnuChuiZhi()



Private Const Dis_DefultFirstTip = 5   '��һ����ǩ��UserControl.Left��Ĭ��ˮƽ����
Private Const Dis_TextBorder_X = 10    '������Tip.Left\Rightˮƽ����
'Private Const Dis_TextBorder_Y = 4     '������Tip.Top\Bottom��ֱ����

Private Const Dis_XButton_Cut = 8      'XButton��Tip�ص���ˮƽ����
Private Const Dis_XButton_Middle_X = 8 '"X"�����Դ˳���Ϊ����X�������,XButton�Ҳ�հ׳��ȿ�ͨ���ؼ�����
Private Const Dis_XButton_R = 7        '"X"�����ײ�Բ�ΰ뾶
Private Const Dis_XButton_L = 3        '"X"������������εı߳���һ��

'Tip����ɫ
Private Const Color_Back_Normal = &HF2F2F2
Private Const Color_Back_Active = vbWhite
Private Const Color_Back_Point = &HF6F6F6
'Tip����ǰ��ɫ
Private Const Color_Fonts_Active = &H333333
Private Const Color_Fonts_Normal = &H585858



'"X"������ɫ
Private Const Color_X = &HB6B6B6

'"X"�����ײ�Բ�α�����ɫ
Private Const Color_XButton_BackColor = &HF2F2F2
Private Const Color_XButton_BackColor_Pressed = &HE0E0E0

Private Enum TB_X_Style
    Normal = 0   'һ��״̬
    Active = 1   'ָ��ָ��״̬
    Pressed = 2  '��갴�µ�δ����״̬
End Enum
Private X_State As TB_X_Style




Private Const Timer_Interval = 30    'Timer����,����Tip�ƶ�Ч���Ƿ�����(����Ϊ��)
Private Const Timer_TotalTime = 150  'Tip�ƶ�Ч����ʱ��

Private Enum TB_Drag_States
    Drag_None = 0           'û�а���������(��ʼ�϶�)
    Drag_Pressed = 1        '������������,������δ�����϶�����
    Drag_ing = 2            '�϶���,Tip������ƶ�
End Enum
Private Drag_State As TB_Drag_States

Private Const Drag_StartValue = 25   '�����϶������������СX�����ƶ���(����ڽ���Drag_Pressed״̬ʱ)

Private Drag_ID As Long          '���ڱ��϶���Tip��ID,δ�϶�ʱ������
Private Drag_CursorLeft As Long  '����Drag_Pressed״̬ʱ,���X����,�����жϽ���Drag_ing״̬
Private Drag_ID_Left As Long     '����Drag_Pressed״̬ʱ,�����Drag_Tip.Left�ľ���,����Drag_ing״̬ʱTip���ƶ�


'�������ŵ�Լ��:
'ID(UID\ActiveID\PointID\Drag_ID):��Ϊ"�ؼ�ID",ʵ�ʲ����ؼ����ñ��,UID��������,Tip���ٺ���ID�಻��ʹ��,��Ӧ����UID
'Queue(i):Ŀǰ�����Ҹ���Tip��Ӧ��ID,��Ӧ����Count

Private UID As Long
Private aCaption(3000) As String '����
Private Queue(300) As Long, Count As Long

Public ActiveID As Long     '����ID,����Ӵ�,����ΪColor_Back_Active,����XButton
Public PointID As Long      'ָ��ID,����ΪColor_Back_Point

Private mnuClickID As Long  '�����˵�ʱ���ָ���TipID

Private FirstTipLeft As Long


'����ڶ���Ч��������˼·:

'Ϊ�˱�֤������,����Ч�������ܼ�Ѹ��

'Drag_Swap\Drag_Drop����������,ֱ�ӽ���Queue��,��Ҫչʾ����Ч����ID��ֵ��Timer_ID,������������
'�����;��һ�˶���Ҫ��ʼ����,ֱ��ִ��Adjust����,���������е�Tip������λ

'����˵,Tip��Ų����������,����Ч����������,��ʹ�����,����Ӱ������Tip�Ų�

Private Timer_ID As Long                                  '�������ж���Ч����Timer_ID
Private Timer_Time As Long                                '������ʱ��
Private Timer_StartValue As Long, Timer_EndValue As Long  '��ʼ\��������

Public MouseInside As Boolean '��¼����Ƿ���UserControl��

Private Sub UserControl_Initialize()
    FirstTipLeft = Dis_DefultFirstTip
    Timer1.Interval = Timer_Interval
    Timer1.Enabled = False
End Sub

Private Sub UserControl_Resize()
    '���¹�������UserControl.ScaleHeight�����ɷ���Initialize������
    XButton.Top = 0
    XButton.Width = XImg(0).Width
    XButton.Height = UserControl.ScaleHeight
    PrepareXImg
End Sub


Private Sub Timer_Start(ByVal ID As Long, ByVal StartValue As Long, ByVal EndValue As Long)
    Timer_ID = ID
    Timer_StartValue = StartValue
    Timer_EndValue = EndValue
    Timer_Time = 0
    Timer1.Enabled = True
End Sub

Private Sub ChangePointID(ByVal ID As Long)
    If PointID <> ActiveID And PointID <> 0 Then
        If Tip(PointID).BackColor <> Color_Back_Normal Then
            DrawTip PointID, Color_Back_Normal, Tip(PointID).ForeColor, Tip(PointID).FontBold
        End If
    End If
    If ID Then
        If ID <> ActiveID Then
            If Tip(ID).BackColor <> Color_Back_Point Then
                DrawTip ID, Color_Back_Point, Tip(ID).ForeColor, Tip(ID).FontBold
            End If
        End If
    End If
    PointID = ID
End Sub

'������Ƿ��Ƴ�UserControl��Timer
Private Sub Timer_Cursor_Timer()
    Dim pt As POINTAPI
    If GetCursorPos(pt) <> 0 Then
        ScreenToClient UserControl.hWnd, pt
        If pt.x < 0 Or pt.x > UserControl.ScaleWidth Or pt.y < 0 Or pt.y > UserControl.ScaleHeight Then
            MouseInside = False
            If Drag_State = Drag_ing Then
                Drag_Drop pt.x
            End If
            ChangePointID 0
            If X_State <> Normal Then
                XButton.Picture = XImg(TB_X_Style.Normal).Image
                X_State = Normal
            End If
            Timer_Cursor.Enabled = False
        End If
    End If
End Sub

'�����ƶ�������Timer
Private Sub Timer1_Timer()
    Timer_Time = Timer_Time + Timer_Interval
    If Timer_Time >= Timer_TotalTime Then
        SetTipLeft Timer_ID, Timer_EndValue
        Timer1.Enabled = False
        Timer_ID = 0
    Else
        SetTipLeft Timer_ID, Timer_StartValue + (Timer_EndValue - Timer_StartValue) * Timer_Time / Timer_TotalTime
    End If
End Sub

'����Tip.Left,�Լ�XButton.Left
Private Sub SetTipLeft(ByVal ID As Long, ByVal Left As Long)
    Tip(ID).Left = Left
    If ActiveID = ID Then
        XButton.Left = Tip(ID).Left + Tip(ID).Width - Dis_XButton_Cut - 1
    End If
End Sub

'����Queue����Ԫ�أ���������Drag_ID(��UserControl_MouseMove�¼�����)��IDToAdjust������,�����غ�������(����Timer����)
Private Function Adjust(Optional ByVal IDToAdjust As Long) As Long

    If Count = 0 Then Exit Function '�������pʱ����ֳ���Ϊ0

    Dim l As Long
    l = FirstTipLeft
    
    Dim i As Long, w As Long, p As Double
    
    '������ȫ��ʾ,ͳ���ܳ���
    For i = 1 To Count
        w = w + Tip(Queue(i)).TextWidth(aCaption(Queue(i))) + Dis_TextBorder_X * 2 - 1
    Next
    If ActiveID <> 0 Then w = w - Dis_XButton_Cut + XButton.Width - 1
    
    '���������ȫ��ʾ,����ٷֱ���С,����ٷֱ�Ϊ1
    p = CDbl(UserControl.ScaleWidth) / CDbl(w)
    If p > 1 Then p = 1
    
    For i = 1 To Count
        SetTipWidth Queue(i), p
        If Queue(i) = IDToAdjust Then
            Adjust = l
        ElseIf Drag_State <> Drag_ing Or Queue(i) <> Drag_ID Then
            SetTipLeft Queue(i), l
        End If
        l = l + Tip(Queue(i)).Width - 1 '�г�(����)��߽�
        If Queue(i) = ActiveID Then l = l - Dis_XButton_Cut + XButton.Width - 1 '����XButton�����߿򣬲�����һ���ǰ�߿�
    Next
    
End Function

'����Tips.Width(�ڼ�����漰Tip�ػ�)
Private Sub SetTipWidth(ByVal ID As Long, ByVal Precentage As Double)
    Dim t As Long
    t = (Tip(ID).TextWidth(aCaption(ID)) * Precentage) + Dis_TextBorder_X * 2
    If t <> Tip(ID).Width Then
        Tip(ID).Width = t
        DrawTip ID, Tip(ID).BackColor, Tip(ID).ForeColor, Tip(ID).FontBold
    End If
End Sub

'Tip�ػ�
Public Sub DrawTip(ByVal ID As Long, ByVal BackColor As Long, ByVal ForeColor As Long, ByVal Bold As Boolean)
    With Tip(ID)
        .Cls
        .BackColor = BackColor
        .ForeColor = ForeColor
        .FontBold = Bold
        .CurrentX = Dis_TextBorder_X
        .CurrentY = (.ScaleHeight - .TextHeight(aCaption(ID))) / 2
        Tip(ID).Print aCaption(ID)
    End With
End Sub

Public Sub Activate(ByVal ID As Long)

    If ID <= 0 Or ID > UID Or ID = ActiveID Then Exit Sub
    
    If ActiveID <> 0 Then
        DrawTip ActiveID, Color_Back_Normal, Color_Fonts_Normal, False
    End If
    
    DrawTip ID, Color_Back_Active, Color_Fonts_Active, True
    
    ActiveID = ID
    DoEvents
    Adjust
    
    XButton.Picture = XImg(TB_X_Style.Normal).Image
    XButton.ZOrder 0
    
End Sub

Public Sub Add(ByVal Caption As String, ByVal Key As Long, Optional ByVal Active As Boolean = True)
    
    Count = Count + 1
    
    UID = UID + 1
    Load Tip(UID)

    aCaption(UID) = Caption

    With Tip(UID)
    
        .Top = -1
        .Height = UserControl.ScaleHeight + 2
        
        .Visible = True
        
        .Tag = Key
        
    End With
    
    Queue(Count) = UID
    
    If Active Then
        Activate UID
    Else
        DrawTip UID, Color_Back_Normal, Color_Fonts_Normal, False
        Adjust
    End If
    
    XButton.Visible = True
    XButton.ZOrder 0
    
End Sub

Public Sub Remove(ByVal ID As Long)
    
    If PointID = ID Then
        PointID = 0
    End If
    If ActiveID = ID Then
        ActiveID = 0
        If NextID(ID) <> 0 Then
            Activate NextID(ID)
        ElseIf PreviousID(ID) <> 0 Then
            Activate PreviousID(ID)
        End If
    End If
    
    'ת�Ƽ�����Ҫ�õ�Queue()��Unload����
    
    Unload Tip(ID)
    
    Dim i As Long
    For i = GetQueue(ID) To Count - 1
        Queue(i) = Queue(i + 1)
    Next
    Count = Count - 1
    
    XButton.Visible = (Count > 0)
    
    Adjust
    
End Sub

Private Property Get GetQueue(ByVal ID As Long)
    Dim i As Long
    For i = 1 To Count
        If Queue(i) = ID Then
            GetQueue = i
            Exit For
        End If
    Next
End Property

Public Property Get NextID(ByVal ID As Long)
    Dim i As Long
    i = GetQueue(ID)
    If i < Count Then NextID = Queue(i + 1)
End Property

Public Property Get PreviousID(ByVal ID As Long)
    Dim i As Long
    i = GetQueue(ID)
    If i > 1 Then PreviousID = Queue(i - 1)
End Property

Private Sub Drag_Start(ByVal x As Long)

    Drag_State = Drag_ing
    
    SetTipLeft Drag_ID, x - Drag_CursorLeft
    
    '�ƶ����ö�
    Tip(Drag_ID).ZOrder 0
    If Drag_ID = ActiveID Then XButton.ZOrder 0
    
End Sub

Private Sub Drag_Swap(ByVal ID As Long)
    
    Dim NowLeft As Long
    NowLeft = Adjust(ID)
    
    Dim a As Long, b As Long
    a = GetQueue(Drag_ID)
    b = GetQueue(ID)
    Queue(a) = ID
    Queue(b) = Drag_ID
    
    Dim NewLeft As Long
    NewLeft = Adjust(ID)
    
    Timer_Start ID, NowLeft, NewLeft
    
End Sub

Private Sub Drag_Drop(ByVal x As Long)

    Timer_Start Drag_ID, x - Drag_CursorLeft, Adjust(Drag_ID)

    Drag_State = Drag_None
    Drag_ID = 0
    
End Sub

Private Sub Tip_MouseDown(ID As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = vbLeftButton Then
        If Drag_State = Drag_None And Timer_ID = 0 Then
            Drag_State = Drag_Pressed
            Drag_ID = ID
            Drag_ID_Left = Adjust(ID)
            Drag_CursorLeft = x
        End If
    End If
End Sub

Private Sub Tip_MouseMove(ID As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    If Drag_State = Drag_None Then
        If PointID <> ID Then
            ChangePointID ID
        End If
    Else
        '��Drag_State<>Drag_Noneʱ,ͳһת��UserControl����,�Ա㴦���Tip�ƶ����,��ͬ
        Call UserControl_MouseMove(Button, Shift, Tip(ID).Left + x, Tip(ID).Top + y)
    End If
    If X_State <> Normal Then
        XButton.Picture = XImg(TB_X_Style.Normal).Image
        X_State = Normal
    End If
End Sub

Private Sub Tip_MouseUp(ID As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    If x > Tip(ID).ScaleWidth Or y > Tip(ID).ScaleHeight Then Exit Sub
    If Drag_State <> Drag_ing Then
        If Button = vbLeftButton Then
            RaiseEvent TipClick(ID)
        ElseIf Button = vbRightButton Then
            If PointID <> ID Then
                ChangePointID ID
            End If
            mnuClickID = ID
            UserControl.PopupMenu mnuTipsBar
            mnuCloseThis.Visible = True
            mnuCloseOthers.Visible = True
            mnuCloseLeft.Visible = True
            mnuCloseRight.Visible = True
            mnuCloseAll.Visible = True
        End If
        Drag_State = Drag_None
        Drag_ID = 0
    Else
        Call UserControl_MouseUp(Button, Shift, Tip(ID).Left + x, Tip(ID).Top + y)
    End If
End Sub

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    If MouseInside = False Then
        Timer_Cursor.Enabled = True
        MouseInside = True
    End If
    If Drag_State = Drag_None Then
        If X_State <> Normal Then
            XButton.Picture = XImg(TB_X_Style.Normal).Image
            X_State = Normal
        End If
        ChangePointID 0
    ElseIf Drag_State = Drag_Pressed Then
        If Abs((x - Drag_CursorLeft) - Drag_ID_Left) > Drag_StartValue Then
            Drag_Start x
        End If
    Else
        SetTipLeft Drag_ID, x - Drag_CursorLeft
        Dim NID As Long, PID As Long
        NID = NextID(Drag_ID): PID = PreviousID(Drag_ID)
        If NID <> 0 And x > Tip(NID).Left + Tip(NID).Width * 0.5 Then
            Drag_Swap NID
        ElseIf PID <> 0 And x < Tip(PID).Left + Tip(PID).Width * 0.5 Then
            Drag_Swap PID
        End If
    End If
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = vbRightButton Then
        UserControl.PopupMenu mnuTipsBar
        mnuCloseThis.Visible = False
        mnuCloseOthers.Visible = False
        mnuCloseLeft.Visible = False
        mnuCloseRight.Visible = False
        mnuCloseAll.Visible = True
    Else
        If Drag_State = Drag_ing Then
            Drag_Drop x
        End If
    End If
End Sub

Private Sub XButton_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    XButton.Picture = XImg(TB_X_Style.Pressed).Image
End Sub

Private Sub XButton_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Drag_State <> Drag_ing Then
        If X_State = Normal Then
            XButton.Picture = XImg(TB_X_Style.Active).Image
            X_State = Active
        End If
        
        ChangePointID 0
    End If
End Sub

Private Sub XButton_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Drag_State <> Drag_ing Then
        XButton.Picture = XImg(TB_X_Style.Normal).Image
        X_State = Normal
        RaiseEvent TipClose(ActiveID)
    End If
End Sub




'�������"X"ͼ��,����XButton���ұ߽�
Private Sub PrepareXImg()

    Dim i As Long
    For i = 0 To 2
    
        XImg(i).Width = XButton.Width
        XImg(i).Height = XButton.Height
        XImg(i).BackColor = Color_Back_Active
        
        Dim BK As Long, x As Long, y As Long
    
        Select Case i
        Case TB_X_Style.Normal
            BK = Color_Back_Active
        Case TB_X_Style.Active
            BK = Color_XButton_BackColor
        Case TB_X_Style.Pressed
            BK = Color_XButton_BackColor_Pressed
        End Select
        
        With XImg(i)
        
            x = Dis_XButton_Middle_X
            y = .ScaleHeight / 2
            
            .FillStyle = 0
            .FillColor = BK
            XImg(i).Circle (x, y), Dis_XButton_R, BK
            .FillStyle = 1
                
            .DrawWidth = 2
            XImg(i).Line (x - Dis_XButton_L, y - Dis_XButton_L)-(x + Dis_XButton_L, y + Dis_XButton_L), Color_X
            XImg(i).Line (x - Dis_XButton_L, y + Dis_XButton_L)-(x + Dis_XButton_L, y - Dis_XButton_L), Color_X
            .DrawWidth = 1
        
            XImg(i).Line (.ScaleWidth - 1, -2)-(.ScaleWidth - 1, .ScaleHeight), &H80000006
        
            .Refresh
            
        End With
        
    Next
    
End Sub

Public Property Get Key(ByVal ID As Long) As Long
    On Error Resume Next
    Key = Tip(ID).Tag
End Property

Public Function FindIDByKey(ByVal Key As Long) As Long
    FindIDByKey = -1
    Dim i As Long
    For i = 1 To Count
        If CLng(Tip(Queue(i)).Tag) = Key Then
            FindIDByKey = Queue(i)
            Exit For
        End If
    Next
End Function




Public Property Get hWnd() As Long
Attribute hWnd.VB_Description = "����һ�������(from Microsoft Windows)һ������Ĵ��ڡ�"
    hWnd = UserControl.hWnd
End Property

Private Sub mnuCengDie_Click()
    RaiseEvent mnuCengDie
End Sub

'����Target()������ɾ��������Queue�䶯���������¼�������ͬ���Բ�ǿ��
'����ר��mnuClickID������ɾ��������PointID�䶯��������

Private Sub mnuCloseAll_Click()
    On Error Resume Next
    
    Dim i As Long, j As Long
    j = Count
    
    If j >= 1 Then
    
        Dim Target() As Long
        ReDim Target(1 To j)
        
        For i = 1 To j
            Target(i) = Queue(i)
        Next
        
        For i = 1 To j
            RaiseEvent TipClose(Target(i))
            DoEvents
        Next
        
    End If
End Sub

Private Sub mnuCloseLeft_Click()

    On Error Resume Next
    
    Dim i As Long, j As Long
    j = GetQueue(mnuClickID) - 1
    
    If j >= 1 Then
    
        Dim Target() As Long
        ReDim Target(1 To j)
        
        For i = 1 To j
            Target(i) = Queue(i)
        Next
        
        For i = 1 To j
            RaiseEvent TipClose(Target(i))
            DoEvents
        Next
        
    End If
    
End Sub

Private Sub mnuCloseOthers_Click()
    mnuCloseRight_Click
    mnuCloseLeft_Click
End Sub

Private Sub mnuCloseRight_Click()

    On Error Resume Next
    
    Dim i As Long, j As Long, k As Long
    j = GetQueue(mnuClickID) + 1
    k = Count
    
    If k >= j Then
    
        Dim Target() As Long
        ReDim Target(j To k)
        
        For i = j To k
            Target(i) = Queue(i)
        Next
        
        For i = j To k
            RaiseEvent TipClose(Target(i))
            DoEvents
        Next
        
    End If
    
End Sub

Private Sub mnuCloseThis_Click()
    RaiseEvent TipClose(PointID)
End Sub

Private Sub mnuShuiPing_Click()
    RaiseEvent mnuShuiPing
End Sub

Private Sub mnuChuiZhi_Click()
    RaiseEvent mnuChuiZhi
End Sub


