# Performance Testing Script for InventoryHub API
param(
    [int]$NumberOfRequests = 10,
    [string]$ApiUrl = "http://localhost:5169/api/productlist"
)

Write-Host "Performance Testing InventoryHub API" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host "Number of requests: $NumberOfRequests" -ForegroundColor Yellow
Write-Host "API URL: $ApiUrl" -ForegroundColor Yellow
Write-Host ""

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$responseTimes = @()
$successCount = 0
$errorCount = 0

for ($i = 1; $i -le $NumberOfRequests; $i++) {
    $requestStopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    try {
        $response = Invoke-WebRequest -Uri $ApiUrl -UseBasicParsing -TimeoutSec 30
        $requestStopwatch.Stop()
        
        $responseTime = $requestStopwatch.ElapsedMilliseconds
        $responseTimes += $responseTime
        $successCount++
        
        Write-Host "Request $i`: $responseTime ms - Status: $($response.StatusCode)" -ForegroundColor Green
        
        # Check cache headers
        if ($response.Headers["Cache-Control"]) {
            Write-Host "  Cache-Control: $($response.Headers["Cache-Control"])" -ForegroundColor Cyan
        }
        if ($response.Headers["ETag"]) {
            Write-Host "  ETag: $($response.Headers["ETag"])" -ForegroundColor Cyan
        }
    }
    catch {
        $requestStopwatch.Stop()
        $errorCount++
        Write-Host "Request $i`: ERROR - $($_.Exception.Message)" -ForegroundColor Red
    }
}

$stopwatch.Stop()
$totalTime = $stopwatch.ElapsedMilliseconds

# Calculate statistics
if ($responseTimes.Count -gt 0) {
    $avgResponseTime = ($responseTimes | Measure-Object -Average).Average
    $minResponseTime = ($responseTimes | Measure-Object -Minimum).Minimum
    $maxResponseTime = ($responseTimes | Measure-Object -Maximum).Maximum
    $requestsPerSecond = [math]::Round($successCount / ($totalTime / 1000), 2)
}

Write-Host ""
Write-Host "Performance Test Results" -ForegroundColor Green
Write-Host "=======================" -ForegroundColor Green
Write-Host "Total Time: $totalTime ms" -ForegroundColor Yellow
Write-Host "Successful Requests: $successCount" -ForegroundColor Green
Write-Host "Failed Requests: $errorCount" -ForegroundColor Red
Write-Host "Success Rate: $([math]::Round(($successCount / $NumberOfRequests) * 100, 2))%" -ForegroundColor Yellow

if ($responseTimes.Count -gt 0) {
    Write-Host ""
    Write-Host "Response Time Statistics" -ForegroundColor Green
    Write-Host "=======================" -ForegroundColor Green
    Write-Host "Average Response Time: $([math]::Round($avgResponseTime, 2)) ms" -ForegroundColor Yellow
    Write-Host "Minimum Response Time: $minResponseTime ms" -ForegroundColor Green
    Write-Host "Maximum Response Time: $maxResponseTime ms" -ForegroundColor Red
    Write-Host "Requests per Second: $requestsPerSecond" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Performance test completed." -ForegroundColor Green
