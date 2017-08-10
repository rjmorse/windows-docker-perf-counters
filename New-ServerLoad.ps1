$script = {
    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}
}

start-job -ScriptBlock $script -Name "ServerLoad"