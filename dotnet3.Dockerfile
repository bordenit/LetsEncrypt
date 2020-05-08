## docker build --pull --rm -f "dotnet3.Dockerfile" -t mcmaster:latest "."
## docker run -v ~/x509stores/:/root/.dotnet/corefx/cryptography/x509stores/ -t -d -p 80:80 -p 443:443 -e "ASPNETCORE_ENVIRONMENT=Production" mcmaster:latest
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS env
WORKDIR /src

COPY . .
RUN dotnet restore

FROM env AS publish
RUN dotnet publish samples/Web/Web.csproj -c Release -o /app

FROM base AS final
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Web.dll"]