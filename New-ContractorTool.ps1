﻿    #ERASE ALL THIS AND PUT XAML BELOW between the @" "@ 
$inputXML = @"
<Window x:Class="BlogPostIII.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:BlogPostIII"
        mc:Ignorable="d"
        Title="Contractor Tool" Height="350" Width="566.715">
    <Grid x:Name="background" Background="#FF1D3245">
        <Button x:Name="MakeUserbutton" Content="Create User" HorizontalAlignment="Left" Height="34" Margin="10,277,0,0" VerticalAlignment="Top" Width="155" FontSize="14.667"/>
        <CheckBox x:Name="checkBox" Content="Temporary User?" HorizontalAlignment="Left" Height="36" Margin="10,176,0,0" VerticalAlignment="Top" Width="140" FontSize="14.667" Foreground="White"/>
        <Label x:Name="label" Content="Use this tool to create a new user" HorizontalAlignment="Left" Height="37" Margin="10,10,0,0" VerticalAlignment="Top" Width="274" Foreground="White"/>
        <TextBox x:Name="firstName" HorizontalAlignment="Left" Height="25" Margin="165,47,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="119" FontSize="14.667"/>
        <TextBlock x:Name="firstName_label" HorizontalAlignment="Left" Height="25" Margin="19,47,0,0" TextWrapping="Wrap" Text="First Name" VerticalAlignment="Top" Width="118" Background="#FF98BCD4" FontSize="16"/>
        <TextBox x:Name="lastName" HorizontalAlignment="Left" Height="25" Margin="165,89,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="119" FontSize="14.667"/>
        <TextBlock x:Name="lastName_label" HorizontalAlignment="Left" Height="25" Margin="19,89,0,0" TextWrapping="Wrap" Text="Last Name" VerticalAlignment="Top" Width="118" Background="#FF98BCD4" FontSize="16"/>
        <TextBox x:Name="logonName" HorizontalAlignment="Left" Height="25" Margin="165,130,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="119" FontSize="14.667"/>
        <TextBlock x:Name="logonName_label" HorizontalAlignment="Left" Height="25" Margin="19,130,0,0" TextWrapping="Wrap" Text="Logon Name" VerticalAlignment="Top" Width="118" Background="#FF98BCD4" FontSize="16"/>
        <Separator HorizontalAlignment="Left" Height="30" Margin="19,155,0,0" VerticalAlignment="Top" Width="265" RenderTransformOrigin="-1.016,-0.225"/>
        <RadioButton x:Name="radioButton_7" Content="7 Days" HorizontalAlignment="Left" Height="20" Margin="42,200,0,0" VerticalAlignment="Top" Width="108" RenderTransformOrigin="0.861,0.107" FontSize="14.667" Background="#FFF9F2F2" Foreground="White" IsEnabled="False"/>
        <RadioButton x:Name="radioButton_30" Content="30 Days" HorizontalAlignment="Left" Height="20" Margin="42,225,0,0" VerticalAlignment="Top" Width="108" RenderTransformOrigin="0.861,0.107" FontSize="14.667" Background="#FFF9F2F2" Foreground="White" IsEnabled="False"/>
        <RadioButton x:Name="radioButton_90" Content="90 Days" HorizontalAlignment="Left" Height="20" Margin="42,250,0,0" VerticalAlignment="Top" Width="108" RenderTransformOrigin="0.861,0.107" FontSize="14.667" Background="#FFF9F2F2" Foreground="White" IsEnabled="False"/>
        <TextBox x:Name="password" HorizontalAlignment="Left" Height="25" Margin="415,47,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="119" FontSize="14.667" RenderTransformOrigin="0.5,0.5"/>
        <TextBlock x:Name="password_label" HorizontalAlignment="Left" Height="25" Margin="303,47,0,0" TextWrapping="Wrap" Text="Password" VerticalAlignment="Top" Width="91" Background="#FF98BCD4" FontSize="16"/>
        <TextBlock x:Name="targetOU_label" HorizontalAlignment="Left" Height="25" Margin="303,89,0,0" TextWrapping="Wrap" Text="Target OU" VerticalAlignment="Top" Width="91" Background="#FF98BCD4" FontSize="16"/>
        <ComboBox x:Name="targetOU_comboBox" HorizontalAlignment="Left" Margin="415,92,-18,0" VerticalAlignment="Top" Width="120"/>


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

function Show-Form{
$Form.ShowDialog() | out-null

}