#!/bin/bash

# Change directory into the specified directory
cd $1

# Clean if the directory exists
rm -rf $2

# Make the directory and cd into it
mkdir $2
echo "Created directory $2"
echo
cd $2

# Make the basic HTML file
# CDN - <script src="https://cdn.jsdelivr.net/npm/p5@1.3.0/lib/p5.js"></script>
echo "<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>P5 JS</title>
  </head>
  <body>
  	<script defer src="https://cdn.jsdelivr.net/npm/p5@1.3.0/lib/p5.js"></script>
    <script defer src="sketch.js"></script>
  </body>
</html>
" > index.html
echo "Created index.html!"

# Make the basic JavaScript file
echo "function setup() {
	createCanvas(820, 640);
}

function draw() {
	background(51);
}
" > sketch.js

echo "Created sketch.js!"