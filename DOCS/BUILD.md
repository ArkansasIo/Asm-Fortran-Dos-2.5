# Build Guide

## Toolchain

The current modern ASM target is x86-64 NASM. Fortran should be built with a Fortran 2003+ compiler supporting modules and derived types. MySQL client development libraries are required when the real native adapter is enabled.

## Build stages

1. Build Fortran modules in dependency order.
2. Assemble ASM modules.
3. Link the Fortran and ASM objects.
4. Configure database connection settings outside source control.
5. Run unit and integration tests.

## Configuration

Use the files under `CONFIG/` as templates. Production secrets belong in environment variables or a secret manager.

## Legacy targets

True 16-bit DOS and native IBM System/360 object-code targets require separate toolchains. The present System/360 mode is an interface/runtime personality, while the modern core is x86-64 ASM plus Fortran.

## Production database

The existing database driver is an abstraction boundary. Production deployment requires a tested MySQL client implementation behind that boundary.
