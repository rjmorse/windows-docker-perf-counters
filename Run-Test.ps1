"Building container..."
docker build -t missing-metrics .
"Running container test..."
docker run --rm missing-metrics
"Running host test..."
.\setup.ps1
.\entrypoint.ps1
"Cleaning up files..."
.\cleanup.ps1
"Docker image has not been removed: 'missing-metrics'"