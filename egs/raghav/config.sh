case "$USER" in
"ac1nmx")
  # CHiME Challenge wav root (after unzipping)...
  export WAV_ROOT="/home/raghav/just_for_acc/wav" 

  # Used by the recogniser for storing data/ exp/ mfcc/ etc
  export REC_ROOT="/home/raghav/just_for_acc/rec" 
  ;;
*)
  echo "Please define WAV_ROOT and REC_ROOT for user $USER"
  ;;
esac

