# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy only .csproj files for restore caching
COPY GitAction/GitAction.sln .
COPY GitAction/WebApplication1/WebApplication1.csproj GitAction/WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj GitAction/TestProject1/

# Restore dependencies
RUN dotnet restore ./GitAction.sln

# Copy the rest of the source code
COPY GitAction/ ./GitAction/

# Change directory into the web project and build
WORKDIR /src/GitAction/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
