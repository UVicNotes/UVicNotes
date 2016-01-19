# Contributing to UVicNotes

## Making a New Repository

1. [Create the Repository](#create-the-repository)
2. [Set up Content](#set-up-content)
3. [Configure Mkdocs](#configure-mkdocs)
4. [Configure Travis CI](#configure-travis-ci)
5. [Update README and Site URL](#update-readme-and-site-url)

### Create the Repository

To create repositories you must be a member of the UVicNotes Organisation, if you aren't and would like to be please contact [Ben Hawker](mailto:ben@hawker.me). We :heart: new contributors.

Please create reposotories with names using the UVic course code with a dash instead of a space, the description should be the "Course notes for" then the course code then the course name separated with a dash. For example for the course _ELEC 310, Digital Signal Processing I_ you would enter,

* __Repository Name__: `ELEC-310`
* __Repository Description__: `Course Notes for ELEC 310 - Digital Signal Processing I `

You now probably want to clone the repository before starting the next steps.

### Set up Content

Create a directory called `Notes/` this is where notes will go. For GitHub pages to render a main page we need an `index.md`. Below is a sample index file,

```markdown
# ELEC 310

## [Coursespaces](http://coursespaces.uvic.ca/course/view.php?id=14784)

* __Instructor__: Alexandra Albu
* __Office__: EOW 307
* __Email__: [aalbu@uvic.ca](mailto:aalbu@uvic.ca)
* __Office Hours__: Wednesdays, 1:30 PM to 3:30 PM


## Overview

To provide the student with basic knowledge about digital signal processing and the mathematic methods used within this field.

## Textbook

Title: Discrete-Time Signal Processing  
Author: Oppenheim and Schafer  
Publisher: Prentice Hall  
Year: 2009 

## Assessment

| Task        | Weight |
|-------------|:------:|
| Assignments |   20%  |
| Lab         |    ?   |
| Midterms    |   40%  |
| Final       |   40%  |
```

Try to keep it brief and only provide information core to the course. Any links (course website, coursespaces, connex) should be __direct links__, not redirects.

### Configure Mkdocs

[Mkdocs](http://www.mkdocs.org/) is a python based documentation generator. You will need [pip](https://pip.pypa.io/en/stable/installing/), the python package manager to install it,

```bash
pip install mkdocs
```

then create an `mkdocs.yml` config file, below is and example for ELEC 310 (you can just modify it),

```yaml
site_name: ELEC 310
docs_dir: Notes
site_url: http://uvicnotes.github.io/ELEC-310/
repo_url: https://github.com/UVicNotes/ELEC-310
site_description: Course Notes for ELEC 310 - Digital Signal Processing I
site_author: Ben Hawker
extra_javascript: 
    - http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML
    - https://cdn.rawgit.com/UVicNotes/UVicNotes/81099952ba789829fab1840e5d26cb5a2bf62011/helpers/mathjax.js
markdown_extensions:
    - mdx_math
theme: readthedocs
```

if your going to use math in your notes leave the [Mathjax](https://www.mathjax.org/) lines in `mkdocs.yml` and,

```bash
pip install python-markdown-math
```

otherwise you can remove it. Now you can do your first deployment, it's important to deploy once to the `gh-pages` branche before setting up Travis CI as the deploy script will expect the branch to exist.

```
mkdocs gh-deploy --clean
```

### Configure Travis CI

[Travis CI](https://travis-ci.org/) provides continuous integration for free to open source projects. We use it to automatically deploy our notes when we commit them. To get started with Travis you will need to place a `.travis.yml` configuration file in the repository root, here's the one for ELEC 310,

```yaml
sudo: true
before_script: bash ./init.sh
script: bash ./deploy.sh
env:
  global:
  - GH_REF: github.com/UVicNotes/ELEC-310.git
```
 I've omitted a `secret` key which we'll now add. For Travis to push to our repos it will need to authenticate as one of us. Start by generating a [Personal Access Token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/), we're going to encrypt this into our Travis configuration. Grab the Travis command line client if you don't have it already,
 
 ```bash
gem install travis
 ```
 
 then encrypt your token and add it to the config,
 
 ```bash
travis encrypt GH_TOKEN=<YourToken> --add
 ```
now download the [initialization and deployment scripts](https://gist.github.com/bitHero/a90fd974db47fd6554e2). Commit the new files but before pushing turn the build on for the repository on [travis-ci.org](https://travis-ci.org/).

### Update README and Site URL

Lastly, assuming your build is passing, let's update the README, here's the one for ELEC 310,

```markdown
# ELEC 310

[![Build Status](https://travis-ci.org/UVicNotes/ELEC-310.svg?branch=master)](https://travis-ci.org/UVicNotes/ELEC-310)

### [View on GitHub Pages](http://uvicnotes.github.io/ELEC-310/)

## Contributing

If you'd like to contribute your notes please start by forking the repository. Notes should be taken in [Markdown](https://daringfireball.net/projects/markdown/) and we support MathJax (basically LaTeX) for math. Notes should be clear and concise and should have build off of the master notes for that day.

If you have any questions you please feel free to [contact](mailto:ben@hawker.me) the repository maintainer.
```

make sure to update,

* The Title
* The build badge _and_ the link for the badge
* The GitHub Pages link
* The contact email

finally you can update the repository website (next to the description) with the GitHub Pages link, which should by now be live at `uvicnotes.github.io/<CourseCode>`.

