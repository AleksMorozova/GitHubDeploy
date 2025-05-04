# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY GitAction.sln ./  
COPY GitAction/WebApplication1/WebApplication1.csproj GitAction/WebApplication1/

RUN dotnet restore GitAction.sln

COPY . ./

WORKDIR /src/GitAction/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./
EXPOSE 80 443  # Expose ports for HTTP and HTTPS

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
