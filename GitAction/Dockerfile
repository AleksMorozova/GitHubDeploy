# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy sln and project files
COPY GitAction/GitAction.sln .
COPY GitAction/WebApplication1/WebApplication1.csproj WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj TestProject1/

# Restore dependencies
RUN dotnet restore GitAction.sln

# Copy all source
COPY GitAction/. .

# Publish application
WORKDIR /src/WebApplication1
RUN dotnet publish -c Debug -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
