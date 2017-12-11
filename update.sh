#!/bin/sh

for FILE in .vim .config/nvim .vimrc
do
    diff $FILE ~/$FILE

    echo \\\n

    while true
    do
        read -p "Do you want to update ~/$FILE/ [y/n]: " yn
        case $yn in
            [Yy]* )
                echo "Updating..."
                cp -r $FILE ~/
                break;;
            [Nn]* )
                echo "Not updated."
                break;;
            * ) echo "Answer [yn] please";;
        esac
    done
done
