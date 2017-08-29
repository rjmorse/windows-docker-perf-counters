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
Sending build context to Docker daemon 83.46 kB
Step 1/7 : FROM microsoft/aspnet
 ---> d4760b0e68eb
Step 2/7 : SHELL powershell -Command $ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';
 ---> Using cache
 ---> 612b8afa4ae8
Step 3/7 : COPY *.* /temp/
 ---> b7f655960775
Removing intermediate container b6ba3cb80ffb
Step 4/7 : WORKDIR /temp
 ---> eaf1af314f57
Removing intermediate container 94cf10054249
Step 5/7 : RUN /temp/setup.ps1
 ---> Running in 32a93a666c64
Starting setup...

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}


 ---> 55bd908ff2e4
Removing intermediate container 32a93a666c64
Step 6/7 : ENTRYPOINT powershell
 ---> Running in ded617ea2395
 ---> b42c2314edea
Removing intermediate container ded617ea2395
Step 7/7 : CMD  c:\entrypoint.ps1
 ---> Running in dfddaf340153
 ---> 1f8c0d4347f3
Removing intermediate container dfddaf340153
Successfully built 1f8c0d4347f3
WARNING: Running container tests... ApplicationPoolIdentity (default)
identityType = 4

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}

Name         : Default Web Site
ID           : 1890217144
State        : Started
PhysicalPath : c:\inetpub\wwwroot
Bindings     : Microsoft.IIs.PowerShell.Framework.ConfigurationElement


HasMoreData   : True
StatusMessage :
Location      : localhost
Command       :
                    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}

JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : 7327788a-5e2e-42cd-b4af-c042d35619dd
Id            : 1
Name          : ServerLoad
ChildJobs     : {Job2}
PSBeginTime   : 8/29/2017 11:59:20 AM
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




Path                                                                                  InstanceName CookedValue
----                                                                                  ------------ -----------
\\8dac29713126\asp.net applications(__total__)\anonymous requests                     __total__              0
\\8dac29713126\asp.net applications(__total__)\anonymous requests/sec                 __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total entries                    __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total turnover rate              __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total hits                       __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total misses                     __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total hit ratio                  __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api entries                      __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api turnover rate                __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api hits                         __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api misses                       __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api hit ratio                    __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache entries                   __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache turnover rate             __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache hits                      __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache misses                    __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache hit ratio                 __total__              0
\\8dac29713126\asp.net applications(__total__)\compilations total                     __total__              0
\\8dac29713126\asp.net applications(__total__)\debugging requests                     __total__              0
\\8dac29713126\asp.net applications(__total__)\errors during preprocessing            __total__              0
\\8dac29713126\asp.net applications(__total__)\errors during compilation              __total__              0
\\8dac29713126\asp.net applications(__total__)\errors during execution                __total__              0
\\8dac29713126\asp.net applications(__total__)\errors unhandled during execution      __total__              0
\\8dac29713126\asp.net applications(__total__)\errors unhandled during execution/sec  __total__              0
\\8dac29713126\asp.net applications(__total__)\errors total                           __total__              0
\\8dac29713126\asp.net applications(__total__)\errors total/sec                       __total__              0
\\8dac29713126\asp.net applications(__total__)\pipeline instance count                __total__              0
\\8dac29713126\asp.net applications(__total__)\request bytes in total                 __total__              0
\\8dac29713126\asp.net applications(__total__)\request bytes out total                __total__              0
\\8dac29713126\asp.net applications(__total__)\requests executing                     __total__              0
\\8dac29713126\asp.net applications(__total__)\requests failed                        __total__              0
\\8dac29713126\asp.net applications(__total__)\requests not found                     __total__              0
\\8dac29713126\asp.net applications(__total__)\requests not authorized                __total__              0
\\8dac29713126\asp.net applications(__total__)\requests in application queue          __total__              0
\\8dac29713126\asp.net applications(__total__)\requests timed out                     __total__              0
\\8dac29713126\asp.net applications(__total__)\requests succeeded                     __total__              0
\\8dac29713126\asp.net applications(__total__)\requests total                         __total__              0
\\8dac29713126\asp.net applications(__total__)\requests/sec                           __total__              0
\\8dac29713126\asp.net applications(__total__)\sessions active                        __total__              0
\\8dac29713126\asp.net applications(__total__)\sessions abandoned                     __total__              0
\\8dac29713126\asp.net applications(__total__)\sessions timed out                     __total__              0
\\8dac29713126\asp.net applications(__total__)\sessions total                         __total__              0
\\8dac29713126\asp.net applications(__total__)\transactions aborted                   __total__              0
\\8dac29713126\asp.net applications(__total__)\transactions committed                 __total__              0
\\8dac29713126\asp.net applications(__total__)\transactions pending                   __total__              0
\\8dac29713126\asp.net applications(__total__)\transactions total                     __total__              0
\\8dac29713126\asp.net applications(__total__)\transactions/sec                       __total__              0
\\8dac29713126\asp.net applications(__total__)\session state server connections total __total__              0
\\8dac29713126\asp.net applications(__total__)\session sql server connections total   __total__              0
\\8dac29713126\asp.net applications(__total__)\events raised                          __total__              0
\\8dac29713126\asp.net applications(__total__)\events raised/sec                      __total__              0
\\8dac29713126\asp.net applications(__total__)\application lifetime events            __total__              0
\\8dac29713126\asp.net applications(__total__)\application lifetime events/sec        __total__              0
\\8dac29713126\asp.net applications(__total__)\error events raised                    __total__              0
\\8dac29713126\asp.net applications(__total__)\error events raised/sec                __total__              0
\\8dac29713126\asp.net applications(__total__)\request error events raised            __total__              0
\\8dac29713126\asp.net applications(__total__)\request error events raised/sec        __total__              0
\\8dac29713126\asp.net applications(__total__)\infrastructure error events raised     __total__              0
\\8dac29713126\asp.net applications(__total__)\infrastructure error events raised/sec __total__              0
\\8dac29713126\asp.net applications(__total__)\request events raised                  __total__              0
\\8dac29713126\asp.net applications(__total__)\request events raised/sec              __total__              0
\\8dac29713126\asp.net applications(__total__)\audit success events raised            __total__              0
\\8dac29713126\asp.net applications(__total__)\audit failure events raised            __total__              0
\\8dac29713126\asp.net applications(__total__)\membership authentication success      __total__              0
\\8dac29713126\asp.net applications(__total__)\membership authentication failure      __total__              0
\\8dac29713126\asp.net applications(__total__)\forms authentication success           __total__              0
\\8dac29713126\asp.net applications(__total__)\forms authentication failure           __total__              0
\\8dac29713126\asp.net applications(__total__)\viewstate mac validation failure       __total__              0
\\8dac29713126\asp.net applications(__total__)\request execution time                 __total__              0
\\8dac29713126\asp.net applications(__total__)\requests disconnected                  __total__              0
\\8dac29713126\asp.net applications(__total__)\requests rejected                      __total__              0
\\8dac29713126\asp.net applications(__total__)\request wait time                      __total__              0
\\8dac29713126\asp.net applications(__total__)\cache % machine memory limit used      __total__              0
\\8dac29713126\asp.net applications(__total__)\cache % process memory limit used      __total__              0
\\8dac29713126\asp.net applications(__total__)\cache total trims                      __total__              0
\\8dac29713126\asp.net applications(__total__)\cache api trims                        __total__              0
\\8dac29713126\asp.net applications(__total__)\output cache trims                     __total__              0
\\8dac29713126\asp.net applications(__total__)\% managed processor time (estimated)   __total__              0
\\8dac29713126\asp.net applications(__total__)\managed memory used (estimated)        __total__              0
\\8dac29713126\asp.net applications(__total__)\request bytes in total (websockets)    __total__              0
\\8dac29713126\asp.net applications(__total__)\request bytes out total (websockets)   __total__              0
\\8dac29713126\asp.net applications(__total__)\requests executing (websockets)        __total__              0
\\8dac29713126\asp.net applications(__total__)\requests failed (websockets)           __total__              0
\\8dac29713126\asp.net applications(__total__)\requests succeeded (websockets)        __total__              0
\\8dac29713126\asp.net applications(__total__)\requests total (websockets)            __total__              0



Count Name Group
----- ---- -----
   85 0    {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, ...


WARNING: Running container tests... NetworkService
identityType = 1

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}

Name         : Default Web Site
ID           : 1890217144
State        : Stopped
PhysicalPath : c:\inetpub\wwwroot
Bindings     : Microsoft.IIs.PowerShell.Framework.ConfigurationElement


HasMoreData   : True
StatusMessage :
Location      : localhost
Command       :
                    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}

JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : 8bc5325d-e665-4883-9936-82c0d8aa7881
Id            : 1
Name          : ServerLoad
ChildJobs     : {Job2}
PSBeginTime   : 8/29/2017 11:59:56 AM
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




Path                                                                                  InstanceName CookedValue
----                                                                                  ------------ -----------
\\f9b08df79aa8\asp.net applications(__total__)\anonymous requests                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\anonymous requests/sec                 __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total entries                    __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total turnover rate              __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total hits                       __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total misses                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total hit ratio                  __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api entries                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api turnover rate                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api hits                         __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api misses                       __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api hit ratio                    __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache entries                   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache turnover rate             __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache hits                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache misses                    __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache hit ratio                 __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\compilations total                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\debugging requests                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors during preprocessing            __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors during compilation              __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors during execution                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors unhandled during execution      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors unhandled during execution/sec  __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors total                           __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\errors total/sec                       __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\pipeline instance count                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request bytes in total                 __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request bytes out total                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests executing                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests failed                        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests not found                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests not authorized                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests in application queue          __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests timed out                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests succeeded                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests total                         __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests/sec                           __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\sessions active                        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\sessions abandoned                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\sessions timed out                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\sessions total                         __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\transactions aborted                   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\transactions committed                 __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\transactions pending                   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\transactions total                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\transactions/sec                       __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\session state server connections total __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\session sql server connections total   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\events raised                          __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\events raised/sec                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\application lifetime events            __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\application lifetime events/sec        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\error events raised                    __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\error events raised/sec                __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request error events raised            __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request error events raised/sec        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\infrastructure error events raised     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\infrastructure error events raised/sec __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request events raised                  __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request events raised/sec              __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\audit success events raised            __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\audit failure events raised            __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\membership authentication success      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\membership authentication failure      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\forms authentication success           __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\forms authentication failure           __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\viewstate mac validation failure       __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request execution time                 __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests disconnected                  __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests rejected                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request wait time                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache % machine memory limit used      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache % process memory limit used      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache total trims                      __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\cache api trims                        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\output cache trims                     __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\% managed processor time (estimated)   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\managed memory used (estimated)        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request bytes in total (websockets)    __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\request bytes out total (websockets)   __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests executing (websockets)        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests failed (websockets)           __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests succeeded (websockets)        __total__              0
\\f9b08df79aa8\asp.net applications(__total__)\requests total (websockets)            __total__              0



Count Name Group
----- ---- -----
   85 0    {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, ...


WARNING: Running container tests... LocalService
identityType = 0

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}

Name         : Default Web Site
ID           : 1890217144
State        : Started
PhysicalPath : c:\inetpub\wwwroot
Bindings     : Microsoft.IIs.PowerShell.Framework.ConfigurationElement


HasMoreData   : True
StatusMessage :
Location      : localhost
Command       :
                    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}

JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : fa79e149-227c-4cf1-8af6-fd863479d7a4
Id            : 1
Name          : ServerLoad
ChildJobs     : {Job2}
PSBeginTime   : 8/29/2017 12:01:52 PM
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




Path                                                                                  InstanceName      CookedValue
----                                                                                  ------------      -----------
\\a8a6d9daa63c\asp.net applications(__total__)\anonymous requests                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\anonymous requests/sec                 __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache total entries                    __total__                   9
\\a8a6d9daa63c\asp.net applications(__total__)\cache total turnover rate              __total__     8.9907961220099
\\a8a6d9daa63c\asp.net applications(__total__)\cache total hits                       __total__                  34
\\a8a6d9daa63c\asp.net applications(__total__)\cache total misses                     __total__                   9
\\a8a6d9daa63c\asp.net applications(__total__)\cache total hit ratio                  __total__    79.0697674418605
\\a8a6d9daa63c\asp.net applications(__total__)\cache api entries                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache api turnover rate                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache api hits                         __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache api misses                       __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache api hit ratio                    __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache entries                   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache turnover rate             __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache hits                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache misses                    __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache hit ratio                 __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\compilations total                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\debugging requests                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors during preprocessing            __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors during compilation              __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors during execution                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors unhandled during execution      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors unhandled during execution/sec  __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors total                           __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\errors total/sec                       __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\pipeline instance count                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request bytes in total                 __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request bytes out total                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests executing                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests failed                        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests not found                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests not authorized                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests in application queue          __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests timed out                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests succeeded                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests total                         __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests/sec                           __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\sessions active                        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\sessions abandoned                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\sessions timed out                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\sessions total                         __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\transactions aborted                   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\transactions committed                 __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\transactions pending                   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\transactions total                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\transactions/sec                       __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\session state server connections total __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\session sql server connections total   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\events raised                          __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\events raised/sec                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\application lifetime events            __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\application lifetime events/sec        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\error events raised                    __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\error events raised/sec                __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request error events raised            __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request error events raised/sec        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\infrastructure error events raised     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\infrastructure error events raised/sec __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request events raised                  __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request events raised/sec              __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\audit success events raised            __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\audit failure events raised            __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\membership authentication success      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\membership authentication failure      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\forms authentication success           __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\forms authentication failure           __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\viewstate mac validation failure       __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request execution time                 __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests disconnected                  __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests rejected                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request wait time                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache % machine memory limit used      __total__    56.1224489795918
\\a8a6d9daa63c\asp.net applications(__total__)\cache % process memory limit used      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache total trims                      __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\cache api trims                        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\output cache trims                     __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\% managed processor time (estimated)   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\managed memory used (estimated)        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request bytes in total (websockets)    __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\request bytes out total (websockets)   __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests executing (websockets)        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests failed (websockets)           __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests succeeded (websockets)        __total__                   0
\\a8a6d9daa63c\asp.net applications(__total__)\requests total (websockets)            __total__                   0



Count Name             Group
----- ----             -----
   79 0                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCou...
    2 9                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCou...
    1 8.9907961220099  {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    1 34               {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    1 79.0697674418605 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    1 56.1224489795918 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}


Running host test...
Starting setup...

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}
identityType = 4
Exception setting "BufferSize": "Cannot set the buffer size because the size specified is too large or too small.
Parameter name: value
Actual value was 150,3000."
At C:\Users\Administrator\Downloads\docker-aspnet-metrics\entrypoint.ps1:20 char:9
+         $rawUI.BufferSize = $newSize
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], SetValueInvocationException
    + FullyQualifiedErrorId : ExceptionWhenSetting

True    No             NoChangeNeeded {}
True    No             NoChangeNeeded {}

Name         : Default Web Site
ID           : 1
State        : Started
PhysicalPath : c:\inetpub\wwwroot
Bindings     : Microsoft.IIs.PowerShell.Framework.ConfigurationElement


HasMoreData   : True
StatusMessage :
Location      : localhost
Command       :
                    while($true){"Request at $(Get-Date): $((iwr http://localhost/index.aspx -UseBasicParsing).statuscode)"; sleep -Milliseconds 1}

JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : 6ef9cb46-483b-4a78-880e-c51d79796c4b
Id            : 15
Name          : ServerLoad
ChildJobs     : {Job16}
PSBeginTime   : 8/29/2017 12:04:59 PM
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\anonymous requests                            __total__                    1452
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\anonymous requests                     _lm_w3svc_1_root             1452
\\win-qga9jqvvuhg\asp.net applications(__total__)\anonymous requests/sec                        __total__        200.047593412522
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\anonymous requests/sec                 _lm_w3svc_1_root 200.047593412522
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total entries                           __total__                      11
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total entries                    _lm_w3svc_1_root               11
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total turnover rate                     __total__                       0
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total turnover rate              _lm_w3svc_1_root                0
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total hits                              __total__                    4516
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total hits                       _lm_w3svc_1_root             4516
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total misses                            __total__                      51
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total misses                     _lm_w3svc_1_root               51
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache total hit ratio                         __total__        98.8832931902781
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache total hit ratio                  _lm_w3svc_1_root 98.8832931902781
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\compilations total                            __total__                       2
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\compilations total                     _lm_w3svc_1_root                2
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\request bytes out total                       __total__                 1282116
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\request bytes out total                _lm_w3svc_1_root          1282116
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests succeeded                            __total__                    1452
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests succeeded                     _lm_w3svc_1_root             1452
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests total                                __total__                    1452
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests total                         _lm_w3svc_1_root             1452
\\win-qga9jqvvuhg\asp.net applications(__total__)\requests/sec                                  __total__        200.047593412522
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\requests/sec                           _lm_w3svc_1_root 200.047593412522
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\events raised                                 __total__                    1459
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\events raised                          _lm_w3svc_1_root             1459
\\win-qga9jqvvuhg\asp.net applications(__total__)\events raised/sec                             __total__        200.047593412522
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\events raised/sec                      _lm_w3svc_1_root 200.047593412522
\\win-qga9jqvvuhg\asp.net applications(__total__)\application lifetime events                   __total__                       5
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\application lifetime events            _lm_w3svc_1_root                5
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\audit success events raised                   __total__                    1454
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\audit success events raised            _lm_w3svc_1_root             1454
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
\\win-qga9jqvvuhg\asp.net applications(__total__)\cache % machine memory limit used             __total__        56.1224489795918
\\win-qga9jqvvuhg\asp.net applications(_lm_w3svc_1_root)\cache % machine memory limit used      _lm_w3svc_1_root 56.1224489795918
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
    6 1452             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    6 200.047593412522 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    2 11               {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
  136 0                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands....
    2 4516             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 51               {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 98.8832931902781 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 2                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1282116          {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1459             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 5                {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 1454             {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
    2 56.1224489795918 {Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample}
Cleaning up files...
Docker image has not been removed: 'missing-metrics'
```