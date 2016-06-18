---
layout: post
title: Building a Jekyll site using Travis
date: 2016-06-16 13:30:00 +0200
categories: jekyll theme

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


# The deploy script
To deploy the `_site` directory to the gh-pages branch, we'll have to make use of a deploy script.

## This blogpost is a work in progress, I just wanted to publish it already because I can.

## To be continued...


