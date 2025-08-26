namespace ServerApp.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public int Stock { get; set; }
        public Category Category { get; set; } = new Category();
    }

    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }

    public class ProductResponse
    {
        public List<Product> Products { get; set; } = new List<Product>();
        public int TotalCount { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    }
}
