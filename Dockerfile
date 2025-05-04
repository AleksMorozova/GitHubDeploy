# ------------------------------------
# Build stage
# ------------------------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything inside GitAction (including solution, projects, etc.)
COPY GitAction/ ./

# Restore and build using the solution file
RUN dotnet restore GitAction.sln
RUN dotnet build GitAction.sln -c Debug --no-restore

# Optional: Run tests
RUN dotnet test GitAction.sln --no-build --verbosity normal

# Publish the web application project
RUN dotnet publish WebApplication1/WebApplication1.csproj -c Debug -o /app/publish --no-build

# ------------------------------------
# Runtime stage
# ------------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
