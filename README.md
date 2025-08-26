# InventoryHub - Full Stack Application

This is the InventoryHub inventory management system for a small business. The application consists of a Blazor WebAssembly front-end and a Minimal API back-end.

## Project Structure

```
FS_Course7_Module2/
└── FullStackApp/
    ├── ClientApp/          # Blazor WebAssembly front-end application
    ├── ServerApp/          # Minimal API back-end application
    ├── FullStackSolution.sln
    ├── README.md
    ├── API_SCHEMA.md
    ├── DEBUGGING.md
    ├── ACTIVITY3_SUMMARY.md
    ├── test-api.ps1
    └── test-json-structure.ps1
```

## Setup Instructions

### Prerequisites
- .NET 9.0 SDK or later
- Visual Studio Code or Visual Studio

### Running the Application

1. **Start the Server (Back-end)**
   ```bash
   cd ServerApp
   dotnet run
   ```
   The server will start on `http://localhost:5169`

2. **Start the Client (Front-end)**
   ```bash
   cd ClientApp
   dotnet run
   ```
   The client will start on `http://localhost:5000` (or another available port)

3. **Test the API**
   - Navigate to `http://localhost:5169/api/products` to see the JSON response
   - Navigate to the client application and click on "Products" in the navigation menu

## Features

- **Product List**: Displays products fetched from the API
- **Error Handling**: Comprehensive error handling for API calls
- **Responsive UI**: Bootstrap-based responsive design

## API Endpoints

- `GET /api/productlist`: Returns a structured JSON response with products, categories, and metadata

### JSON Response Structure:
```json
{
  "products": [
    {
      "id": 1,
      "name": "Laptop",
      "price": 1200.50,
      "stock": 25,
      "category": {
        "id": 101,
        "name": "Electronics"
      }
    }
  ],
  "totalCount": 5,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## Debugging Information

### Recent Fixes Applied:
1. **API Route Update**: Changed from `/api/products` to `/api/productlist`
2. **CORS Configuration**: Added CORS policy to allow cross-origin requests
3. **Enhanced Error Handling**: Improved JSON deserialization with case-insensitive property matching
4. **Debug Logging**: Added console logging for troubleshooting
5. **JSON Structure Enhancement**: Added nested category objects and response metadata
6. **Strongly-Typed Models**: Implemented proper C# models for type safety

### Testing the API:
```powershell
# Test the API endpoint
Invoke-WebRequest -Uri "http://localhost:5169/api/productlist" -UseBasicParsing

# Test JSON structure validation
powershell -ExecutionPolicy Bypass -File test-json-structure.ps1
```

## Integration Details

The front-end uses HttpClient to communicate with the back-end API. The integration includes:

- HTTP request handling with proper error management
- JSON deserialization of API responses
- Loading states and error message display
- Dependency injection for HttpClient

## Performance Optimizations

### Back-end Optimizations:
- **Response Caching**: Implemented server-side caching with proper cache headers
- **ETag Support**: Added ETag headers for efficient caching validation
- **Performance Monitoring**: Created metrics tracking for API performance

### Front-end Optimizations:
- **Client-side Caching**: Intelligent caching to reduce redundant API calls
- **Loading States**: Improved user experience with proper loading indicators
- **Error Handling**: Enhanced error handling with user-friendly messages

### Testing Tools:
```powershell
# Performance testing
powershell -ExecutionPolicy Bypass -File performance-test.ps1 -NumberOfRequests 20

# JSON structure validation
powershell -ExecutionPolicy Bypass -File test-json-structure.ps1

# Basic API testing
powershell -ExecutionPolicy Bypass -File test-api.ps1
```

## Project Completion

This project has been successfully completed through 4 comprehensive activities:

1. **Activity 1**: Generated and refined integration code for seamless front-end and back-end communication
2. **Activity 2**: Debugged and resolved integration issues including CORS and JSON parsing
3. **Activity 3**: Implemented well-structured JSON responses with nested objects and metadata
4. **Activity 4**: Optimized performance and created comprehensive documentation

### Key Achievements:
- ✅ Fully functional full-stack application
- ✅ Robust error handling and debugging capabilities
- ✅ Performance optimized with caching strategies
- ✅ Comprehensive documentation and testing tools
- ✅ Professional-grade code quality and structure

## Reflection and Learning

See `REFLECTION.md` for a comprehensive analysis of the development process with Microsoft Copilot, including:
- Development journey through all 4 activities
- Copilot's role in each phase of development
- Challenges overcome and lessons learned
- Best practices discovered for AI-assisted development
- Technical achievements and performance improvements
