FROM mcr.microsoft.com/dotnet/core/aspnet:3.0
ADD ./ /app
ENV ASPNETCORE_URLS=http://*:${PORT}
WORKDIR /app
ENTRYPOINT [ "dotnet", "HelloWorldAspNetCore.dll"]
