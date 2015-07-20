# Haystack

[![Gem Version](https://badge.fury.io/rb/haystack.svg)](http://badge.fury.io/rb/haystack) [![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]() 

**Haystack** is a small searching gem.  It was developed based on work for [Cambridge Systematics](http://www.camsys.com) TransAM Asset Management platform.  It is designed to be

+ driven by rails conventions
+ easy to comprehend
+ simple to extend

## Setup
Haystack has the smarts to search for you, but you'll need to tell it about your domain.  For this purposes, Haystack comes with built in generators to create the searchers you need.  `rails g searcher User` will create an `app/searchers/` directory (if it's the first time you created a searcher), and place a UserSearcher model in it.  It will also create `app/views/searchers/` (again, only if it's the first time) and add two view files (a search form and a results view), but that's all that's needed!

## Usage
TODO
