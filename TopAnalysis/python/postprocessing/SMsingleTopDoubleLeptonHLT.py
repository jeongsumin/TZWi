import ROOT
ROOT.PyConfig.IgnoreCommandLineOptions = True

from PhysicsTool.NanoAODTools.postprocessing.framework.datamodel import Collection
from PhysicsTool.NanoAODTools.postprocessing.framework.eventloop import Module

from TZWi.TopAnalysis.postprocessing.CombineHLT import CombineHLT

hlt_E_MC2016 = lambda : CombineHLT(outName="HLT_E", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="RunIISummer16.SingleElectron")
hlt_M_MC2016 = lambda : CombineHLT(outName="HLT_M", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="RunIISummer16.SingleMuon")
hlt_EE_MC2016 = lambda : CombineHLT(outName="HLT_EE", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="RunIISummer16.DoubleEG")
hlt_MM_MC2016 = lambda : CombineHLT(outName="HLT_MM", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="RunIISummer16.DoubleMuon")
hlt_ME_MC2016 = lambda : CombineHLT(outName="HLT_ME", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="RunIISummer16.MuonEG")

hlt_E_Run2016BG = lambda : CombineHLT(outName="HLT_E", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016BG.SingleElectron")
hlt_M_Run2016BG = lambda : CombineHLT(outName="HLT_M", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016BG.SingleMuon")
hlt_E_Run2016BG = lambda : CombineHLT(outName="HLT_E", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016BG.SingleElectron")
hlt_M_Run2016BG = lambda : CombineHLT(outName="HLT_M", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016BG.SingleMuon")
hlt_ME_Run2016BG = lambda : CombineHLT(outName="HLT_ME", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016BG.MuonEG")

hlt_E_Run2016H = lambda : CombineHLT(outName="HLT_E", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016H.SingleElectron")
hlt_M_Run2016H = lambda : CombineHLT(outName="HLT_M", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016H.SingleMuon")
hlt_E_Run2016H = lambda : CombineHLT(outName="HLT_E", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016H.SingleElectron")
hlt_M_Run2016H = lambda : CombineHLT(outName="HLT_M", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016H.SingleMuon")
hlt_ME_Run2016H = lambda : CombineHLT(outName="HLT_ME", fileName="SMsingleTopDoubleLepton/2016.yaml", hltSet="Run2016H.MuonEG")

flags_MC2016 = lambda : CombineHLT(outName="Flag", fileName=flags/2016.yaml, hltSet="RunIISummer16")
flags_Run2016 = lambda : CombineHLT(outName="Flag", fileName=flags/2016.yaml, hltSet="Run2016")
