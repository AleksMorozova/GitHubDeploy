# Start from the .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy the solution file and project files from the root directory (since we're building from the root)
COPY GitAction.sln ./
COPY WebApplication1/WebApplication1.csproj WebApplication1/
COPY TestProject1/TestProject1.csproj TestProject1/

# Restore dependencies
RUN dotnet restore

# Publish the application to a folder inside the container
COPY . ./
RUN dotnet publish WebApplication1/WebApplication1.csproj -c Release -o /app/publish

# Set the base image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
