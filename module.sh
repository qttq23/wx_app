# update: tested basic
# remove: tested basic
# add: tested basic, with space in path (ok), path as '.' (will fail)

# exit when any single command failed
set -e

# parse arguments

command=""
directory=""
url=""
help="supported commands: update, remove, add\n sh module (update by default)\n sh module update \n sh module remove path_to_module\n sh module add url_to_repo path_to_module\n"


if [[ -z $1 ]]
then
 command=update

elif [[ $1 == "update" ]]
then
 command=update

elif [[ $1 == "remove" ]]
then
 command=remove
 
 if [[ -n $2 ]] && [[ -d $2 ]]
 then 
  directory="$2"

 else
  echo "invalid second argument. maybe empty or wrong path. exit 1"
  exit 1
 fi

elif [[ $1 == "add" ]]
then
 command=add

 if [[ -z $2 ]]
 then
  echo "missing argument 2. must be an url to repo. exit 1"
  exit 1

 else
  url="$2"
 fi

 if [[ -n $3 ]]
 then
  directory="$3"
 fi

else
 echo "invalid first argument. exit 1"
 printf "$help"
 exit 1
fi


# process

if [[ $command == "update" ]]
then
 echo "processing update"

 git submodule sync --recursive
 echo "synced recursively."

 git submodule update --init --recursive
 echo "successfully updated all submodules recursively."

elif [[ $command == "remove" ]]
then
 echo "processing remove $directory"

 git submodule deinit --force "$directory"
 echo "deleted working directory & unregistered submodule"

 git rm --force "$directory"
 echo "deleted working directory & removed entry in .gitmodules file"

 rm -rf ".git/modules/$directory"
 echo "deleted internal directory"

 echo "successfully removed $directory"

elif [[ $command == "add" ]]
then
 echo "processing add $url to $directory" 

 if [[ -n $directory ]]
 then
  git submodule add "$url" "$directory"
 else
  git submodule add "$url"
 fi

 echo "successfully added"

else
 echo "something wrong. exit 1"
 exit 1
fi