#!/bin/bash

. ./cmd.sh 
[ -f path.sh ] && . ./path.sh
main_dir=/home/raghav/kaldi-master/egs/raghav
data_dir=$main_dir/data
dict_dir=$main_dir/data/local/dict
tmp_dir=$main_dir/data/tmp
lang_dir=$main_dir/data/lang
textpath=/home/raghav/kaldi-master/egs/raghav
mkdir -p $lang_dir
mkdir -p $tmp_dir

#utils/prepare_lang.sh  $dict_dir '!SIL' /home/raghav/kaldi-master/egs/raghav/data/local/lang /home/raghav/kaldi-master/egs/raghav/data/lang || exit 1;

cat $lang_dir/words.txt |awk '{print $1}' | grep -v -e "<eps>" -e "\!SIL" -e "<\/s>" -e "<s>" > $tmp_dir/words1.txt

#python local/generate_bigram.py $tmp_dir/words.txt > $tmp_dir/wp_gram.txt
#local/make_rm_lm.pl $tmp_dir/wp_gram.txt > $tmp_dir/G.txt

python gen_wnet.py /home/raghav/kaldi-master/egs/raghav/sorted.txt '<eps>' /home/raghav/kaldi-master/egs/raghav/data/tmp/G1.txt

fstcompile --isymbols=/home/raghav/kaldi-master/egs/raghav/data/lang/words.txt --osymbols=/home/raghav/kaldi-master/egs/raghav/data/lang/words.txt --keep_isymbols=false --keep_osymbols=false /home/raghav/kaldi-master/egs/raghav/data/tmp/G1.txt > /home/raghav/kaldi-master/egs/raghav/data/lang/G.fst

#fstcompile --isymbols=$lang_dir/words.txt --osymbols=$lang_dir/words.txt \
 #  --keep_isymbols=false --keep_osymbols=false $tmp_dir/G.txt > $lang_dir/G.fst

utils/validate_lang.pl $lang_dir # Note; this actually does report errors,
