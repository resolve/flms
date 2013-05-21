= Flms [![Build Status](https://travis-ci.org/Originate-Inc/flms.png?branch=travis)](https://travis-ci.org/Originate-Inc/flms) [![Code Climate](https://codeclimate.com/github/Originate-Inc/flms.png)](https://codeclimate.com/github/Originate-Inc/flms) [![Coverage Status](https://coveralls.io/repos/Originate/flms/badge.png?branch=master)](https://coveralls.io/r/Originate/flms) [![Dependency Status](https://gemnasium.com/Originate/flms.png)](https://gemnasium.com/Originate/flms)

FLMS: the Floating Layer Management System
==========================================

FLMS is a CMS for web pages that use interactive layers to present animated content.  Essentially, it is an easy way to leverage the excellent [skrollr.js library](https://github.com/Prinzhorn/skrollr), included in this plugin. Creating the numerous data-xxxx styling tags to animate skrollr content gets tedious quickly, so FLMS automates the task.

Via the CMS, users can create 'layers' containing various types of rich content:
* Basic images (uploader included)
* Text banners
* Paragraphs with headings
* Embedded HTML (useful for things like YouTube videos and the like)
* Animated images (sprited animations that progress as the viewer scrolls)

The end result: create animated, parallax-scrolling sites via a CMS without needing to write a line of code.  So sweet.

Setup
-----

Install the engine in your Rails app:
    gem install flms

Install FLMS-related migrations to the host app and run them:
    rake flms:install:migrations
    rake db:migrate

Create a default admin user:
    rake flms:FIXMEFIXME

...start your rails server, and you can log in at 0.0.0.0:3000/flms/login.

Basic Concepts
==============

FLMS includes a built-in user authentication built via Devise, and the FLMS CMS pages all require login (with a few exceptions as noted below).  The intent is to allow users to get up and running quickly with a usable CMS in a minimum of fuss.

FLMS includes the Carrierwave gem for handling file uploads.

Content in FLMS is built around the following core models: Layers, Blocks, and Pages.

Layers
------

The primary content model is the layer.  A layer in the most basic sense is a HTML DIV element that is animated via a series of  keyframes (i.e., snapshots of CSS properties).  The DIV can contain any content desired, although FLMS provides some basic layer types that provide an easy shortcut for creating basic animations.

The following 'simplified' layer types are provided by FLMS:
* Image: a simple div containing an uploaded image as the background-image.
* Text: a textual string, with controls for text size and color.
* Paragraph: a 'descriptive' block of text, with a header and body copy.
* Embed: allows users to embed arbitrary HTML, very useful for things like video elements from YouTube.
* Animation: users can upload an image containing animation frames vertically stiched together as a sprite, and specify how 'playback' of the animation frames is performed as the user scrolls.

These layer types simplify the process of creating animations by placing some constraints on how the animations are constructed. Specifically, the layers contain only three keyframes, to specify the beginning ('start'), middle ('target'), and final ('end') state of the layer.  The keyframes allow for animation of a small set of common CSS attributes.  Even with these constraints, a wide variety of animations can be created.

In addition to these types, FLMS provides an 'advanced' layer type that allows for an arbitrary number of keyframes and much greater power in CSS animation.

Blocks
------

A block is a collection of layers.  By definition parallax scrolling requires the differing movement of several layers simultaneously, so FLMS collects a set of layers within a block.  Blocks are identified by both a CSS name and human-friendly name, and can be given a thumbnail identifier image.

Pages
-----

A page is given a name and a URL, and houses a collection of blocks, which are shown to the user in sequence as they scroll down the body of the page.

Pages provide a convenient endpoint for populating content into the host Rails app - simply add the following catch-all line to your routes.rb file in the host app to show FLMS pages as if they were full-fledged elements of your site:

    match '*id' => 'flms/pages#show'

Technical
=========

TBA

Credits
=======

FLMS is brought to you by the fine folks at [Originate](www.originate.com), and is distributed under the MIT-LICENSE.
Thanks of course due to Alexander Prinzhorn and the team behind the Skrollr library, on top of which this project is built.
