# ---------- Stage 1: Build and Test ----------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy solution and project files
COPY GitAction.sln ./
COPY TestProject1/TestProject1.csproj TestProject1/
COPY WebApplication1/WebApplication1.csproj WebApplication1/

# Restore dependencies
RUN dotnet restore GitAction.sln

# Copy the rest of the code
COPY . .

# 🧪 Run tests - this will fail the build if tests fail
RUN dotnet test TestProject1/TestProject1.csproj --no-build --verbosity normal

# 📦 Publish the web app
RUN dotnet publish WebApplication1/WebApplication1.csproj -c Release -o /app/publish

# ---------- Stage 2: Runtime ----------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

# Copy published app from build stage
COPY --from=build /app/publish .

# Expose web port
EXPOSE 80

# Start the web app
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
