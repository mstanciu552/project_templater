#!/bin/bash


script_list=$(ls ./scripts/)
working_directory=$(pwd)


if [ ! -d $HOME/bin ]
then
    cd $HOME
    mkdir bin
    # Add ./bin to path
    # bashrc=$(cat $HOME/.bashrc)
    # env="export PATH=\$HOME/bin:\$PATH"
    # echo "$env\n$bashrc" > $HOME/.bashrc
fi

cd $HOME/bin
rm -rf $script_list
rm -rf temp.sh
rm -rf temp
echo "Cleaning binary directory"

cd $working_directory
for word in $script_list
do
    echo "Created link to $word"
    ln -s $working_directory/scripts/$word $HOME/bin/$word
done

echo "Created link to temp.sh"
ln -s $working_directory/build/temp.sh $HOME/bin/temp