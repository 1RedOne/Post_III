﻿    #ERASE ALL THIS AND PUT XAML BELOW between the @" "@ 
$inputXML = @"
<Window x:Class="BlogPostIII.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:BlogPostIII"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid x:Name="background" Background="#FF1D3245">
        <Image x:Name="image" HorizontalAlignment="Left" Height="100" Margin="171,154,0,0" VerticalAlignment="Top" Width="100" Source="C:\Users\sred13\Dropbox\My Code\Migmon\htdocs\Appa.png" Visibility="Hidden" />
        <Button x:Name="button" Content="Reveal Hidden Skybisons" HorizontalAlignment="Left" Height="34" Margin="10,277,0,0" VerticalAlignment="Top" Width="155"/>

    </Grid>
</Window>
 
"@        
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml) 
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================
                                                                
 
#Reference Sample entry of how to add data to a field
    #$vmpicklistView.items.Add([pscustomobject]@{'VMName'=($_).Name;Status=$_.Status;Other="Yes"})
    #$WPFtextBox.Text = $env:COMPUTERNAME
    #$WPFbutton.Add_Click({$WPFlistView.Items.Clear();start-sleep -Milliseconds 840;Get-DiskInfo -computername $WPFtextBox.Text | % {$WPFlistView.AddChild($_)}  })
 
#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan
$Form.ShowDialog() | out-null


$WPFbutton.Add_Click({
    if ($WPFimage.Visibility -ne 'Visible'){$WPFimage.Visibility = 'Visible'}
    else {$WPFimage.Visibility = 'Hidden'}
})
 