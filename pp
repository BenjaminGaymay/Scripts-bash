#!/bin/bash
echo "Cleaning the repository.."
make fclean >/dev/null 2>&1
mrc
echo "Done"
echo -e "\nChecking your connection.."
connect
echo -e "\nGetting previous push.."
git pull
if [ "$1" = "" ]; then
    echo -e "\nPush script started whitout argument."
    echo "If you want push all your files please use --all argument."
    echo "Else, just write names of your files or directories."
else
    echo ""
    rep=""
    while [ "$rep" = "" ]; do
	read -p "Choose commit name : " rep
    done
    echo -e "\nCreating your commit.."
    files=$@
    while [ $# != 0 ]; do
	git add "$1" 2>/dev/null
	if [ $? -ne 0 ]; then
	    echo -e "\nCommit fail, \"$1\" file doesn't exist."
	    exit 1
	fi
	shift
    done
    git commit -m "$rep" $files
    echo "Done"
    echo -e "\nPushing your commit.."
    git push origin master
    echo -e "\nGetting previous push.."
    git pull
    mrc
fi
