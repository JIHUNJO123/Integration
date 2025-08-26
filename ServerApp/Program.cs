using ServerApp.Models;

var builder = WebApplication.CreateBuilder(args);

// Add CORS services
builder.Services.AddCors();

// Add response caching for better performance
builder.Services.AddResponseCaching();

var app = builder.Build();

// Configure CORS
app.UseCors(policy =>
    policy.AllowAnyOrigin()
          .AllowAnyMethod()
          .AllowAnyHeader());

// Enable response caching
app.UseResponseCaching();

app.MapGet("/api/productlist", () =>
{
    // Cache the response for 5 minutes to improve performance
    
    var products = new List<Product>
    {
        new Product
        {
            Id = 1,
            Name = "Laptop",
            Price = 1200.50m,
            Stock = 25,
            Category = new Category { Id = 101, Name = "Electronics" }
        },
        new Product
        {
            Id = 2,
            Name = "Headphones",
            Price = 50.00m,
            Stock = 100,
            Category = new Category { Id = 102, Name = "Accessories" }
        },
        new Product
        {
            Id = 3,
            Name = "Mouse",
            Price = 25.99m,
            Stock = 75,
            Category = new Category { Id = 102, Name = "Accessories" }
        },
        new Product
        {
            Id = 4,
            Name = "Keyboard",
            Price = 89.99m,
            Stock = 45,
            Category = new Category { Id = 102, Name = "Accessories" }
        },
        new Product
        {
            Id = 5,
            Name = "Monitor",
            Price = 299.99m,
            Stock = 30,
            Category = new Category { Id = 101, Name = "Electronics" }
        }
    };

    var response = new ProductResponse
    {
        Products = products,
        TotalCount = products.Count
    };

    // Return with caching headers for better performance
    return Results.Ok(response);
});

app.Run();
