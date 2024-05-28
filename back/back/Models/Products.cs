namespace back.Models
{
    public class Products
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public int Price { get; set; }

        public string? ImagePath { get; set; }
        public int UserId { get; set; }
        
    }
}
