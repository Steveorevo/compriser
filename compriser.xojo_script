//
// Project Name: Compriser
// Project URI: https://github.com/steveorevo/compriser
// Description: A dependency manager of Xojo projects.
// Author: Stephen J. Carnam
// Version: 0.0.1
//

// Define our platform specific InstallFolder
Dim InstallFolder As String
If TargetWindows Then
  InstallFolder = "%LOCALAPPDATA%" + "\compriser\"
Else
  InstallFolder = "~/.compriser/"
End If

// Ensure compriser folders exist
Dim r As String
r = DoShellCommand("mkdir " + InstallFolder)
r = DoShellCommand("mkdir " + InstallFolder + "runtime")

// Check for unzip utility on Windows
//If TargetWindows Then
  If Not Exists(InstallFolder + "runtime/unzip.exe") Then
    DownloadFile("https://github.com/steveorevo/compriser/")
  End If
//End If

//
// Our utility functions and extensions
//

// Determine if the given file or folder exists
Function Exists(sFile As String) As Boolean
  If TargetWindows Then
    Dim r As String = DoShellCommand("dir " + sFile)
    Return r.InStr("File Not Found") = 0
  Else
    Dim r As String = DoShellCommand("ls " + sFile)
    Return r.InStr("No such file ") = 0
  End If
End Function

// Download the file at the given URL to the given path
Sub DownloadFile(sURL As String, sPath As String)
  Dim sCmd As String
  If TargetWindows Then
    Dim sFile As String = sURL.GetRightMost("/")
    sCmd = "cd " + sPath + "&" + "@powershell (New-Object System.Net.WebClient).DownloadFile("
    sCmd = sCmd + "'" + sURL + "', '" + sFile + "')"
  Else
    sCmd = "cd " + sPath + ";" + "curl -O -L " + sURL
  End If
  Dim r As String
  r = DoShellCommand(sCmd)
End Sub
