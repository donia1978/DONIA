Add-Type -AssemblyName PresentationFramework

# Charger XAML proprement
$xml = New-Object System.Xml.XmlDocument
$xml.Load("gui.xaml")

$reader = New-Object System.Xml.XmlNodeReader $xml
$Window = [Windows.Markup.XamlReader]::Load($reader)

. ".\functions_donia.ps1"

# Bind UI
$global:LogBox     = $Window.FindName("LogBox")
$BtnFrontend       = $Window.FindName("BtnFrontend")
$BtnBackend        = $Window.FindName("BtnBackend")
$BtnDocker         = $Window.FindName("BtnDocker")
$BtnGit            = $Window.FindName("BtnGit")
$BtnFixAll         = $Window.FindName("BtnFixAll")
$BtnOpenSite       = $Window.FindName("BtnOpenSite")
$BtnOpenFolder     = $Window.FindName("BtnOpenFolder")

# Events
$BtnFrontend.Add_Click({ Test-Frontend })
$BtnBackend.Add_Click({ Test-Backend })
$BtnDocker.Add_Click({ Docker-Control })
$BtnGit.Add_Click({ GitPush })
$BtnFixAll.Add_Click({ Fix-All })
$BtnOpenSite.Add_Click({ Start-Process "http://localhost:3000" })
$BtnOpenFolder.Add_Click({ Start-Process "C:\Users\MOUNA\OneDrive\Desktop\don" })

# Show window
$Window.ShowDialog() | Out-Null
