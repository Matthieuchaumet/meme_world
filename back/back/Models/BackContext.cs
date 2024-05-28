using Microsoft.EntityFrameworkCore;
using back.Models;

namespace back.Models
{
    public class BackContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        public BackContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            // connect to sql server with connection string from app settings
            options.UseSqlServer(Configuration.GetConnectionString("WebApiDatabase"));
        }
        public DbSet<User> Users { get; set; } = null!;

        public DbSet<Products>? Products { get; set; }
    }
}
