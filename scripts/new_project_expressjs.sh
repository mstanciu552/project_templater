#!/bin/bash

# Change directory into the specified directory
cd $1

# Clean if the directory exists
if [ -d $2 ]; then 
  read -p "File already exists. Do you want to delete and replace it?[Y/n]" permission
  echo $permission
  if [[ $permission == 'Y' || $permission == 'y' || -z $permission ]]; then 
    rm -rf $2
  else
    echo "Stopping templater..."
    exit
  fi
fi


# Make the directory and cd into it
mkdir $2
echo "Created directory $2"
echo
cd $2

# Initialize the node project
npm init -y

echo "Starting dependency installation..."
echo
# Add scripts and modular type to package.json
echo "{
  \"name\": \"express-testing\",
  \"version\": \"1.0.0\",
  \"description\": \"\",
  \"main\": \"index.js\",
  \"type\": \"module\",
  \"scripts\": {
    \"start\": \"node index.js\",
    \"dev\": \"nodemon index.js\"
  },
  \"keywords\": [],
  \"author\": \"\",
  \"license\": \"ISC\"
}
" > package.json
echo
echo "Modified package.json"
echo

# Install Express dependencies
npm install express
npm install -D nodemon dotenv
echo
echo "Installed dependencies!"
echo

# Create basic index.js
echo "import express from 'express';
import dotenv from 'dotenv';

const app = express();

dotenv.config();

app.get('/', (req, res) => {
	res.send('Hello World!');
});

app.listen(process.env.PORT || 3030, () => console.log(\`Server listening on port \${process.env.PORT || 3030}\`));

" > index.js
echo "Added basic index.js!"
echo

# Make folder structure
touch .env
echo "Added .env file"
echo
mkdir routes
echo "Added routes folder"
echo
mkdir models
echo "Added models folder"
echo
mkdir config
echo "Added config folder"
