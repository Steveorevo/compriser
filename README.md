# Compriser - A Package Manager for Xojo
Compriser is an external Xojo build script for dependency management in Xojo. It allows your project to *comprise* of external components and will manage obtaining and including the items for you. This allows you to focus on your code and promote code reuse with Xojo's hallmark for fast development and easy deployment.

## Dependency Management
The idea behind Compriser is not new and it's concepts are inspired by PHP's Composer, NodeJS' NPM, and Ruby's Builder.

Simply include the external script compriser.xojo_script in your project's build and run/build your project. Alternatively, we've even made a template for you so that you can kickstart any new project using Compriser *TODO: insert template project download link here* right away.

The Compriser build script will automatically download and install the open source compriser runtime the first time you use it within your ~/.compriser folder (for more information, see the global cache under "Version Checking and Caching").

Compriser will read all of your project's Notes for any notes titled "Compriser". Within the Compriser note, simply list the URLs to the external dependencies your project depends on under the section header [requires] followed by a comma or carriage delimited list of the specific objects you'd like to include within your project. For example, a note could contain the following:

```[requires]
https://github.com/Steveorevo/ControlSnapshot/archive/master.zip
ControlSnapshot.xojo_code
```

Compriser will do the work of obtaining the external dependencies for you under a subfolder called vendor. Once more, it will fetch any dependencies of dependencies those projects depend upon and also include them in the vendor subfolder. Specifying source code (i.e.  ControlSnapshot.xojo_code) is optional. Omitting specific source will cause Compriser to scan for the first xojo_project file and include all source files specified within the project file.

Next, Compriser will create or update a new project file called [project_name].lock.xojo_project and load it (where [project_name] is the same as your original xojo_project file). The "lock" version of the project file will include the fetched external components linked in with the "vendor" subfolder that will allow the build process resume. Note: You only need to checkin your original xojo_project file and source files. You do not need to redistribute the lock.xojo_project file or any files within the vendor subfolder.

Compriser will automatically maintain your original project file sans the vendor folder with it's original name. When you work on your project you can open either, but it's **recommended** that you work with the lock.xojo_project file (since it will contain references to all your dependencies). You only need to redistribute your original xojo_project file to share with others as it will be "skinny" and not include references to the external vendor dependencies. Just be sure to perform a run or build to ensure that your original xojo_project file is updated.

## Version Checking and Caching
Compriser does not currently support dependency version checks or wildcards but may in the future. To simplify the requires section in Compriser, you specify a link to the exact zip archive your project depends on. In this way, your project can benefit from external resources from a multitude of locations. Thankfully, requiring a specific version of an external dependency is greatly simplified because specific version numbers are already included in a given URL from popular source code control systems (like github.com and gitlab.com, i.e. version "1.0.0" is apart of the URL ```https://github.com/Steveorevo/compriser/archive/v1.0.0.zip```).

For resource caching, Compriser will download and store require definitions in a global cache typically inside ~/.compriser (where ~ is the current user folder on MacOS or ~/AppData/Local/compriser on Windows) and will utilize the cache folder to accelerate obtaining resources amongst shared projects. Simply clearing the folder or a specific item will cause Compriser to download the given resource again. Version conflicts are already avoided by the unique URL containing the version number (see typical github, gitlab URLs above).

## Other Development Perks
Compriser is designed to work with git, the most comprehensive and popular software version control system. As such, Compriser will generate a default .gitignore file if one isn't already present. By default the .gitignore file will already list common files and folders that don't need to be redistributed with a given project; including pesky temporary files and large build folders (if you want to release built binaries with your project, reference https://help.github.com/articles/creating-releases/). The default content of a .gitignore file will have the following:

```.DS_Store
/Builds - *
*.xojo_uistate    
*.debug    
```

## Self updating
Compriser automatically updates itself to ensure you benefit from the latest version. Compriser checks to see if a new compriser.xojo_script exists once (and only once) a day by checking the comprise.xojo_script timestamp != the current day, then compares the latest online version number. If the version numbers differ, Compriser will asks the user if they want to update to the latest.
