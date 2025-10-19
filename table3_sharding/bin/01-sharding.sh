#!/bin/bash

mkdir -p ../../data

if [ ! -d "modules/.git" ]; then
  git clone https://github.com/genepi/nf-gwas.git nf-gwas
else
  echo "Repository already cloned in ./nf-gwas"
fi

cd nf-gwas

git checkout v1.0.5

nf-test test --csv ../../data/baseline.times.txt

chunks=5
for i in $(seq 1 $chunks)
do
    echo "Run shard ${i}..."
    nf-test test --csv ../../data/shard.${i}.none.txt --shard ${i}/${chunks} --shard-strategy "none"
    csvtk mutate2 -n shard  -e "${i}" ../../data/shard.${i}.none.txt | csvtk mutate2 -n strategy  -e "'none'" > ../../data/shard.${i}.none.final.txt

    nf-test test --csv ../../data/shard.${i}.rr.txt --shard ${i}/${chunks} --shard-strategy "round-robin"
    csvtk mutate2 -n shard  -e "${i}" ../../data/shard.${i}.rr.txt | csvtk mutate2 -n strategy  -e "'round-robin'" > ../../data/shard.${i}.rr.final.txt


done

csvtk concat ../../data/*.final.txt > ../../data/shard.times.txt
