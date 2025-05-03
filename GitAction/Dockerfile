# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY GitAction/GitAction.sln ./GitAction.sln
COPY GitAction/WebApplication1/WebApplication1.csproj ./WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj ./TestProject1/

# Restore dependencies
RUN dotnet restore ./GitAction.sln

# Copy everything else
COPY GitAction/. ./

# Build and publish
WORKDIR /src/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
