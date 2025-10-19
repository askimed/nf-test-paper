#!/bin/bash


mkdir -p ../../data

if [ ! -d "modules/.git" ]; then
  git clone https://github.com/nf-core/fetchngs.git fetchngs
else
  echo "Repository already cloned in ./fetchngs"
fi

cd fetchngs

git checkout 1.12.0

# all
nf-test test --coverage --graph dependencies.txt --profile docker --csv ../../data/tests.time.txt

# different modifications 
while IFS=, read -r name description files; do 
  echo "Run experiment ${name}..."
  nf-test test --profile docker --csv ../../data/${name}.time.txt --related-tests ${files}
  csvtk mutate2 -n experiment  -e "'${name}'" ../../data/${name}.time.txt > ../../data/${name}.time.name.txt
done < "../modifications.txt"

#merge all
csvtk concat ../../data/*.time.name.txt > ../../data/tests.times.modifications.txt