#!/bin/sh

ls ../Data/split_coinventors/*.csv | xargs -P 8 -n 1 Rscript 02_eval_coinv_relations.R

cat ../Data/coinventor_info/*.csv > ../Data/coinventor_info.csv