# InventoryHub Debugging Guide

## Issues Resolved in Activity 2

### 1. Incorrect API Route
**Problem**: Front-end was calling `/api/products` but back-end endpoint was updated to `/api/productlist`

**Solution**: Updated the API call in `FetchProducts.razor`:
```csharp
// Before
products = await Http.GetFromJsonAsync<Product[]>("http://localhost:5169/api/products");

// After
var response = await Http.GetAsync("http://localhost:5169/api/productlist");
```

### 2. CORS Errors
**Problem**: Security restrictions preventing front-end from accessing back-end API

**Solution**: Added CORS configuration in `ServerApp/Program.cs`:
```csharp
// Add CORS services
builder.Services.AddCors();

// Configure CORS
app.UseCors(policy =>
    policy.AllowAnyOrigin()
          .AllowAnyMethod()
          .AllowAnyHeader());
```

### 3. Malformed JSON Handling
**Problem**: Back-end developer modified API response structure, breaking front-end display

**Solution**: Enhanced error handling in `FetchProducts.razor`:
```csharp
try
{
    var response = await Http.GetAsync("http://localhost:5169/api/productlist");
    response.EnsureSuccessStatusCode();
    
    var json = await response.Content.ReadAsStringAsync();
    Console.WriteLine($"API Response: {json}"); // Debug logging
    
    products = JsonSerializer.Deserialize<Product[]>(json, new JsonSerializerOptions
    {
        PropertyNameCaseInsensitive = true
    });
}
catch (HttpRequestException ex)
{
    errorMessage = $"Error fetching products: {ex.Message}";
    Console.WriteLine($"HTTP Error: {ex.Message}");
}
catch (JsonException ex)
{
    errorMessage = $"Error parsing product data: {ex.Message}";
    Console.WriteLine($"JSON Error: {ex.Message}");
}
```

## Debugging Steps

### 1. Check Server Status
```powershell
# Check if server is running on port 5169
netstat -an | findstr :5169
```

### 2. Test API Endpoint
```powershell
# Test the API directly
Invoke-WebRequest -Uri "http://localhost:5169/api/productlist" -UseBasicParsing
```

### 3. Check Browser Console
- Open browser developer tools (F12)
- Check Console tab for error messages
- Check Network tab for failed requests

### 4. Verify CORS Configuration
- Ensure CORS middleware is added before routing
- Check that CORS policy allows the client origin

### 5. Test JSON Response
- Verify API returns valid JSON
- Check property names match front-end model
- Use case-insensitive deserialization for flexibility

## Common Issues and Solutions

### Issue: "Unable to connect to remote server"
**Solution**: 
- Ensure server is running: `dotnet run` in ServerApp directory
- Check port configuration in launchSettings.json
- Verify firewall settings

### Issue: CORS errors in browser console
**Solution**:
- Add CORS middleware to server
- Ensure CORS is configured before routing
- Check that client origin is allowed

### Issue: JSON parsing errors
**Solution**:
- Use `PropertyNameCaseInsensitive = true` in JsonSerializerOptions
- Add try-catch blocks for JsonException
- Log raw JSON response for debugging

### Issue: Products not displaying
**Solution**:
- Check API endpoint URL is correct
- Verify Product model properties match API response
- Add debug logging to see API response

## Testing Checklist

- [ ] Server starts without errors
- [ ] API endpoint responds with valid JSON
- [ ] CORS allows client requests
- [ ] Front-end can fetch and display products
- [ ] Error messages are displayed appropriately
- [ ] Console logging shows successful API calls
