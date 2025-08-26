# Test script for InventoryHub JSON Structure Validation
Write-Host "Testing InventoryHub JSON Structure..." -ForegroundColor Green

# Wait for server to start
Start-Sleep -Seconds 3

# Test the API endpoint
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5169/api/productlist" -UseBasicParsing
    Write-Host "API Response Status: $($response.StatusCode)" -ForegroundColor Green
    
    # Parse JSON response
    $jsonData = $response.Content | ConvertFrom-Json
    
    Write-Host "`nJSON Structure Validation:" -ForegroundColor Yellow
    
    # Validate root structure
    if ($jsonData.products -and $jsonData.totalCount -and $jsonData.timestamp) {
        Write-Host "✅ Root structure is valid" -ForegroundColor Green
    } else {
        Write-Host "❌ Root structure is invalid" -ForegroundColor Red
    }
    
    # Validate products array
    if ($jsonData.products -is [array]) {
        Write-Host "✅ Products is an array with $($jsonData.products.Count) items" -ForegroundColor Green
        
        # Validate each product
        foreach ($product in $jsonData.products) {
            Write-Host "`nProduct ID: $($product.id)" -ForegroundColor Cyan
            
            # Check required fields
            $requiredFields = @('id', 'name', 'price', 'stock', 'category')
            $missingFields = @()
            
            foreach ($field in $requiredFields) {
                if (-not $product.$field) {
                    $missingFields += $field
                }
            }
            
            if ($missingFields.Count -eq 0) {
                Write-Host "  ✅ All required fields present" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Missing fields: $($missingFields -join ', ')" -ForegroundColor Red
            }
            
            # Validate category structure
            if ($product.category.id -and $product.category.name) {
                Write-Host "  ✅ Category structure is valid" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Category structure is invalid" -ForegroundColor Red
            }
            
            # Validate data types
            if ($product.id -is [int]) {
                Write-Host "  ✅ ID is integer" -ForegroundColor Green
            } else {
                Write-Host "  ❌ ID is not integer" -ForegroundColor Red
            }
            
            if ($product.price -is [decimal] -or $product.price -is [double]) {
                Write-Host "  ✅ Price is numeric" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Price is not numeric" -ForegroundColor Red
            }
            
            if ($product.stock -is [int]) {
                Write-Host "  ✅ Stock is integer" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Stock is not integer" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "❌ Products is not an array" -ForegroundColor Red
    }
    
    # Validate metadata
    if ($jsonData.totalCount -is [int]) {
        Write-Host "✅ TotalCount is integer: $($jsonData.totalCount)" -ForegroundColor Green
    } else {
        Write-Host "❌ TotalCount is not integer" -ForegroundColor Red
    }
    
    if ($jsonData.timestamp) {
        Write-Host "✅ Timestamp is present: $($jsonData.timestamp)" -ForegroundColor Green
    } else {
        Write-Host "❌ Timestamp is missing" -ForegroundColor Red
    }
    
    Write-Host "`nRaw JSON Response:" -ForegroundColor Yellow
    Write-Host ($response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 3)
    
} catch {
    Write-Host "Error connecting to API: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Make sure the server is running on port 5169" -ForegroundColor Yellow
}

Write-Host "`nJSON Structure Test completed." -ForegroundColor Green
