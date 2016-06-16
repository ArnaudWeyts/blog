---
layout: post
title: How this setup works
date: 2016-06-16 13:30:00 +0200
categories: jekyll theme
comments: true
published: false

---

This website is hosted on GitHub Pages, using a custom domain, CloudFlare for HTTPS, Jekyll and Travis-CI to build the website.
I use a pretty simple script that builds the Jekyll site and pushes the _site directory to the gh-pages branch.
This is done by my lovely [Block-Bot](https://github.com/Block-Bot).

First of all, if your completely new to gh-pages, you'll have to setup a repository.
You can find information about that right [here](https://pages.github.com).
Go for a project site, and select start from scratch.
If you don't have a custom domain setup, your website will be hosted at `{username}.github.io/{projectname}`.
For more information on setting up a custom domain, check out [this](https://help.github.com/articles/using-a-custom-domain-with-github-pages/) link.
