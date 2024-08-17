FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

WORKDIR /app

COPY HHAExchange.DataExchange.Api/HHAExchange.DataExchange.Api.csproj HHAExchange.DataExchange.Api/
COPY HHAExchange.DataExchange.Api.IntegrationTests/HHAExchange.DataExchange.Api.IntegrationTests.csproj HHAExchange.DataExchange.Api.IntegrationTests/
COPY HHAExchange.DataExchange.ApiClient/HHAExchange.DataExchange.ApiClient.csproj HHAExchange.DataExchange.ApiClient/
COPY HHAExchange.DataExchange.Events/HHAExchange.DataExchange.Events.csproj HHAExchange.DataExchange.Events/

RUN dotnet restore HHAExchange.DataExchange.Api/HHAExchange.DataExchange.Api.csproj

COPY . .

RUN dotnet build HHAExchange.DataExchange.Api/HHAExchange.DataExchange.Api.csproj -c Debug -o /app/build

RUN dotnet publish HHAExchange.DataExchange.Api/HHAExchange.DataExchange.Api.csproj -c Debug -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "HHAExchange.DataExchange.Api.dll"]

