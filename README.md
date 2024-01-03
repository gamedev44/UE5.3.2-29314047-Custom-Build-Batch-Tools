# Unreal Engine Batch Scripts

This repository, curated and created by P.G.D., contains a collection of enhanced batch scripts for automating various tasks in Unreal Engine development. Located in the `BatchFiles` folder, these scripts have been revamped to improve usability and functionality.

## Features

### General Enhancements Across Scripts

- **Menu-Based User Interaction**: Provides a user-friendly interface with easy navigation and execution of tasks.
- **Error Logging**: Errors encountered are logged into a "Logfile.txt" within an "Error Logs" folder for each script, aiding in troubleshooting and debugging.
- **Windows File Explorer Integration**: Allows graphical file selection for certain operations, enhancing the user experience.

### Script-Specific Enhancements

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

 P.G.D. is responsible the creation and maintenance of these scripts, contributing to the Unreal Engine development community.
