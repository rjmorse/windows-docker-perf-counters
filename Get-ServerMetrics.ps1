((Get-Counter -ListSet "asp.net appli*").paths | Get-Counter).CounterSamples | Format-Table
((Get-Counter -ListSet "asp.net appli*").paths | Get-Counter).CounterSamples | Group-Object cookedvalue
