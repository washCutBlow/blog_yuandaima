#!/usr/bin/env sh

hexo clean 
hexo generate 
cp CNAME public/ 
hexo d
