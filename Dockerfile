# Stage 1 - Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /source

# Copy solution and restore dependencies
COPY GitAction/GitAction.sln ./
COPY GitAction/WebApplication1/*.csproj ./WebApplication1/
RUN dotnet restore ./WebApplication1/WebApplication1.csproj

# Copy all files and publish
COPY GitAction/WebApplication1/. ./WebApplication1/
WORKDIR /source/WebApplication1
RUN dotnet publish -c Release -o /app/publish

# Stage 2 - Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app
COPY --from=build /app/publish ./

# Set environment and expose port Render uses
ENV ASPNETCORE_URLS=http://0.0.0.0:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
