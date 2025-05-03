# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY GitAction.sln ./
COPY TestProject1/TestProject1.csproj TestProject1/
COPY WebApplication1/WebApplication1.csproj WebApplication1/

RUN dotnet restore

COPY . ./
WORKDIR /src/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]