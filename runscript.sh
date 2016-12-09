#!/bin/bash


export LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64:$LD_LIBRARY_PATH

export PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/bin/:$PATH

declare chm="chm-compiled-r2013a-2.1.367"

declare version="@@VERSION@@"

if [ $# -eq 0 ] ; then
  echo "$0 <train|test|verify|licenses> <images> <labels> (options)"
  echo ""
  echo "This singularity image runs CHM train or test ($chm)"
  echo ""
  echo "NOTE: This image bundles Matlab Compiled Runtime 2013a."
  echo "      Using this image implies consent of its license found by"
  echo "      running this command again with license as first argument."
  echo "      Other licenses can be found by visiting: "
  echo "      https://github.com/slash-segmentation/chm_singularity"
  echo ""
  echo "  The mode is determined by the first argument <train|test|verify>"
  echo "  If first argument is:"
  echo ""
  echo "    train -- Runs CHM Train"
  echo "    test -- Runs CHM Test"
  echo "    verify -- Runs a quick test to verify CHM Train & Test work"
  echo "    version -- Outputs version of CHM singularity image"
  echo ""
  echo "  To see more help run one of the following commands"
  echo "    $0 train"
  echo "    $0 test"
  echo "    $0 license"
  echo "    $0 verify"
  echo "    $0 version"
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

if [ "$mode" == "license" ] ; then
  echo "MATLAB LICENSE:"
  cat /usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/license.txt
  echo "Visit https://github.com/slash-segmentation/chm_singularity"
  echo "for licenses for CHM and the code to generate this image"
  echo ""
  exit 0
fi

if [ "$mode" == "version" ] ; then
  echo "$version"
  exit 0
fi

if [ "$mode" == "train" ] ; then
  exec /$chm/CHM_train.sh "$@" $matlab
  exit $?
fi


if [ "$mode" == "test" ] ; then
  exec /$chm/CHM_test.sh "$@" $matlab
  exit $? 
fi
 
if [ "$mode" == "verify" ] ; then
  if [ $# -ne 1 ] ; then
    echo "$0 verify <tmp directory>"
    echo ""
    echo "Runs CHM train and test on some internal test data"
    echo "to verify image is configured correctly."
    echo ""
    echo "To run please pass path to tmp directory with write access"
    echo "code will exit 0 upon success otherwise failure"
    exit 2
  fi
  declare my_tmp=$1
  echo "Removing $my_tmp/testimage.png before running test"
  rm -f "$my_tmp/testimage.png"
  /$chm/CHM_train.sh /chm_singularity_test_data/images /chm_singularity_test_data/labels -S 2 -L 1 $matlab -m $my_tmp/model
  if [ $? != 0 ] ; then
    echo "Error chm train failed to run /$chm/CHM_train.sh /chm_singularity_test_data/images /chm_singularity_test_data/labels -S 2 -L 1 $matlab -m $my_tmp/model"
    exit 3
  fi
  echo "Training completed. Running CHM test..."
  /$chm/CHM_test.sh /chm_singularity_test_data $my_tmp -m $my_tmp/model -b 100x95 -t 1,1 -o 0x0 -h $matlab
  if [ $? != 0 ] ; then
    echo "Error chm test failed to run /$chm/CHM_test.sh $my_tmp /chm_singularity_test_data -m $my_tmp/model -b 100x95 -t 1,1 -o 0x0 -h $matlab"
    exit 4
  fi
  echo "Verifying probability map exists with size greater then 0"
  if [ -s "$my_tmp/testimage.png" ] ; then
    echo "Test passed..."
    exit 0
  fi
  echo "Test failed... No resulting probability map found"
  exit 5
fi

echo "Invalid mode: $mode. Run $0 with no arguments for help"
exit 6
