# Unreal Engine Batch Scripts

This repository, curated and created by P.G.D., contains a collection of enhanced batch scripts for automating various tasks in Unreal Engine development. Located in the `BatchFiles` folder, these scripts have been revamped to improve usability and functionality.

## Features

### Script-Specific Enhancements

#### Module Rebuilder

- **Script Name**: `ModuleRebuilder.bat`
- **Features**:
  - Batch script for rebuilding Unreal Engine modules.
  - Provides an automated solution for module rebuilding tasks.

#### Build Script for Unreal Engine 5.3.2

- **Script Name**: `UE5_Build_Script.bat`
- **Features**:
  - Options for entering game name, platform name, and configuration name via a menu.
  - Integration with Windows File Explorer for selecting game project files.
  - Dynamic build process adjustments based on user inputs.
  - Comprehensive error logging in `Error Logs\Logfile.txt`.

#### Automation Tool Setup Script (PowerShell)

- **Script Name**: `AutomationTool_Setup_Script.ps1`
- **Features**:
  - PowerShell script with an interactive menu to execute `RunUAT.bat`.
  - Error logging functionality to capture issues during execution.

#### Rebuild Plugin Script

- **Script Name**: `RebuildPlugin.bat`
- **Features**:
  - Interactive prompts for user input on the source and target Unreal Engine versions.
  - Options to select plugins using File Explorer.
  - Detailed error logging for each step of the plugin rebuilding process.

#### Unreal Engine Cleanup Script

- **Script Name**: `Cleanup_UE_Script.bat`
- **Features**:
  - Streamlined process for cleaning up Unreal Engine project builds.
  - Automated error detection and logging.

#### RunUAT Batch Script

- **Script Name**: `RunUAT.bat`
- **Features**:
  - Enhanced for better script execution with added error handling and logging.
  - Modified to support various command-line arguments and user inputs.
  - Useful for automating Unreal Automation Tool tasks.

#### Clean Script

- **Script Name**: `Clean.bat`
- **Features**:
  - Streamlined process for cleaning up Unreal Engine project builds.
  - Automated error detection and logging.

#### RunUAT Command Script

- **Script Name**: `RunUAT.command`
- **Features**:
  - Enhanced for better script execution with added error handling and logging.
  - Modified to support various command-line arguments and user inputs.
  - Useful for automating Unreal Automation Tool tasks.

#### GetDotnetPath Script

- **Script Name**: `GetDotnetPath.bat`
- **Features**:
  - Batch script for retrieving the path to the Dotnet SDK.
  - Useful for ensuring Dotnet is correctly configured.

#### GetMSBuildPath Script

- **Script Name**: `GetMSBuildPath.bat`
- **Features**:
  - Batch script for retrieving the path to MSBuild.
  - Helps ensure that MSBuild is properly configured for your Unreal Engine development.

#### Make and Install SSH Key Script

- **Script Name**: `MakeAndInstallSSHKey.bat`
- **Features**:
  - Batch script to create and install SSH keys, typically used for version control systems like Git.
  - Enhances the development environment setup.

## Usage

1. Clone or download this repository.
2. Navigate to the `BatchFiles` folder.
3. Execute the desired batch script, following the on-screen instructions.

## Contributing

Contributions, suggestions, and enhancements are welcome. Please adhere to the standard GitHub pull request process for proposing changes.

## License

This project is open source and free to use under the MIT License. The MIT License is a permissive free software license originating at the Massachusetts Institute of Technology (MIT). It puts only very limited restriction on reuse and has, therefore, high license compatibility.

For the full license text, see [LICENSE](LICENSE).

## Acknowledgements

P.G.D. is responsible for the creation and maintenance of these scripts, contributing to the Unreal Engine development community.
