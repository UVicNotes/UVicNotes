# Contributing to UVicNotes

## Making a New Repository

1. [Create the Repository](#create-the-repository)
2. [Set up Content](#set-up-content)
3. [Configure Mkdocs](#configure-mkdocs)
4. [Configure Travis CI](#configure-travis-ci)
5. [Update Site URL](#update-site-url)

### Create the Repository

To create repositories you must be a member of the UVicNotes Organisation, if you aren't and would like to be please contact [Brynn Hawker](mailto:brynn@hawker.me). We :heart: new contributors.

Please create reposotories with names using the UVic course code with a dash instead of a space, the description should be the "Course notes for" then the course code then the course name separated with a dash. For example for the course _ELEC 310, Digital Signal Processing I_ you would enter,

* __Repository Name__: `ELEC-310`
* __Repository Description__: `Course Notes for ELEC 310 - Digital Signal Processing I `

Initialize the repository with a `README.md` file and clone it to your machine.

On your machine create the `gh-pages` branch so travis has a branch to push to.

```bash
git checkout -b gh-pages
git push -u origin gh-pages
git checkout master
```

Let's update the README, here's the one for CSC 370,

```markdown
# CSC 370

[![Build Status](https://travis-ci.org/UVicNotes/CSC-370.svg?branch=master)](https://travis-ci.org/UVicNotes/CSC-370)

### [View on GitHub Pages](http://uvicnotes.github.io/CSC-370/)

## Contributing

If you'd like to contribute your notes please start by forking the repository. Notes should be taken in [Markdown](https://daringfireball.net/projects/markdown/) and we support MathJax (basically LaTeX) for math. Notes should be clear and concise and should have build off of the master notes for that day.

If you have any questions you please feel free to [contact](mailto:brynn@hawker.me) the repository maintainer.
```

make sure to update,

* The Title
* The build badge _and_ the link for the badge
* The GitHub Pages link
* The contact email

Also, download the `.gitignore` for UVicNotes,

```bash
wget https://raw.githubusercontent.com/UVicNotes/UVicNotes/master/scripts/\.gitignore
```

Commit and push the changes to `README.md` and the new `.gitignore` file.

### Set up Content

Create a directory called `Notes/` this is where notes will go. For GitHub pages to render a main page we need `Notes/index.md`. Below is a sample index file,

```markdown
# CSC 370

## [Connex](https://connex.csc.uvic.ca/portal/site/260f967a-d51f-4bb8-b01a-82f93e87504d/)

* __Instructor__: Alex Thomo
* __Office__: ECS 556
* __Email__: [thomo@cs.uvic.ca](mailto:thomo@cs.uvic.ca)
* __Office Hours__:
  * Wednesdays, 2:30 PM to 3:30 PM
  * Firdays, 3:30 PM to 4:30 PM

## Overview

This course is an introduction to database systems. Topics include database design, query languages, query optimization, concurrency control, and recovery from failures.

## Textbook

* Database Systems: The Complete Book
    * Author: Hector Garcia-Molina, Jeffrey D. Ullman, and   * Jennifer D. Widom
    * Publisher: Prentice Hall
    * ISBN: 0131873253
    * Year: 2008
    * Edition: 2nd Edition


## Assessment

| Task        | Weight |
|-------------|:------:|
| Assignments |   30%  |
| Midterm     |   20%  |
| Final       |   50%  |
```

Try to keep it brief and only provide information core to the course. Any links (course website, coursespaces, connex) should be __direct links__, not redirects.

### Configure Mkdocs

[Mkdocs](http://www.mkdocs.org/) is a python based documentation generator. Create an `mkdocs.yml` config file, below is and example for CSC 370 (you can just modify it),

```yaml
site_name: CSC 370
docs_dir: Notes
theme_dir: theme
site_url: http://uvicnotes.github.io/CSC-370/
repo_url: https://github.com/UVicNotes/CSC-370
site_description: Course Notes for CSC 370 - Foundations of Computer Science
site_author: Brynn Hawker
extra_javascript:
    - https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML
    - https://cdn.rawgit.com/UVicNotes/UVicNotes/81099952ba789829fab1840e5d26cb5a2bf62011/helpers/mathjax.js
markdown_extensions:
    - mdx_math
extra:
  version: 'Spring 2017'
  palette:
    primary: 'cyan'
    accent: 'orange'
  author:
    github: 'UVicNotes'
```

You can change the color to one of [these color names](https://www.materialui.co/colors) and make sure you update the version to be your current semester. You can put yourself for the author or leave UVicNotes.

If your going to use math in your notes leave the [Mathjax](https://www.mathjax.org/) lines in `mkdocs.yml`, otherwise you can remove it.

### Configure Travis CI

[Travis CI](https://travis-ci.org/) provides continuous integration for free to open source projects. We use it to automatically deploy our notes when we commit them. To get started with Travis you will need to place a `.travis.yml` configuration file in the repository root, here's the one for CSC 370,

```yaml
sudo: true
language: node_js
node_js:
  - "6"
install:
  - sudo pip install mkdocs python-markdown-math
  - npm install -g bower gulp
before_script: wget https://raw.githubusercontent.com/UVicNotes/UVicNotes/master/scripts/deploy.sh
script: bash ./deploy.sh
env:
  global:
  - GH_REF: github.com/UVicNotes/CSC-370.git
```

**Make sure to change the `GH_REF` to your repository.**

 I've omitted a `secret` key which we'll now add. For Travis to push to our repos it will need to authenticate as one of us. Start by generating a [Personal Access Token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/), we're going to encrypt this into our Travis configuration. Grab the Travis command line client if you don't have it already,

 ```bash
gem install travis
 ```

 then encrypt your token and add it to the config,

 ```bash
travis encrypt GH_TOKEN=<YourToken> --add
 ```

Commit the new files but before pushing turn the build on for the repository on [travis-ci.org](https://travis-ci.org/).

### Update Site URL

Finally you can update the repository website (next to the description) with the GitHub Pages link, which should by now be live at `uvicnotes.github.io/<CourseCode>`.

