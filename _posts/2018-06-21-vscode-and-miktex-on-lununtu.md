---
layout: post
---

## On Lubuntu

### Install MikTeX

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    sudo apt update
    sudo apt install miktex

### Initialize MikTeX Package Manager

    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
    sudo miktex-console --admin

![Different Chillis]({{ site.url }}/assets/miktex-admin.jpg)

Upgrading using the MPM, this is not really necessary but make the first builds faster and more convenient.

### Add tools

    sudo apt install texworks
    sudo apt install git
    sudo apt install chromium-browser
    sudo update-alternatives --config x-www-browser

### Install VSCode

    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install cod
    code --install-extension James-Yu.latex-workshop

### Add a VSCode build task

...to the project you are working on by editing `tasks.json` like this.

```json
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

### Add a LaTeX Workshop "recipe"

...to the VSCode workspace settings by editing `settings.json` like this.
Unfortunately the `texify` with MikTeX didn't work for me on Lubuntu,
but your mileage may vary.

```json
{
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex",
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
        }
    ],
    "editor.minimap.enabled": false
}
```

The project should now build on save (Ctrl-s).

### Check SyncTeX

Open the PDF viewer with Ctrl-Alt-V or Ctrl-Shift-P > "LaTeX Workshop: View LaTeX PDF file".  In the LaTeX source Right Click > SyncTeX from cursor should take you to the right place in the PDF file. Ctrl-Left Click in the PDF file should take you to the right place in the LaTeX source. 
