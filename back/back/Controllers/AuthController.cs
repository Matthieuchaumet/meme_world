using back.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SimpleJWT.Controllers
{
    [Route("api/login")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly BackContext _context;

        IConfiguration configuration;
        public AuthController(IConfiguration configuration, BackContext context)
        {
            this.configuration = configuration;
            _context = context;
        }




        [AllowAnonymous]
        [HttpPost]
        public  IActionResult Auth([FromBody] User user)
        { 
            IActionResult response = Unauthorized();

            if (user != null)
            {
                var authenticatedUser =  _context.Users.FirstOrDefault(u => u.UserName == user.UserName);
                var passwordHasher = new PasswordHasher<User>();
                var success = passwordHasher.VerifyHashedPassword(authenticatedUser, authenticatedUser.Password, user.Password);

                if (authenticatedUser != null && success == PasswordVerificationResult.Success  && authenticatedUser.Role == 0)
                {
                    // Créer les revendications (claims) du JWT
                    var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Email, user.UserName),
                new Claim("Roles", "User")
            };

                    // Générer le JWT
                    var jwt = GenerateJwtToken(claims);

                    var responseObject = new
                    {
                        user.Id,
                        UserName = user.UserName,
                        Role = "User",
                        Token = jwt
                    };

                    return Ok(responseObject);
                }
                else if (authenticatedUser != null && success == PasswordVerificationResult.Success && user.Role == 1)
                {
                    // Créer les revendications (claims) du JWT
                    var claims = new List<Claim>
            {   
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Email, user.UserName),
                new Claim("Roles", "Admin")
            };

                    // Générer le JWT
                    var jwt = GenerateJwtToken(claims);

                    var responseObject = new
                    {
                        user.Id,
                        user.UserName,
                        Role = "Admin",
                        Token = jwt
                    };

                    return Ok(responseObject);
                }
            }

            return response;
        }

        private string GenerateJwtToken(List<Claim> claims)
        {
            var issuer = configuration["Jwt:Issuer"];
            var audience = configuration["Jwt:Audience"];
            var key = Encoding.UTF8.GetBytes(configuration["Jwt:Key"]);
            var signingCredentials = new SigningCredentials(
                new SymmetricSecurityKey(key),
                SecurityAlgorithms.HmacSha512Signature
            );

            var expires = DateTime.UtcNow.AddMinutes(10);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = expires,
                Issuer = issuer,
                Audience = audience,
                SigningCredentials = signingCredentials
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var jwtToken = tokenHandler.WriteToken(token);

            return jwtToken;
        }

    }
}
