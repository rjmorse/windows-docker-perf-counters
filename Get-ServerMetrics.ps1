$samples = ((Get-Counter -ListSet "asp.net appli*").paths | Get-Counter).CounterSamples 
$samples | Format-Table
$samples | Group-Object cookedvalue
