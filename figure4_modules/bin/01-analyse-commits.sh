#!/bin/bash

#set -e

mkdir -p ../../data

if [ ! -d "modules/.git" ]; then
  git clone https://github.com/nf-core/modules.git modules
else
  echo "Repository already cloned in ./modules"
fi

cd modules
# different modifications 
git checkout ca199cf #commit from 2024-02-23 15:13:40
for i in {1..500}
do
  name=${i}
  commit_date=`git show -s --format=%ci`
  
  nf-test test --csv ../../data/${name}.time.txt --changed-since HEAD^ --dry-run 
  if test -f "../../data/${name}.time.txt"; then
    csvtk mutate2 -n version  -e "'${name}'" ../../data/${name}.time.txt | csvtk mutate2 -n setup  -e "'firewall'" | csvtk mutate2 -n version_date  -e "'${commit_date}'" > ../../data/${name}.time.name.txt
  fi

  nf-test test --csv ../../data/${name}_all.time.txt --dry-run 
  csvtk mutate2 -n version  -e "'${name}'" ../../data/${name}_all.time.txt | csvtk mutate2 -n setup  -e "'all'" | csvtk mutate2 -n version_date  -e "'${commit_date}'" > ../../data/${name}_all.time.name.txt

  rm ../../data/${name}.time.txt
  rm ../../data/${name}_all.time.txt

  git checkout HEAD^
done

#merge all
csvtk concat ../../data/*.time.name.txt > ../../data/tests.times.modifications.txt
rm ../../data/*.time.name.txt

git checkout master

cd ..
