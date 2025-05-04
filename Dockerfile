# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the solution and project files
COPY GitAction/GitAction.sln ./
COPY GitAction/WebApplication1/WebApplication1.csproj GitAction/WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj GitAction/TestProject1/

# Restore packages
RUN dotnet restore GitAction.sln

# Copy everything else
COPY GitAction/ ./GitAction/

# Build and publish the app
WORKDIR /src/GitAction/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
