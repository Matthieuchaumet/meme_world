namespace back.Models
{
    public class User
    {
        public int Id { get; set; }
        public string? UserName { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }

        public string? ImagePath { get; set; }
        public string? Adresse { get; set; }
        public int Role { get; set; }
       
    }
}
