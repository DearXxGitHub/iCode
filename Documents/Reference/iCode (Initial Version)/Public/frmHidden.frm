VERSION 5.00
Object = "{0E59F1D2-1FBE-11D0-8FF2-00A0D10038BC}#1.0#0"; "msscript.ocx"
Begin VB.Form HiddenForm 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8535
   ClientLeft      =   150
   ClientTop       =   840
   ClientWidth     =   10965
   BeginProperty Font 
      Name            =   "����"
      Size            =   9.75
      Charset         =   134
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   569
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   731
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '����ȱʡ
   Begin MSScriptControlCtl.ScriptControl CQ_SC 
      Left            =   660
      Top             =   4200
      _ExtentX        =   1005
      _ExtentY        =   1005
   End
   Begin iCode_Project.TipsBar TipsBar 
      Height          =   270
      Left            =   360
      Top             =   300
      Width           =   3285
      _ExtentX        =   5794
      _ExtentY        =   476
   End
   Begin VB.Timer EH_timerErrorBox 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   180
      Top             =   2400
   End
   Begin VB.Timer FW_timerFileWindow 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4.91505e5
      Top             =   465
   End
   Begin VB.Timer Code_timerSortMouseKeyEvents 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   2010
      Top             =   2370
   End
   Begin VB.PictureBox cCodeGo 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   3390
      ScaleHeight     =   20
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   20
      TabIndex        =   5
      Top             =   2340
      Width           =   300
      Begin VB.CommandButton CodeGo 
         Enabled         =   0   'False
         Height          =   300
         Left            =   0
         Picture         =   "frmHidden.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   0
         Width           =   300
      End
   End
   Begin VB.PictureBox cCodeToCommand 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   270
      ScaleHeight     =   20
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   50
      TabIndex        =   3
      Top             =   1680
      Width           =   750
      Begin VB.CommandButton CodeToCommand 
         Caption         =   "��ͨ��"
         Height          =   300
         Left            =   0
         TabIndex        =   4
         Top             =   0
         Width           =   750
      End
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   28140
      ScaleHeight     =   33
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   0
      TabIndex        =   2
      Top             =   555
      Width           =   0
   End
   Begin VB.PictureBox cCodeBack 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   420
      ScaleHeight     =   20
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   20
      TabIndex        =   0
      Top             =   1290
      Width           =   300
      Begin VB.CommandButton CodeBack 
         Enabled         =   0   'False
         Height          =   300
         Left            =   0
         Picture         =   "frmHidden.frx":0344
         Style           =   1  'Graphical
         TabIndex        =   1
         Top             =   0
         Width           =   300
      End
   End
   Begin VB.Menu mnuTipsBar 
      Caption         =   "Tips"
      Begin VB.Menu mnuTipsClose 
         Caption         =   "�رձ�ǩ(&C)"
      End
      Begin VB.Menu mnuTipsCloseOther 
         Caption         =   "�ر�����(&O)"
      End
      Begin VB.Menu mnuTipsCloseLeft 
         Caption         =   "�ر�����ǩ(&L)"
      End
      Begin VB.Menu mnuTipsCloseRight 
         Caption         =   "�ر��Ҳ��ǩ(&R)"
      End
      Begin VB.Menu mnuLine7 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuTipsLock 
         Caption         =   "����(&K)"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuLine1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTipsMin 
         Caption         =   "��С�����д���(&I)"
      End
      Begin VB.Menu mnuTipsNormal 
         Caption         =   "��̬�����д���(&N)"
      End
      Begin VB.Menu mnuTipsMax 
         Caption         =   "������д���(&A)"
      End
      Begin VB.Menu mnuLine2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTipsShuiPing 
         Caption         =   "ˮƽƽ�̴���(&H)"
      End
      Begin VB.Menu mnuTipsChuiZhi 
         Caption         =   "��ֱƽ�̴���(&V)"
      End
      Begin VB.Menu mnuTipsCengDie 
         Caption         =   "�������(&D)"
      End
   End
   Begin VB.Menu mnuiProject 
      Caption         =   "iProject"
      Begin VB.Menu mnuProjectStart 
         Caption         =   "����Ϊ����(&U)"
      End
      Begin VB.Menu mnuProjectProperty 
         Caption         =   "��������(&P)"
      End
      Begin VB.Menu mnuViewObject 
         Caption         =   "�鿴����(&O)"
      End
      Begin VB.Menu mnuViewCode 
         Caption         =   "�鿴����(&C)"
      End
      Begin VB.Menu mnuFolderOpen 
         Caption         =   "չ��(&E)"
      End
      Begin VB.Menu mnuFolderClose 
         Caption         =   "����(&C)"
      End
      Begin VB.Menu mnuLine3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAdd 
         Caption         =   "���(&A)"
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   1
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   2
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   3
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   4
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   5
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   6
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   7
         End
         Begin VB.Menu mnuAddC 
            Caption         =   ""
            Index           =   13
         End
      End
      Begin VB.Menu mnuAddFolder 
         Caption         =   "����ļ���(&F)"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuLine4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "���� (&S)"
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "���Ϊ (&V)"
      End
      Begin VB.Menu mnuRemove 
         Caption         =   "�Ƴ� (&R)"
      End
      Begin VB.Menu mnuRemoveFolder 
         Caption         =   "�Ƴ� (&R)"
         Visible         =   0   'False
         Begin VB.Menu mnuRemoveFolderDelete 
            Caption         =   "�������(&D)"
         End
         Begin VB.Menu mnuRemoveFolderUpdata 
            Caption         =   "�ƶ���������һ��(&U)"
         End
      End
      Begin VB.Menu mnuLine5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPrint 
         Caption         =   "��ӡ(&T)"
      End
      Begin VB.Menu mnuLine6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuModeClassic 
         Caption         =   "��׼ģʽ(&N)"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuModeI 
         Caption         =   "�Զ���ģʽ(&I)"
      End
   End
End
Attribute VB_Name = "HiddenForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public TB_TipsIndex As Long
Public Code_hCodeWindow As Long
Public OV_hObjectViewer As Long
Public FW_Hwnd As Long
Public FW_Caption As String

Private TimerCount As Long

Private Sub EH_timerErrorBox_Timer()
    iCode.CWE.ErrBox.Show
    modPublic.SetFocus iCode.CWE.hButtonsContainer
    EH_timerErrorBox.Enabled = False
End Sub

Private Sub mnuAddC_Click(Index As Integer)
    iProject.mnuAddC_Click (Index)
End Sub

Private Sub mnuAddFolder_Click()
    iProject.mnuAddFolder_Click
End Sub

Private Sub mnuTipsCloseOther_Click()
    iTipsBar.DelectRight TB_TipsIndex
    iTipsBar.DelectLeft TB_TipsIndex
End Sub

Private Sub mnuFolderClose_Click()
    iProject.mnuFolderClose_Click
End Sub

Private Sub mnuFolderOpen_Click()
    iProject.mnuFolderOpen_Click
End Sub

Private Sub mnuModeClassic_Click()
    iProject.mnuModeClassic_Click
End Sub

Private Sub mnuModeI_Click()
    iProject.mnuModeI_Click
End Sub

Private Sub mnuPrint_Click()
    iProject.mnuPrint_Click
End Sub

Private Sub mnuProjectProperty_Click()
    iProject.mnuProjectProperty_Click
End Sub

Private Sub mnuProjectStart_Click()
    iProject.mnuProjectStart_Click
End Sub

Private Sub mnuRemove_Click()
    iProject.mnuRemove_Click
End Sub

Private Sub mnuRemoveFolderDelete_Click()
    iProject.mnuRemoveFolder_Click (0)
End Sub

Private Sub mnuRemoveFolderUpdata_Click()
    iProject.mnuRemoveFolder_Click (1)
End Sub

Private Sub mnuSave_Click()
    iProject.mnuSave_Click
End Sub

Private Sub mnuSaveAs_Click()
    iProject.mnuSaveAs_Click
End Sub

Private Sub mnuTipsClose_Click()
    SendMessage iTipsBar.TipsBar.Tips(TB_TipsIndex).Key, WM_CLOSE, 0, 0
End Sub

Private Sub mnuTipsCloseLeft_Click()
    iTipsBar.DelectLeft TB_TipsIndex
End Sub

Private Sub mnuTipsCloseRight_Click()
    iTipsBar.DelectRight TB_TipsIndex
End Sub

Private Sub mnuViewCode_Click()
    iProject.mnuViewCode_Click
End Sub

Private Sub mnuViewObject_Click()
    iProject.mnuViewObject_Click
End Sub


Private Sub Code_timerSortMouseKeyEvents_Timer()
    iCode.CodeSort.SortMouseKeyEvent
    Code_timerSortMouseKeyEvents.Enabled = False
End Sub

