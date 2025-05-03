# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

ARG CONFIGURATION=Release

COPY GitAction/GitAction.sln ./
COPY GitAction/WebApplication1/WebApplication1.csproj ./WebApplication1/
COPY GitAction/TestProject1/TestProject1.csproj ./TestProject1/

RUN dotnet restore ./GitAction.sln

COPY GitAction/. ./

WORKDIR /src/WebApplication1
RUN dotnet publish -c $CONFIGURATION -o /app/publish --no-restore

# Final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
