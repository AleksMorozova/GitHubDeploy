var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Enable Swagger for both development and production
if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Comment this out, HTTPS redirection causes issues in some container setups
// app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// Listen on all interfaces, port 10000 (required by Render)
app.Urls.Add("http://0.0.0.0:10000");

app.Run();
