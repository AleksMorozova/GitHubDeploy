# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Inside GitAction/Dockerfile, use full path from GitHubDeploy root:
COPY GitAction/WebApplication1/WebApplication1.csproj GitAction/WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj GitAction/TestProject1/
COPY GitAction/GitAction.sln .

RUN dotnet restore

COPY . ./
WORKDIR /src/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
