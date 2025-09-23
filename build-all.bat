@echo off
setlocal enabledelayedexpansion

REM Go to the script's directory to ensure relative paths are correct
pushd "%~dp0"

REM Main build process
echo Starting build process for all projects...

REM Core services
echo.
echo Building core dependencies...
SET "CORE_SERVICES=product-api product-util"
FOR %%s IN (%CORE_SERVICES%) DO (
    CALL :build_service %%s
    IF !ERRORLEVEL! NEQ 0 (
        echo.
        echo ERROR: Build process failed at %%s
        GOTO :end
    )
)

REM Microservices
echo.
echo Building microservices...
SET "MICROSERVICES=product-service recommendation-servise review-service product-composite-service product-eureka-server gateway auth-server config-server"
FOR %%s IN (%MICROSERVICES%) DO (
    CALL :build_service %%s
    IF !ERRORLEVEL! NEQ 0 (
        echo.
        echo ERROR: Build process failed at %%s
        GOTO :end
    )
)

echo.
echo All projects built successfully!
GOTO :end

REM Subroutine to build a single service
:build_service
    SET "service_name=%1"
    
    echo.
    echo --- Building !service_name! ---
    
    pushd "..\!service_name!"
    IF !ERRORLEVEL! NEQ 0 (
        echo ERROR: Failed to change directory to ..\!service_name!
        EXIT /B 1
    )
    
    REM On Windows, we call mvnw.cmd. No need to check for executable permissions.
    call mvnw.cmd clean install -DskipTests
    IF !ERRORLEVEL! NEQ 0 (
        echo ERROR: Failed to build !service_name!
        popd
        EXIT /B 1
    )
    
    echo Successfully built !service_name!
    popd
    EXIT /B 0

:end
REM Return to original directory
popd

endlocal
