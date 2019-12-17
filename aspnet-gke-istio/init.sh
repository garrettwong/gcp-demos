#!/bin/sh

dotnet new mvc -o HelloWorldAspNetCore
cd HelloWorldAspNetCore
dotnet run --urls=http://localhost:8080
dotnet publish -c Release
cd bin/Release/netcoreapp3.0/publish/
