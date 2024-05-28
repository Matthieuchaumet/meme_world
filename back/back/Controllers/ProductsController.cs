using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using back.Models;
using Microsoft.AspNetCore.Authorization;

namespace back.Controllers
{
    [Route("api/Products")]
    [ApiController]
    [Authorize]
    public class ProductsController : ControllerBase
    {
        private readonly BackContext _context;

        public ProductsController(BackContext context)
        {
            _context = context;
        }

        // GET: api/Products
        [HttpGet]
        [AllowAnonymous]
        public async Task<ActionResult<IEnumerable<Products>>> GetProducts()
        {
          if (_context.Products == null)
          {
              return NotFound();
          }
            return await _context.Products.ToListAsync();
        }

        // GET: api/Products
        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<IEnumerable<Products>>> GetProductsByUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            if (_context.Products == null)
            {
                return NotFound();
            }
            var products = await _context.Products.Where(p => p.UserId == id).ToListAsync();
            return products;
        }
        // GET: api/Products/5
        [HttpGet("/api/product/{id}")]
        public async Task<ActionResult<Products>> GetProducts(int id)
        {
          if (_context.Products == null)
          {
              return NotFound();
          }
            var products = await _context.Products.FindAsync(id);

            if (products == null)
            {
                return NotFound();
            }

            return products;
        }



        // PUT: api/Products/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("/api/product/{id}")]
        public async Task<IActionResult> PutProducts(int id, Products products)
        {
            if (id != products.Id)
            {
                return BadRequest();
            }

            _context.Entry(products).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Products
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("/api/product/create")]
        public async Task<ActionResult<Products>> PostProducts(Products products)
        {
          if (_context.Products == null)
          {
              return Problem("Entity set 'BackContext.Products'  is null.");
          }
            _context.Products.Add(products);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProducts", new { id = products.Id }, products);
        }

        // DELETE: api/Products/5
        [HttpDelete("/api/product/{id}")]
        public async Task<IActionResult> DeleteProducts(int id)
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            var products = await _context.Products.FindAsync(id);
            if (products == null)
            {
                return NotFound();
            }

            _context.Products.Remove(products);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductsExists(int id)
        {
            return (_context.Products?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
