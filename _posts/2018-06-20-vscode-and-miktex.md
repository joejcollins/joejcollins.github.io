---
layout: post
---

# On Windows

1. Install Chocolatey

    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

This is largely because Chocolatey has a package to install synctex, which allows you to flip between the PDF and the LaTeX source in VSCode.  MikTeX does include synctex to allow you to do this in TeXworks, but this doesn't work for VSCode.  For convenience you might as well install vscode and miktex using Chocolatey as well, but this isn't essential.

2. Install three packages

    choco install vscode
    choco install miktex.install
    choco install synctex

3. Start the MikTeX Package Manager

    mpm

...and update all the packages.

4. Install LaTeX Workshop for VSCode

    code --install-extension James-Yu.latex-workshop

5. Add a VSCode build task to the project you are working on.

```tasks.json
{
 "version": "0.1.0",
 "isShellCommand": true,
 "suppressTaskName": true,
 "showOutput": "always",
 "tasks": [{
         "taskName": "Build PDF",
         "command": "pdflatex",
         "isBuildCommand": true,
         "args": [
             "-synctex=1",
             "-interaction=nonstopmode",
             "-file-line-error",
             "00Main.tex"
         ]}, {
         "taskName": "Build BibTex",
         "command": "bibtex",
         "isTestCommand": true,
         "args": ["00Main.aux"]
         }]
}
```
The project should build with Ctrl-Shift-B

6. Add a LaTeX Workshop "recipe" to the VSCode workspace settings.

```settings.json
{
    "latex-workshop.latex.recipes": [
        {
            "name": "texify",
            "tools": [
              "pdflatex"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        },
        {
            "name": "texify",
            "command": "texify",
            "args": [
              "--synctex=1",
              "--pdf",
              "--tex-option=\"-interaction=nonstopmode\"",
              "--tex-option=\"-file-line-error\"",
              "%DOC%.tex"
            ]
          }
    ],
    "editor.minimap.enabled": false
}
'''

The project should now build on save (Ctrl-s).

7. Open the PDF viewer with Ctrl-Alt-V or Ctrl-Shift-P > "LaTeX Workshop: View LaTeX PDF file".  In the LaTeX source Right Click > SyncTeX from cursor should take you to the right place in the PDF file. Ctrl-Left Click in the PDF file should take you to the right place in the LaTeX source. 
