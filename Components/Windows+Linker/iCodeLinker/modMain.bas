Attribute VB_Name = "modMain"
Option Explicit

Private Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, lpSecurityAttributes As Any, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
Private Declare Function ReadFile Lib "kernel32" (ByVal hFile As Long, lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, lpOverlapped As Any) As Long
Private Declare Function SetFilePointer Lib "kernel32" (ByVal hFile As Long, ByVal lDistanceToMove As Long, lpDistanceToMoveHigh As Long, ByVal dwMoveMethod As Long) As Long
Private Declare Function BeginUpdateResource Lib "kernel32" Alias "BeginUpdateResourceA" (ByVal pFileName As String, ByVal bDeleteExistingResources As Long) As Long
Private Declare Function UpdateResource Lib "kernel32" Alias "UpdateResourceA" (ByVal hUpdate As Long, ByVal lpType As Long, ByVal lpName As Long, ByVal wLanguage As Long, lpData As Any, ByVal cbData As Long) As Long
Private Declare Function EndUpdateResource Lib "kernel32" Alias "EndUpdateResourceA" (ByVal hUpdate As Long, ByVal fDiscard As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function GetLastError Lib "kernel32" () As Long
Private Const INVALID_HANDLE_VALUE = -1
Private Const GENERIC_READ = &H80000000
Private Const FILE_ATTRIBUTE_NORMAL = &H80
Private Const FILE_BEGIN = 0
Private Const OPEN_EXISTING = 3
Private Const RT_ICON = 3&
Private Const RT_RCDATA = 10&

Private Const DIFFERENCE As Long = 11
Private Const RT_GROUP_ICON As Long = (RT_ICON + DIFFERENCE)

Private Type ICONDIRENTRY
    bWidth As Byte
    bHeight As Byte
    bColorCount As Byte
    bReserved As Byte
    wPlanes As Integer
    wBitCount As Integer
    dwBytesInRes As Long
    dwImageOffset As Long
End Type
Private Type ICONDIR
    idReserved As Integer
    idType As Integer
    idCount As Integer
    'idEntries As ICONDIRENTRY
End Type
Private Type GRPICONDIRENTRY
    bWidth As Byte
    bHeight As Byte
    bColorCount As Byte
    bReserved As Byte
    wPlanes As Integer
    wBitCount As Integer
    dwBytesInRes As Long
    nID As Integer
End Type
Private Type GRPICONDIR
    idReserved As Integer
    idType As Integer
    idCount As Integer
    'idEntries As GRPICONDIRENTRY
End Type

Dim EXEName As String

Private Sub UpdataIcon(ByVal ExeFile As String, ByVal IconFile As String)

    Dim pIcon() As Byte
    Dim pGI() As Byte
    Dim pGID() As Byte
    
    Dim nSize As Long
    Dim nIcon As Long

    Dim hFile As Long
    Dim dwReserved As Long
    
    '��ͼ���ļ�
    hFile = CreateFile(IconFile, GENERIC_READ, 0, ByVal 0&, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
    If hFile = INVALID_HANDLE_VALUE Then Exit Sub
    
    '��EXE�ļ�
    Dim hUpdate As Long
    hUpdate = BeginUpdateResource(ExeFile, False)
    
    '��ȡͼ���ļ�ͷ
    Dim ID As ICONDIR
    Call ReadFile(hFile, ID, Len(ID), dwReserved, ByVal 0&)
    nIcon = ID.idCount
    
    Dim i As Long
    
    '��ȡ����ͼ����Ϣ����ڣ�
    Dim IDE() As ICONDIRENTRY
    ReDim IDE(nIcon - 1)
    For i = 1 To nIcon
        Call ReadFile(hFile, IDE(i - 1), Len(IDE(i - 1)), dwReserved, ByVal 0&)
    Next
    
    '��ȡͼ���ļ����ݲ�д��EXE
    For i = 1 To nIcon
        nSize = IDE(i - 1).dwBytesInRes
        ReDim pIcon(nSize - 1)
        SetFilePointer hFile, IDE(i - 1).dwImageOffset, ByVal 0&, FILE_BEGIN
        Call ReadFile(hFile, pIcon(0), nSize, dwReserved, ByVal 0&)
        Call UpdateResource(hUpdate, RT_ICON, i, 0, pIcon(0), nSize)
    Next
    
    'ȥ��VB�����ļ�Ĭ��ͼ��
    For i = 30001 To 30003
        Call UpdateResource(hUpdate, RT_ICON, i, 0, ByVal 0&, 0)
    Next
    
    '����EXEͼ�����ļ�ͷ
    Dim GID As GRPICONDIR
    With GID
        .idReserved = 0
        .idType = 1
        .idCount = ID.idCount
    End With
    
    Dim GIDE As GRPICONDIRENTRY
    
    Dim sGID As Long: sGID = Len(GID)
    Dim sGIDE As Long: sGIDE = Len(GIDE)
    
    ReDim pGID(sGID + nIcon * sGIDE - 1)
    
    '����ͼ�����ļ�ͷ�ֽ�����
    CopyMemory pGID(0), GID, sGID
    
    '����ͼ�����ͼ���������Ӧ���ֽ�����
    For i = 1 To nIcon
        CopyMemory GIDE, IDE(i - 1), 12
        GIDE.nID = i
        CopyMemory pGID(sGID + (i - 1) * sGIDE), GIDE, sGIDE
    Next
    
    'д��ͼ��������
    Call UpdateResource(hUpdate, RT_GROUP_ICON, 1, 0, pGID(0), sGID + nIcon * sGIDE)
    
    '���������ݸ��ύ��EXE�ļ�
    EndUpdateResource hUpdate, False
    
    CloseHandle hFile
End Sub

Private Sub InstallManifest(ByVal ExeFile As String, ByVal ManifestFile As String)
    
    Dim hRes As Long
    
    Dim pManifest() As Byte
    
    Open ManifestFile For Binary As #1
    
    ReDim pManifest(LOF(1) - 1)
    Get #1, , pManifest()
        
    hRes = BeginUpdateResource(ExeFile, False)
    Call UpdateResource(hRes, 24&, 1, 0, pManifest(0), LOF(1))
    '24����Դ���ж��Manifest�ļ�ʱ��ֻ�е�һ��������һ�ţ�������������
    
    Close #1
    
    EndUpdateResource hRes, False
    
End Sub


Private Sub Main()

    Dim pS() As String
    pS = Split(Command(), "#")
    
    EXEName = pS(0)
    
    DoEvents
    
    If pS(1) <> "" Then
        If Dir(pS(1)) = "" Then
            MsgBox "�Ҳ���ͼ���ļ���", vbExclamation, "д��ͼ��"
        Else
            UpdataIcon EXEName, pS(1)
        End If
    End If
    
    If pS(2) <> "" Then
        If Dir(pS(2)) = "" Then
            MsgBox "�Ҳ���Manifest�ļ���", vbExclamation, "д��Manifest"
        Else
            InstallManifest EXEName, pS(2)
        End If
    End If
    
    End
    
End Sub
