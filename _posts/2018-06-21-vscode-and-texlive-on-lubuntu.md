---
layout: post
---

## On Lubuntu

Starting with a basic install of Lubuntu which includes TeXLive.
Ensure that Lubuntu has been updated.

### Confirm that LaTeX works

...by installing TeXWorks.

    sudo apt install texworks

This will install a minimal amount of the TeXLive installation as well.
Make a simple `letter` fron the template since this doesn't use any extra packages.
Confirm that Synctex using 'Jump to PDF' and 'Jump to Source'.

Then install a bit more of TeXLive, for example.

    sudo apt install texlive
    sudo apt install texlive-pictures
    sudo apt install texlive-lang-european

TeXLive doesn't install packages automatically the way MikTeX does.
So if you need a package, 
search for it in the package manager (Synaptic)
and install the Ubuntu package that it is contained in.
Don't mess about with the TeXLive manager (tlmgr),
it didn't work out of the box for me on Ubuntu 18.04 LTS (Bionic Beaver).

### Install VSCode

...but first install git (because VSCode will complain if it is not present)
and latexmk (which LaTeX Workshop will use to compile the LaTeX on save).

    sudo apt install git
    sudo apt install latexmk

Then install VSCode and LaTeX Workshop.

    sudo apt install curl
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install code
    code --install-extension James-Yu.latex-workshop

LaTeX Workshop should find latexmk automagically so the LaTeX should be compiled on save.
This is different from MikTeX on Windows which needs a `settings.json` to point to `texify` (the LaTeX compiler, not the beautifier *which is confusing in itself*).

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

### Check SyncTeX

Open the PDF viewer with Ctrl-Alt-V or Ctrl-Shift-P > "LaTeX Workshop: View LaTeX PDF file".  In the LaTeX source Right Click > SyncTeX from cursor should take you to the right place in the PDF file. Ctrl-Left Click in the PDF file should take you to the right place in the LaTeX source. 
