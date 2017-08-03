#!/bin/bash

path=/home/raghav/kaldi-master/egs/raghav

. /home/raghav/kaldi-master/egs/raghav/path.sh




train_cmd=$path/utils/run.pl
decode_cmd=$path/utils/run.pl 

wav_dir=$1 # 1st input giving frm outside
wav_name=$2  # 2nd input giving frm outside
mnae=$3
cd $wav_dir
rm -rf filedir cmvn.scp filename wav.scp text utt2spk spk2utt dmp log
echo $wav_name > filename
echo $wav_dir/$wav_name > filedir

paste filename filedir > wav.scp
paste filename filename > utt2spk
cp utt2spk spk2utt
paste filename filename > text
cd -

#model_path=/home/raj/ccc/workspace2/speech1/exp/tri2_450_1800
#model_path=/home/raj/ccc/iitm_workshop/speech1/exp/tri2_450_1800
#model_path=/home/raj/ccc/workspace2/speech3/exp/tri1_450_1800
#model_path=/home/raj/ccc/workspace2/speech3/exp/tri2_450_1800

#model_path=/home/raj/ccc/workspace2/server-speech2/tri1_1300_41600
#model_path=/home/raj/ccc/workspace2/server-speech2/tri2_1200_38400
lss=`date +%s%N`
cd $path
steps/make_mfcc.sh --cmd "$train_cmd" --nj 1 $wav_dir $wav_dir/log $wav_dir/dmp > $wav_dir/log.txt
steps/compute_cmvn_stats.sh $wav_dir $wav_dir/log $wav_dir/dmp > $wav_dir/log.txt


if [ "$3" = "yes_no" ]
then
    model_path=/home/raghav/kaldi-master/egs/raghav/yes_no/tri2_1600_25600

gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt 

elif [ "$3" = "up_district" ]
then
  model_path=/home/raghav/kaldi-master/egs/raghav/up_dist/tri2_1600_25600

gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt 

elif [ "$3" = "mp_district" ]
then
  model_path=/home/raghav/kaldi-master/egs/raghav/mp_dist/tri2_1600_25600

gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt 

elif [ "$3" = "state" ]
then
  model_path=/home/raghav/kaldi-master/egs/raghav/state/tri2_1600_25600

gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt 



else
   model_path=/home/raghav/kaldi-master/egs/raghav/crop/tri2_1600_25600

gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt

fi






#Decode Using tri1 acaustic model
#gmm-latgen-faster --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | add-deltas  ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt 



#Decode Using tri2 acaustic model
#gmm-latgen-faster --print-args=false --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=$model_path/graph/words.txt $model_path/final.mdl $model_path/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:$wav_dir/utt2spk scp:$wav_dir/cmvn.scp scp:$wav_dir/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats $model_path/final.mat ark:- ark:- |" ark,t:$model_path/$lss.txt >$wav_dir/log.txt 2> $wav_dir/out.txt
#`cat $wav_dir/out.txt |grep $wav_name |cut -d ' ' -f2- |head -1`
 
lattice-to-ctm-conf --acoustic-scale=0.083333 ark:$model_path/$lss.txt $wav_dir/${wav_name}_conf-score.txt

cut -d' ' -f6 $wav_dir/${wav_name}_conf-score.txt 1> $wav_dir/${wav_name}.score

cat $wav_dir/out.txt |grep $wav_name |cut -d ' ' -f2- |head -1 > $wav_dir/recog4.txt
ot=`cat $wav_dir/recog4.txt`
ot2=`cat $wav_dir/${wav_name}.score`
echo $ot
echo $ot2
rm $model_path/$lss.txt
