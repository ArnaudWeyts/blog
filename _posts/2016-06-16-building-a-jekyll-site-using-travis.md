---
layout: post
title: Building a Jekyll site using Travis
date: 2016-06-16 13:30:00 +0200
categories: travis jekyll

---

This website is hosted on GitHub Pages, using a custom domain, CloudFlare for HTTPS, Jekyll and Travis-CI to build the website.
I use a pretty simple script that builds the Jekyll site and pushes the _site directory to the gh-pages branch.
This is done by my lovely [Block-Bot](https://github.com/Block-Bot).

First of all, if you're completely new to GitHub Pages, you'll have to set up a repository.
You can find information about that right [here](https://pages.github.com).
Go for a project site, and select start from scratch.
If you don't have a custom domain set up, your website will be hosted at `{username}.github.io/{projectname}`.
For more information on setting up a custom domain, check out [this](https://help.github.com/articles/using-a-custom-domain-with-github-pages/) link.

# Setting up your repository
You'll have to clone your repository first to get started.

```bash
$ git clone {repository url}
```

That's it, you won't need to do any other git operations, the deploy script we're gonna write in a bit will take care of the necessary branching.

# Installing and initializing Jekyll
Jekyll is a Ruby gem, so you'll have to [install Ruby](https://www.ruby-lang.org/en/documentation/installation/) first.
Once Ruby is installed you can simply run:

```bash
$ # you might have to sudo this operation
$ gem install jekyll
$ cd {repository}
$ jekyll new . --force
```

This installs Jekyll and turns your repository into a Jekyll environment.
Once the command finishes, your directory structure should look something like this:

```
.
├── README.md
├── _config.yml
├── _includes
│   ├── footer.html
│   ├── head.html
│   ├── header.html
│   ├── icon-github.html
│   └── ...
├── _layouts
│   ├── default.html
│   ├── page.html
│   └── post.html
├── _posts
│   └── 2016-06-16-first-time-trying-out-jekyll.md
├── _sass
│   ├── _base.scss
│   ├── _layout.scss
│   └── _syntax-highlighting.scss
├── about.md
├── css
│   └── main.scss
├── feed.xml
└── index.html
```

Jekyll initialized a default blog with the default theme, and you can already check it out by running:

```bash
$ jekyll serve
```

and navigating to localhost:4000 in your browser.

The `_config.yml` file is the heart of your Jekyll installation, check out [this](https://jekyllrb.com/docs/configuration/) to configure it to your needs. The generated site is available in the `_site` directory. This is what's being served to your localhost:4000.

# Setting up Travis-CI
Log in to your GitHub account on the Travis website & add your repository. Travis provides free workers for public GitHub repositories.
Let's start with installing the Travis gem, this isn't fully necessary, but will be useful later on.

```bash
$ gem install travis
```

We can continue by making a Travis file in our repository root, this is used by Travis to determine the scripts and settings for your worker.

This is the `.travis.yml` file i'm using for this blog.

```yml
sudo: false
language: ruby
rvm:
  - 2.2
branches:
  only:
  - master
# this installs jekyll on the worker
install:
  - gem install jekyll
# this runs the custom deploy script
script:
  - ./buildscripts/deploy.sh
# this is the GitHub access token, more info below, don't copy this
# because the token won't work.
env:
  global:
    - secure: xU/E/Uual0ARqXZALTsUpRdTE9lIyUxeflYfcVEDG812iGq7F/...
```

Next we're gonna have to use a GitHub access token, so that our Travis worker can actually use an account to push to your repository.
It's your decision to make, you can use your own account, or you make a new bot account, and give it push access to the repository.
Click [this link](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) to figure out how to generate an access token for an account.

Once you have your access token, you can encrypt it using Travis, run this command to encrypt the variable and add it to the .travis.yml file.

```bash
$ travis encrypt GH_TOKEN=secret_token --add
```

# The deploy script
To deploy the `_site` directory to the gh-pages branch, we'll have to make use of a deploy script.
I've created a more or less universal version.

It's on GitHub right [here](https://github.com/ArnaudWeyts/blog/blob/master/buildscripts/deploy.sh).
This script will work for any repository, if you fill in your own variables at the beginning & add the build steps in the `doCompile` function.
For a Jekyll blog, the function is simply:

```bash
function doCompile {
    jekyll build
}
```

# That's it!
You just made your own Jekyll blog using Travis, anytime you push to the master branch, Travis will take care of everything and publish your changes online. Happy blogging!


