namespace ServerApp.Models
{
    public class PerformanceMetrics
    {
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
        public string Endpoint { get; set; } = string.Empty;
        public long ResponseTimeMs { get; set; }
        public int StatusCode { get; set; }
        public string? ErrorMessage { get; set; }
    }

    public class ApiResponse<T>
    {
        public T Data { get; set; } = default!;
        public PerformanceMetrics Metrics { get; set; } = new PerformanceMetrics();
        public bool Success { get; set; } = true;
        public string? ErrorMessage { get; set; }
    }
}
