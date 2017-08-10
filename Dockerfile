FROM microsoft/aspnet

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY *.* /temp/
WORKDIR /temp

RUN /temp/setup.ps1

ENTRYPOINT ["powershell"]
CMD [" c:\\entrypoint.ps1"]
