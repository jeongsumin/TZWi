import ROOT
ROOT.PyConfig.IgnoreCommandLineOptions = True

from PhysicsTools.NanoAODTools.postprocessing.framework.datamodel import Collection
from PhysicsTools.NanoAODTools.postprocessing.framework.eventloop import Module

class SMsingleTopDoubleLetponCutFlow(Module, object):
    def __init__(self, *args, **kwargs):
        self.mode = kwargs.get("mode")
        pass
    def beginJob(self):
        pass
    def endJob(self):
        pass
    def beginFile(self, inputFile, outputFile, inputTree, wrappedOutputTree):
        pass
    def analyze(self, event):
        cutStep = 0
        while True:
            if ~~: break #[Lepton Cuts] Exactly two tight leptons & no additional loose/veto muon/electron(leptons)
            cutStep += 1
            if self.~~ #[Z mass cuts] Z candidate leptons within Z_mass-20GeV <= m_ll <= Z_mass+20GeV
            cutStep += 1
            if ~~~ #[Jet Cuts] select 4 <= number of jets <= 6
            cutStep += 1
            if ~~~ #[b-tagged jet Cuts] Of which has 1 or 2 bjets
            cutStep += 1
            if ~~~ #[W mass Cuts] W candidate jet pair within W_mass-20GeV <= m_jj <= W_mass+20GeV
            cutStep += 1

            break
        self.out.fillBranch("CutStep", cutStep)

        return (cutStep > 0)

cutFlow_ElEl = lambda: SMsingleTopDoubleLeptonCutFlow(mode="ElEl")
cutFlow_MuMu = lambda: SMsingleTopDoubleLeptonCutFlow(mode="MuMu")
cutFlow_MuEl = lambda: SMsingleTopDoubleLeptonCutFlow(mode="MuEl")
