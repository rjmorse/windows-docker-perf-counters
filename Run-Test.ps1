"Building container..."
docker build -t missing-metrics .
write-warning "Running container tests... ApplicationPoolIdentity (default)"
docker run --rm missing-metrics  c:\\entrypoint.ps1 -identityType 4
write-warning "Running container tests... NetworkService"
docker run --rm missing-metrics  c:\\entrypoint.ps1 -identityType 1
write-warning "Running container tests... LocalService"
docker run --rm missing-metrics  c:\\entrypoint.ps1 -identityType 0

"Running host test..."
.\setup.ps1
.\entrypoint.ps1
"Cleaning up files..."
.\cleanup.ps1
"Docker image has not been removed: 'missing-metrics'"