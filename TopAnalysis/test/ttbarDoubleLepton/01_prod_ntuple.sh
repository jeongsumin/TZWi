#!/bin/bash

if [ $# != 4 ]; then
    echo $#
    echo "Usage: $0 MuEl MC2016.WW.txt 10 5 ## process WW sample assuming emu channel, split by 10 files and run 5th section"
    echo "Usage: $0 ElEl MC2017.TT_powheg.txt 1 0 ## process TTbar sample assuming eechannel, one file per each section and run 0th one."
    echo "Usage: $0 MuMu Run2016B.DoubleMuon 1 0"
    exit 1
fi

eval `scram runtime -sh`

CHANNEL=$1
FILELIST=$2
MAXFILES=$3
JOBNUMBER=$4

[ $CHANNEL == 'ElMu' ] && CHANNEL='MuEl'

DATASET0=`basename $FILELIST | sed -e 's;.txt;;g'`
DATASET='/'`echo $DATASET0 | sed -e 's;\.;/;g'`
ERA=$(echo $DATASET0 | cut -d. -f2 | cut -d- -f1 | sed -e 's;NanoAOD;;g')

DATATYPE=$(basename $(dirname $FILELIST) | cut -d. -f1)
HLTMODULE=$(echo $DATATYPE | cut -d_ -f1)_${CHANNEL}

FILENAMES=$(cat $FILELIST | xargs -n$MAXFILES | sed -n "$(($JOBNUMBER+1)) p" | sed 's;^/xrootd/;root://cms-xrdr.private.lo:2094//xrd/;g')

ARGS=""
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.ttbarDoubleLeptonHLT flags_${DATATYPE}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.ttbarDoubleLeptonHLT hlt_${HLTMODULE}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.ttbarDoubleLepton ttbar_${CHANNEL}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.ttbarDoubleLeptonCutFlow cutFlow_${CHANNEL}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.CopyBranch copyBranch"

OUTPATH=ntuple/reco/$CHANNEL/$DATASET0
CMD="nano_postproc.py --friend"
[ ! -d $OUTPATH ] && mkdir -p $OUTPATH
if [ ${DATATYPE::2} == "MC" ]; then
    ARGS="-I PhysicsTools.NanoAODTools.postprocessing.modules.common.countHistogramsModule countHistogramsModule $ARGS"
    ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.CopyBranch copyMCBranch"

    #ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.common.lepSFProducer lepSF"
    ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.common.puWeightProducer puAutoWeight"

    ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.btv.btagSFProducer btagSF2017"
    ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.btagWeightProducer btagWeight"
fi
echo $CMD $ARGS $OUTPATH $FILENAMES
$CMD $ARGS $OUTPATH $FILENAMES
[ $? -eq 0 ] || echo $CMD $ARGS $OUTPATH $FILENAMES >> failed.txt

