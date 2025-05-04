# ------------------------------------
# Build stage
# ------------------------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and all project files
COPY GitAction/ ./

# Restore NuGet packages (cached if nothing changes)
RUN dotnet restore GitAction.sln

# Build the project
RUN dotnet build GitAction.sln -c Debug --no-restore

# Run tests (optional, good for CI/CD)
RUN dotnet test GitAction.sln --no-build --verbosity normal

# Publish the main web app project
RUN dotnet publish GitAction/WebApplication1/WebApplication1.csproj -c Debug -o /app/publish --no-build

# ------------------------------------
# Runtime stage
# ------------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published output from build stage
COPY --from=build /app/publish .

# Expose the port your app uses (optional, typically 80 or 5000)
EXPOSE 8080

# Start the app
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
