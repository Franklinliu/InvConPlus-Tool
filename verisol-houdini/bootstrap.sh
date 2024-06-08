export VERISOL_PATH=$(pwd)
dotnet tool uninstall --global VeriSol
dotnet build Sources/VeriSol.sln
dotnet tool install VeriSol --version 0.1.5-alpha --global --add-source $VERISOL_PATH/nupkg/