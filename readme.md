# Observed problem
- IIS metrics for specific example asp.net application are ALL ZERO for Docker container running in AWS. Those performance counters are present, but 0.
- IIS metrics for a generic asp.net application are NOT ALL ZERO when ran in a VM
- Both cases are on Windows Server 2016

# Goal
- Easily reproduce the observed problem in a controlled test

# Usage
- Prerequisites
  - Windows Server 2016 with Docker/Container support
- Execute `.\Run-Test.ps1`
  - Results are output to the screen: container test, then local host test

# Method to reproduce
- In a given VM on Windows Server 2016
  - Add necessary ASP.NET windows features to match docker container
- In both Docker container and VM host
  - Add test asp.net file to wwwroot
  - `Invoke-WebRequest` against test file on localhost every 10ms
  - `((Get-Counter -ListSet "asp.net appli*").paths | Get-Counter).CounterSamples` on localhost and see if all counters are 0 or not

