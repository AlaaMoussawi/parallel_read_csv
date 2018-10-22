#!/bin/sh

# Two arguments for this function are the file name, and number of files to be split into.
# Should be equivalent to the number of processors you intend to use.

file_name=$1
num_processors=$2

echo "File to be split: $file_name."
echo "Number of files: $num_processors"

num_lines="$(wc $file_name | awk '{print $1;}')"

num_lines_per_file=$(expr $num_lines / $num_processors)


tail -n +2 $file_name | split -l $num_lines_per_file $file_name 311_split/311_split_ --additional-suffix='.csv'
for file in 311_split/311_split_*
do
    head -n 1 $file_name > tmp_file
    cat $file >> tmp_file
    mv -f tmp_file $file
done
