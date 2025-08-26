# Test script for InventoryHub API
Write-Host "Testing InventoryHub API..." -ForegroundColor Green

# Wait for server to start
Start-Sleep -Seconds 3

# Test the API endpoint
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5169/api/productlist" -UseBasicParsing
    Write-Host "API Response Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "API Response Content:" -ForegroundColor Yellow
    Write-Host $response.Content
} catch {
    Write-Host "Error connecting to API: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Make sure the server is running on port 5169" -ForegroundColor Yellow
}

Write-Host "Test completed." -ForegroundColor Green
