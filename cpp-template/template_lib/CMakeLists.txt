cmake_minimum_required(VERSION 3.12)
project(template-lib LANGUAGES CXX C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})

find_package(spdlog REQUIRED)

add_executable(hello src/hello.cpp)
target_link_libraries(hello PRIVATE spdlog::spdlog)


include(GNUInstallDirs)
install(TARGETS
        hello
    RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
)