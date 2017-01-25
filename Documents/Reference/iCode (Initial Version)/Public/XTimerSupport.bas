Attribute VB_Name = "XTimerSupport"
Option Explicit
'================================================
' ע�⣡�����Դ˹���ʱ��Ҫ��������ť��
'   ���ж�ģʽʱ����Ҫ�Թ��̽��б༭��
'   ���������¹��̱����ã�
'
' ���ģ�����Σ������Ϊ��ʹ��
'   SetTimer API �� AddressOf ������
'   ������һ�������ʱ����һ������
'   ��ʱ�������ã���ϵͳ�������ص�
'   ���ʱ֮�󽫼������� TimerProc �����¼���
'
' ��Ϊ TimerProc �����ʱ�����ã�
'   ��������� Visual Basic �н�
'   ����һ��������ϡ�
'
' ���������ģ��ʱ������Ҫȷ��
'   �ڷ��ص����ʱ֮ǰ���е�ϵͳ
'   ��ʱ�����Ѿ�ֹͣ(ʹ�� KillTimer)��
'   �����Դ����������е���
'   SCRUB ����ɴ˲�����
'
' �ص���ʱ�����й��е�Σ���ԡ�
'   ʹ�ü�ʱ���ؼ������������Ŀ�������
'   �����ӵİ�ȫ��ֻ�е������л���
'   �ص���ʱ����
'==================================================

' ��ʹ�ø���ļ�ʱ��ʱ������ maxti
'   �ĺϼƳߴ罫����(��������� 'MoreRoom:' ���롣)
Const MAXTIMERINCREMEMT = 5

Private Type XTIMERINFO                                                         ' Hungarian xti
    xt As XTimer
    id As Long
    blnReentered As Boolean
End Type

Declare Function SetTimer Lib "user32" (ByVal hWnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerProc As Long) As Long
Declare Function KillTimer Lib "user32" (ByVal hWnd As Long, ByVal nIDEvent As Long) As Long

' maxti ��һ����� XTimer ��������顣ʹ���û�
' -----   �������͵�����������һ�����϶���
'   ��ԭ���ǵ����ǲ��� XTimer ����� Tick
'   �¼�ʱ������ڰ󶨡�
Private maxti() As XTIMERINFO
'
' mintMaxTimers �����������κθ�����ʱ��ʱ
' -------------   ���� maxti �ɶ��
Private mintMaxTimers As Integer

' BeginTimer function �� XTimer �ļ�����Ա�
' -------------------   ���ó�һ���µķ���ֵʱ
'   ��һ�� XTimer ���������á�
'
' �˺���ʹ API ���ò���һ������������
'   ��ʱ���������ʱ�����ɹ��Ĵ�����
'   �˺������õ� XTimer ��������õ�
'   ���� maxti��������ý����ڵ���
'   ���� XTimer �� Tick �¼��ķ�����
Public Function BeginTimer(ByVal xt As XTimer, ByVal Interval As Long)
    Dim lngTimerID As Long
    Dim intTimerNumber As Integer
    
    lngTimerID = SetTimer(0, 0, Interval, AddressOf TimerProc)
    ' �ɹ�������ʱ�� SetTimer ����һ������ֵ��������ǲ���
    '   ���һ����ʱ���������һ������
    If lngTimerID = 0 Then Err.Raise vbObjectError + 31013, , "û�п��õļ�ʱ��"
    
    ' �����ѭ�������� maxti �ж�λ����һ��
    '   ���õĿ�λ�������������һ���󶨣�
    '   ���������ҽ�����Ӵ�(���
    '   ��������� DLL Ϊ���ش��룬��Ҫ�ر�
    '   �󶨼�飡)
    For intTimerNumber = 1 To mintMaxTimers
        If maxti(intTimerNumber).id = 0 Then Exit For
    Next
    '
    ' ���û���ҵ���λ����������ĳߴ硣
    If intTimerNumber > mintMaxTimers Then
        mintMaxTimers = mintMaxTimers + MAXTIMERINCREMEMT
        ReDim Preserve maxti(1 To mintMaxTimers)
    End If
    '
    ' ������ XTimer ����� Tick �¼�ʱ��
    '   ����һ����ʹ�õ����á�
    Set maxti(intTimerNumber).xt = xt
    '
    ' ���� SetTimer API ���صĵļ�ʱ�� id ��
    '   ���ҷ��ص� XTimer �����ֵ��
    maxti(intTimerNumber).id = lngTimerID
    maxti(intTimerNumber).blnReentered = False
    BeginTimer = lngTimerID
End Function

' TimerProc �Ǽ�ʱ�����̣�������ĳ����ʱ���ر�ʱ
' ---------   ϵͳ����������
'
' ��Ҫ��Ϣ -- ��Ϊ������̱����ڱ�׼ģ���У�
'   �������м�ʱ�����󶼱�����Թ�������
'   ����ζ�Ź��̱����ʶ����һ����ʱ��
'   �Ѿ��رա��������ͨ����������
'   maxti �ļ�ʱ�� ID �����(idEvent)��
'
' �������ӹ����������󣬽�����������ϣ�
'   ����ʹ��Ҫ��ص������� API
'   ��Σ�մ�֮һ��
'
Public Sub TimerProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal idEvent As Long, ByVal lngSysTime As Long)
    Dim intCt As Integer
    
    For intCt = 1 To mintMaxTimers
        If maxti(intCt).id = idEvent Then
            ' �������¼���һ������ʵ��
            '   ��Ȼ�ڽ���ʱ����Ҫ�������¼���
            If maxti(intCt).blnReentered Then Exit Sub
            ' blnReentered ��־���������
            '   �¼���δ��ʵ��ֱ��
            '   ��ǰ��������ɡ�
            maxti(intCt).blnReentered = True
            On Error Resume Next
            ' Ϊ�ʵ��� XTimer �������һ�� Tick �¼���
            maxti(intCt).xt.RaiseTick
            If Err.Number <> 0 Then
                ' �����������XTimer
                '   ��������ֹ����һ�����е�
                '   ������м�ʱ�������
                '   ������ʱ��������ֹ
                '   �Ժ���� GP ���ϡ�
                KillTimer 0, idEvent
                maxti(intCt).id = 0
                '
                ' �ͷŵ� XTimer ��������á�
                Set maxti(intCt).xt = Nothing
            End If
            '
            ' ��������¼��ٴν��� TimerProc��
            maxti(intCt).blnReentered = False
            Exit Sub
        End If
    Next
    ' ����Ĵ�������һ��ʧ�ܵı�����
    '   �� XTimer �޹ʱ��ͷŶ� Windows
    '   ϵͳ��ʱ����û�н���������
    '
    ' ִ��Ҳ���ܵ����������Ϊһ��
    '   ��֪�� NT 3.51 �Ĵ������������
    '   ��ִ���� KillTimer API ���յ�
    '   һ���ⲿ�ļ�ʱ���¼���
    KillTimer 0, idEvent
End Sub

' EndTimer ���̱� XTimer ���ã�ÿ��
' ------------------   Enabled ���Ա�����Ϊ
'   False���Լ�����Ҫһ���µļ�ʱ�������
'   û�а취����������ϵͳ��ʱ�������Ը���
'   �����Ψһ�����ǲ����ִ�ļ�ʱ������
'   ���� BeginTimer ������һ���µļ�ʱ����
'
Public Sub EndTimer(ByVal xt As XTimer)
    Dim lngTimerID As Long
    Dim intCt As Integer
    
    ' ѯ�� XTimer �� TimerID���������ǿ��Բ���
    '   �й���ȷ�� XTIMERINFO �����顣(������
    '   ���� XTimer ��������ã�ʹ��
    '   Is ��������ͬ���� maxti(intCt).xt �� xt ����
    '   �Ƚϣ��������������ٶȡ�)
    lngTimerID = xt.TimerID
    '
    ' �����ʱ�� ID ���㣬EndTimer ���ý�����
    If lngTimerID = 0 Then Exit Sub
    For intCt = 1 To mintMaxTimers
        If maxti(intCt).id = lngTimerID Then
            ' ����ϵͳ��ʱ����
            KillTimer 0, lngTimerID
            '
            ' �ͷŶ� XTimer ��������á�
            Set maxti(intCt).xt = Nothing
            '
            ' ��� ID���ͷſ�λ�Ա��µĻ�ļ�ʱ��ʹ�á�
            maxti(intCt).id = 0
            Exit Sub
        End If
    Next
End Sub

' Scrub ������һ������Ϊ�˵���Ŀ�ĵİ�ȫ�ķ���
' ---------------   ����� XTimer ����ʱ��
'   �����ò�����������̣������������е��� Scrub ��
'   �⽫����  KillTimer ���������е�ϵͳ��ʱ����
'   ʹ�����������԰�ȫ�طŻص����ģʽ��
'
Public Sub Scrub()
    Dim intCt As Integer
    ' ������Ȼ��ļ�ʱ����
    For intCt = 1 To mintMaxTimers
        If maxti(intCt).id <> 0 Then KillTimer 0, maxti(intCt).id
    Next
End Sub
