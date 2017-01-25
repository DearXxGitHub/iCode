#include "stdafx.h"
#include "iDll.h"
#include <windows.h>
#include <stdlib.h>

//ע�⣺VC++ Dll�ĵ���������Ҫ��VB���ã���Ҫ__stdcall�ĵ��÷�ʽ��extren "C"���Σ���def�ļ�

extern "C"
{

#pragma data_seg("RemoteHookDllData")//���ù������ݶ�

HHOOK hHook=NULL;//���Ӿ��

#define Msg_list_MaxSize 10
int Msg_list[Msg_list_MaxSize+1]={0};//�贫�����Ϣ���ϣ�Msg_list[0]�洢��Ϣ����
#define hwnd_list_MaxSize 5
int hwnd_list[Msg_list_MaxSize+1][hwnd_list_MaxSize+1]={{0}};//�贫����Ϣ��Ӧ�Ľ��վ�����ϣ�hwnd_list[i][0]�洢��i����Ϣ�Ľ��վ����

//��Ϣע���������Ϊ10��������һ����Ϣ���վ������Ϊ5��������Ϊ�˱�֤�������еĸ�Ч

#pragma data_seg()
	
HINSTANCE hInsDll;//Dllʵ�����
	
LRESULT CALLBACK iProc(int nCode,WPARAM wParam,LPARAM lParam);//Hook�ص�����
	

DLLIMPORT bool __stdcall RegisterMessage(int Msg,int hReciver)//ע����Ϣ
{
	int i;
	for(i=1;i<=Msg_list[0];i++) if(Msg_list[i]==Msg) break;//������Ϣ�Ƿ���ע��
	if(i>Msg_list[0])//�����Ϣδע�ᣬ��ע��
	{
		if(Msg_list[0]>=Msg_list_MaxSize)
		{
			MessageBox(0,"Overflow(Msg_list)!","iRemoteHook - Dll",MB_ICONINFORMATION);
			return false;
		}
		Msg_list[++Msg_list[0]]=Msg;
		hwnd_list[Msg_list[0]][0]=1;
		hwnd_list[Msg_list[0]][1]=hReciver;
	}
	else//�����Ϣ��ע�ᣬ�����ӽ��վ��
	{
		if(hwnd_list[i][0]>=hwnd_list_MaxSize)
		{
			MessageBox(0,"Overflow(hwnd_list)!","iRemoteHook - Dll",MB_ICONINFORMATION);
			return false;
		}
		hwnd_list[i][++hwnd_list[i][0]]=hReciver;
	}
	return true;
}

DLLIMPORT int __stdcall SetHook(int TID)//�ҹ�
{
	if(hHook!=NULL) return (int)hHook;
	hHook=SetWindowsHookEx(WH_CALLWNDPROC,iProc,hInsDll,(DWORD)TID);
	if(!hHook)
	{
		char S[25];
		itoa((int)GetLastError(),S,10);
		MessageBox(0,strcat("Fail to set hook! GetLastError = ",S),"iRemoteHook - Dll",MB_ICONINFORMATION);
	}
	return (int)hHook;
}
	
LRESULT CALLBACK iProc(int nCode,WPARAM wParam,LPARAM lParam)//Hook�ص�����
{
#define CWP ((CWPSTRUCT*)lParam)
	if(nCode==HC_ACTION)
	{
		for(int i=1;i<=Msg_list[0];i++)
		{
			if(CWP->message==Msg_list[i])
			{
				int Datas[4]={(int)CWP->lParam,(int)CWP->wParam,(int)CWP->message,(int)CWP->hwnd};
				//������Ҫ��������µĿռ䣬���ܽ�lParamֱ����ΪCOPYDATASTRUCT�Ĳ�������

				COPYDATASTRUCT cds;
				cds.dwData=0;
				cds.cbData=sizeof(Datas);
				cds.lpData=Datas;

				for(int j=1;j<=hwnd_list[i][0];j++)
					SendMessageA((HWND)hwnd_list[i][j],WM_COPYDATA,0,(LPARAM)&cds);//����WM_COPYDATA������Ϣ
				//WM_COPYDATA�������ڿ���̴�����Ϣ
				//WH_CALLWNDPROC�����޸���Ϣ����û�и���SendMessageA�ķ���ֵ������
			}
		}
			
	}
		
	return CallNextHookEx(hHook,nCode,wParam,lParam);
}

DLLIMPORT void __stdcall UnHook()
{
	UnhookWindowsHookEx(hHook);
}
}

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
			hInsDll=(HINSTANCE)hModule;//����Dllʵ�����
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
    }
    return TRUE;
}
