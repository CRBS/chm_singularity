#!/bin/bash


export LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64:$LD_LIBRARY_PATH

export PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/bin/:$PATH

declare chm="chm-compiled-r2013a-2.1.367"

if [ $# -eq 0 ] ; then
  echo "$0 <train|test|verify> <images> <labels> (options)"
  echo ""
  echo "This singularity image runs CHM train or test ($chm)"
  echo ""
  echo "  The mode is determined by the first argument <train|test|verify>"
  echo "  If first argument is:"
  echo ""
  echo "    train -- Runs CHM Train"
  echo "    test -- Runs CHM Test"
  echo "    verify -- Runs a quick test to verify CHM Train & Test work"
  echo ""
  echo "  To see more help run one of the following commands"
  echo "    $0 train"
  echo "    $0 test"
  echo ""
  echo "  For information on how this image was created please visit:"
  echo "  https://github.com/slash-segmentation/chm_singularity"
  echo ""
  exit 1
fi

declare mode=$1

# remove the first argument
shift
matlab=" -M /usr/local/MATLAB/MATLAB_Compiler_Runtime/v81"
if [ "$mode" == "train" ] ; then
  exec /$chm/CHM_train.sh "$@" $matlab
else
  if [ "$mode" == "test" ] ; then
    exec /$chm/CHM_test.sh "$@" $matlab
  else
    if [ "$mode" == "verify" ] ; then
       echo "Run test"
    else
       echo "Invalid mode: $mode. Run $0 with no arguments for help"
       exit 2
    fi
  fi
fi
