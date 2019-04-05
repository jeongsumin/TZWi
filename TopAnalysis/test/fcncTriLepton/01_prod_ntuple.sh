#!/bin/bash

if [ $# != 4 ]; then
    echo $#
    echo "Usage: $0 MuElEl MC2016.WW.txt 10 5 ## process WW sample assuming muee channel, split by 10 files and run 5th section"
    echo "Usage: $0 ElElEl MC2017.TT_powheg.txt 1 0 ## process TTbar sample assuming eee channel, one file per each section and run 0th one."
    echo "Usage: $0 MuMuMu Run2016B.DoubleMuon.txt 1 0"
    exit 1
fi

eval `scram runtime -sh`

CHANNEL=$1
FILELIST=$2
MAXFILES=$3
JOBNUMBER=$4

[ $CHANNEL == 'MuElEl' ] && CHANNEL=ElElMu
[ $CHANNEL == 'ElMuMu' ] && CHANNEL=MuMuEl

DATATYPE0=`basename $FILELIST | sed -e 's;.txt;;g' | cut -d. -f1`
DATASET=`basename $FILELIST | sed -e 's;.txt;;g' | cut -d. -f2`
DATATYPE=$DATATYPE0
if [ ${DATATYPE::3} == "Run" ]; then
  #DATATYPE=${DATATYPE::7} ## This gives Run2018A -> Run2018
  [ $DATATYPE == "Run2016B" -o $DATATYPE == "Run2016C" -o $DATATYPE == "Run2016D" -o $DATATYPE == "Run2016E" ] && DATATYPE=Run2016BE
  [ $DATATYPE == "Run2016F" -o $DATATYPE == "Run2016G" ] && DATATYPE=Run2016FG
fi

FILENAMES=$(cat $FILELIST | xargs -n$MAXFILES | sed -n "$(($JOBNUMBER+1)) p" | sed 's;/xrootd/;root://cms-xrdr.sdfarm.kr//xrd/;g')

ARGS=""
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.fcncTriLeptonHLT flags_${DATATYPE}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.fcncTriLeptonHLT "`echo hlt_{E,M,MM,EE,ME}_${DATATYPE} | tr ' ' ','`
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.fcncTriLepton fcnc_${CHANNEL}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.fcncTriLeptonCutFlow cutFlow_${CHANNEL}"
ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.CopyBranch copyBranch"

#OUTPATH=ntuple/reco
OUTPATH=ntuple/reco/$DATATYPE0/$DATASET/$CHANNEL
CMD="nano_postproc.py --friend"
[ ! -d $OUTPATH ] && mkdir -p $OUTPATH
if [ ${DATATYPE::2} == "MC" ]; then
    ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.common.lepSFProducer lepSF"
    ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.common.puWeightProducer puWeight"

    ARGS="$ARGS -I PhysicsTools.NanoAODTools.postprocessing.modules.btv.btagSFProducer btagSF2016"
    ARGS="$ARGS -I TZWi.TopAnalysis.postprocessing.btagWeightProducer btagWeight"
fi
echo $CMD $ARGS $OUTPATH $FILENAMES
$CMD $ARGS $OUTPATH $FILENAMES
[ $? -eq 0 ] || echo $CMD $ARGS $OUTPATH $FILENAMES >> failed.txt

