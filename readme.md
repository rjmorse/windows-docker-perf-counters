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

# Sample output from `.\Run-Test.ps1`
```powershell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\Users\Administrator> cd .\Downloads\docker-aspnet-metrics\
PS C:\Users\Administrator\Downloads\docker-aspnet-metrics> .\Run-Test.ps1
Building container...
Sending build context to Docker daemon 43.52 kB
Step 1/7 : FROM microsoft/aspnet
 ---> d4760b0e68eb
Step 2/7 : SHELL powershell -Command $ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';
 ---> Using cache
 ---> 612b8afa4ae8
Step 3/7 : COPY *.* /temp/
 ---> Using cache
 ---> e8b0b3999c67
Step 4/7 : WORKDIR /temp
 ---> Using cache
 ---> 77aaabaa7c4c
Step 5/7 : RUN /temp/setup.ps1
 ---> Using cache
 ---> 8f463e27aa0d
Step 6/7 : ENTRYPOINT powershell
 ---> Using cache
 ---> 26b10266c8c7
Step 7/7 : CMD  c:\entrypoint.ps1
 ---> Using cache
 ---> 94d23c211583
Successfully built 94d23c211583
Running container test...

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      ServerLoad      BackgroundJob   Running       True            localhost            ...



Path                                                                                  InstanceName CookedValue
----                                                                                  ------------ -----------
\\04c886c424fc\asp.net applications(__total__)\anonymous requests                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\anonymous requests/sec                 __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total entries                    __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total turnover rate              __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total hits                       __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total misses                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total hit ratio                  __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api entries                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api turnover rate                __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api hits                         __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api misses                       __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api hit ratio                    __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache entries                   __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache turnover rate             __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache hits                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache misses                    __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache hit ratio                 __total__              0
\\04c886c424fc\asp.net applications(__total__)\compilations total                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\debugging requests                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors during preprocessing            __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors during compilation              __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors during execution                __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors unhandled during execution      __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors unhandled during execution/sec  __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors total                           __total__              0
\\04c886c424fc\asp.net applications(__total__)\errors total/sec                       __total__              0
\\04c886c424fc\asp.net applications(__total__)\pipeline instance count                __total__              0
\\04c886c424fc\asp.net applications(__total__)\request bytes in total                 __total__              0
\\04c886c424fc\asp.net applications(__total__)\request bytes out total                __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests executing                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests failed                        __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests not found                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests not authorized                __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests in application queue          __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests timed out                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests succeeded                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests total                         __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests/sec                           __total__              0
\\04c886c424fc\asp.net applications(__total__)\sessions active                        __total__              0
\\04c886c424fc\asp.net applications(__total__)\sessions abandoned                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\sessions timed out                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\sessions total                         __total__              0
\\04c886c424fc\asp.net applications(__total__)\transactions aborted                   __total__              0
\\04c886c424fc\asp.net applications(__total__)\transactions committed                 __total__              0
\\04c886c424fc\asp.net applications(__total__)\transactions pending                   __total__              0
\\04c886c424fc\asp.net applications(__total__)\transactions total                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\transactions/sec                       __total__              0
\\04c886c424fc\asp.net applications(__total__)\session state server connections total __total__              0
\\04c886c424fc\asp.net applications(__total__)\session sql server connections total   __total__              0
\\04c886c424fc\asp.net applications(__total__)\events raised                          __total__              0
\\04c886c424fc\asp.net applications(__total__)\events raised/sec                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\application lifetime events            __total__              0
\\04c886c424fc\asp.net applications(__total__)\application lifetime events/sec        __total__              0
\\04c886c424fc\asp.net applications(__total__)\error events raised                    __total__              0
\\04c886c424fc\asp.net applications(__total__)\error events raised/sec                __total__              0
\\04c886c424fc\asp.net applications(__total__)\request error events raised            __total__              0
\\04c886c424fc\asp.net applications(__total__)\request error events raised/sec        __total__              0
\\04c886c424fc\asp.net applications(__total__)\infrastructure error events raised     __total__              0
\\04c886c424fc\asp.net applications(__total__)\infrastructure error events raised/sec __total__              0
\\04c886c424fc\asp.net applications(__total__)\request events raised                  __total__              0
\\04c886c424fc\asp.net applications(__total__)\request events raised/sec              __total__              0
\\04c886c424fc\asp.net applications(__total__)\audit success events raised            __total__              0
\\04c886c424fc\asp.net applications(__total__)\audit failure events raised            __total__              0
\\04c886c424fc\asp.net applications(__total__)\membership authentication success      __total__              0
\\04c886c424fc\asp.net applications(__total__)\membership authentication failure      __total__              0
\\04c886c424fc\asp.net applications(__total__)\forms authentication success           __total__              0
\\04c886c424fc\asp.net applications(__total__)\forms authentication failure           __total__              0
\\04c886c424fc\asp.net applications(__total__)\viewstate mac validation failure       __total__              0
\\04c886c424fc\asp.net applications(__total__)\request execution time                 __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests disconnected                  __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests rejected                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\request wait time                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache % machine memory limit used      __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache % process memory limit used      __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache total trims                      __total__              0
\\04c886c424fc\asp.net applications(__total__)\cache api trims                        __total__              0
\\04c886c424fc\asp.net applications(__total__)\output cache trims                     __total__              0
\\04c886c424fc\asp.net applications(__total__)\% managed processor time (estimated)   __total__              0
\\04c886c424fc\asp.net applications(__total__)\managed memory used (estimated)        __total__              0
\\04c886c424fc\asp.net applications(__total__)\request bytes in total (websockets)    __total__              0
\\04c886c424fc\asp.net applications(__total__)\request bytes out total (websockets)   __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests executing (websockets)        __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests failed (websockets)           __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests succeeded (websockets)        __total__              0
\\04c886c424fc\asp.net applications(__total__)\requests total (websockets)            __total__              0



Count Name Group

----- ---- -----

   85 0    {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.
PerformanceCounterSample, ...


Running host test...
Starting setup...

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}
Exception setting "BufferSize": "Cannot set the buffer size because the size specified is too large or too small.
Parameter name: value
Actual value was 150,3000."
At C:\Users\Administrator\Downloads\docker-aspnet-metrics\entrypoint.ps1:16 char:9
+         $rawUI.BufferSize = $newSize
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], SetValueInvocationException
    + FullyQualifiedErrorId : ExceptionWhenSetting


HasMoreData   : True
StatusMessage :
Location      : localhost
Command       :
                    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}

JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : d9dc7bde-6a77-45a6-8aeb-6296a120dd13
Id            : 1
Name          : ServerLoad
ChildJobs     : {Job2}
PSBeginTime   : 8/10/2017 4:21:41 PM
PSEndTime     :
PSJobTypeName : BackgroundJob
Output        : {}
Error         : {}
Progress      : {}
Verbose       : {}
Debug         : {}
Warning       : {}
Information   : {}
State         : Running




Path                                                                                            InstanceName          CookedValue
----                                                                                            ------------          -----------
\\win-qga9jqvvuhg\asp.net applications(__total__)\anonymous requests                            __total__                    1637
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\anonymous requests                     _lm_w3svc_1_root             1637
\\win-qga9jqvvuhg\asp.net applications(__total__)\anonymous requests/sec                        __total__        82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\anonymous requests/sec                 _lm_w3svc_1_root 82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total entries                           __total__                      11
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total entries                    _lm_w3svc_1_root               11
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total turnover rate                     __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total turnover rate              _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total hits                              __total__                    5157
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total hits                       _lm_w3svc_1_root             5157
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total misses                            __total__                      77
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total misses                     _lm_w3svc_1_root               77
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total hit ratio                         __total__        98.5288498280474
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total hit ratio                  _lm_w3svc_1_root 98.5288498280474
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api entries                             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api entries                      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api turnover rate                       __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api turnover rate                _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api hits                                __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api hits                         _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api misses                              __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api misses                       _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api hit ratio                           __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api hit ratio                    _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache entries                          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache entries                   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache turnover rate                    __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache turnover rate             _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache hits                             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache hits                      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache misses                           __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache misses                    _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache hit ratio                        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache hit ratio                 _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\compilations total                            __total__                       4
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\compilations total                     _lm_w3svc_1_root                4
\\win-qga9jqvvuhg\asp.net applications(__total__)\debugging requests                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\debugging requests                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors during preprocessing                   __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors during preprocessing            _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors during compilation                     __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors during compilation              _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors during execution                       __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors during execution                _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors unhandled during execution             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors unhandled during execution      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors unhandled during execution/sec         __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors unhandled during execution/sec  _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors total                                  __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors total                           _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\errors total/sec                              __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\errors total/sec                       _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\pipeline instance count                       __total__                       1
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\pipeline instance count                _lm_w3svc_1_root                1
\\win-qga9jqvvuhg\asp.net applications(__total__)\request bytes in total                        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request bytes in total                 _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request bytes out total                       __total__                 1445471
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request bytes out total                _lm_w3svc_1_root          1445471
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests executing                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests executing                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests failed                               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests failed                        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests not found                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests not found                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests not authorized                       __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests not authorized                _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests in application queue                 __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests in application queue          _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests timed out                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests timed out                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests succeeded                            __total__                    1637
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests succeeded                     _lm_w3svc_1_root             1637
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests total                                __total__                    1637
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests total                         _lm_w3svc_1_root             1637
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests/sec                                  __total__        82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests/sec                           _lm_w3svc_1_root 82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(__total__)\sessions active                               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\sessions active                        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\sessions abandoned                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\sessions abandoned                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\sessions timed out                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\sessions timed out                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\sessions total                                __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\sessions total                         _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\transactions aborted                          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\transactions aborted                   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\transactions committed                        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\transactions committed                 _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\transactions pending                          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\transactions pending                   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\transactions total                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\transactions total                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\transactions/sec                              __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\transactions/sec                       _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\session state server connections total        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\session state server connections total _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\session sql server connections total          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\session sql server connections total   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\events raised                                 __total__                    1650
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\events raised                          _lm_w3svc_1_root             1650
\\win-qga9jqvvuhg\asp.net applications(__total__)\events raised/sec                             __total__        82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\events raised/sec                      _lm_w3svc_1_root 82.0924936125533
\\win-qga9jqvvuhg\asp.net applications(__total__)\application lifetime events                   __total__                       9
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\application lifetime events            _lm_w3svc_1_root                9
\\win-qga9jqvvuhg\asp.net applications(__total__)\application lifetime events/sec               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\application lifetime events/sec        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\error events raised                           __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\error events raised                    _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\error events raised/sec                       __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\error events raised/sec                _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request error events raised                   __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request error events raised            _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request error events raised/sec               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request error events raised/sec        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\infrastructure error events raised            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\infrastructure error events raised     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\infrastructure error events raised/sec        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\infrastructure error events raised/sec _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request events raised                         __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request events raised                  _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request events raised/sec                     __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request events raised/sec              _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\audit success events raised                   __total__                    1641
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\audit success events raised            _lm_w3svc_1_root             1641
\\win-qga9jqvvuhg\asp.net applications(__total__)\audit failure events raised                   __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\audit failure events raised            _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\membership authentication success             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\membership authentication success      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\membership authentication failure             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\membership authentication failure      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\forms authentication success                  __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\forms authentication success           _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\forms authentication failure                  __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\forms authentication failure           _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\viewstate mac validation failure              __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\viewstate mac validation failure       _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request execution time                        __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request execution time                 _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests disconnected                         __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests disconnected                  _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests rejected                             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests rejected                      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request wait time                             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request wait time                      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache % machine memory limit used             __total__        47.4226804123711
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache % machine memory limit used      _lm_w3svc_1_root 47.4226804123711
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache % process memory limit used             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache % process memory limit used      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total trims                             __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total trims                      _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache api trims                               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache api trims                        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\output cache trims                            __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\output cache trims                     _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\% managed processor time (estimated)          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\% managed processor time (estimated)   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\managed memory used (estimated)               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\managed memory used (estimated)        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request bytes in total (websockets)           __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request bytes in total (websockets)    _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\request bytes out total (websockets)          __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request bytes out total (websockets)   _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests executing (websockets)               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests executing (websockets)        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests failed (websockets)                  __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests failed (websockets)           _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests succeeded (websockets)               __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests succeeded (websockets)        _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests total (websockets)                   __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests total (websockets)            _lm_w3svc_1_root                0



Count Name             Group
----- ----             -----
    4 1859             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    4 71.7462836172443 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    2 11               {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
  132 0                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    2 5824             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 77               {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 98.6951364175564 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 4                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    4 1                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    2 1641497          {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1860             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 72.742759778595  {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1872             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 9                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1863             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 3                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 47.4226804123711 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
Cleaning up files...
Docker image has not been removed: 'missing-metrics'


PS C:\Users\Administrator\Downloads\docker-aspnet-metrics>
```