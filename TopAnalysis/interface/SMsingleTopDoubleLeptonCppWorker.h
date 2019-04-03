#ifndef PhysicsTools_ChickenChicken_SMsingleTopDoubleLeptonCppWorker_H
#define PhysicsTools_ChickenChicken_SMsingleTopDoubleLeptonCppWorker_H

#include <memory>
#include <string>
#include <vector>
#include <TTree.h>
#include <TTreeReaderValue.h>
#include <TTreeReaderArray.h>
#include <TLorentzVector.h>

class SMsingleTopDoubleLeptonCppWorker {
//190403 KST 11:38 : just copy frome FCNCTriLepton~.h, changed class name
public:
  enum class MODE {Auto=0, ElEl=1111, MuMu=1313} mode_ = MODE::Auto;

  typedef TTreeReaderArray<float>* TRAF;
  typedef TTreeReaderArray<int>* TRAI;
  typedef TTreeReaderArray<bool>* TRAB;

  SMsingleTopDoubleLeptonCppWorker(const std::string modeName);
  ~SMsingleTopDoubleLeptonCppWorker() = default;

  void setMuons(TRAF pt, TRAF eta, TRAF phi, TRAF mass, TRAI charge,
                TRAF relIso, TRAB isTight, TRAB isGlobal, TRAB isPFcand, TRAB isTracker);
  void setElectrons(TRAF pt, TRAF eta, TRAF phi, TRAF mass, TRAI charge,
                    TRAF relIso, TRAI id, TRAF dEtaSC, TRAF eCorr);
  void setJets(TRAF pt, TRAF eta, TRAF phi, TRAF mass,
               TRAI id, TRAF CSVv2);
  void setMET(TTreeReaderValue<float>* pt, TTreeReaderValue<float>* phi);

  void resetValues();
  bool analyze();

  float get_Lepton1_pt()   const { return out_Lepton1_p4[0]; }
  float get_Lepton1_eta()  const { return out_Lepton1_p4[1]; }
  float get_Lepton1_phi()  const { return out_Lepton1_p4[2]; }
  float get_Lepton1_mass() const { return out_Lepton1_p4[3]; }
  int get_Lepton1_pdgId() const { return out_Lepton1_pdgId; }

  float get_Lepton2_pt()   const { return out_Lepton2_p4[0]; }
  float get_Lepton2_eta()  const { return out_Lepton2_p4[1]; }
  float get_Lepton2_phi()  const { return out_Lepton2_p4[2]; }
  float get_Lepton2_mass() const { return out_Lepton2_p4[3]; }
  int get_Lepton2_pdgId() const { return out_Lepton2_pdgId; }

  float get_Z_pt()   const { return out_Z_p4[0]; }
  float get_Z_eta()  const { return out_Z_p4[1]; }
  float get_Z_phi()  const { return out_Z_p4[2]; }
  float get_Z_mass() const { return out_Z_p4[3]; }
  int get_Z_charge() const { return out_Z_charge; }

  float get_MET_pt()  const { return out_MET_pt; }
  float get_MET_phi() const { return out_MET_phi; }

  float get_W_mass() const { return out_W_mass; }

  unsigned get_nVetoLepton() const { return out_nVetoLepton; }
  unsigned get_nGoodJet()   const { return out_nGoodJet; }
  std::vector<float> get_GoodJet_pt()   const { return out_GoodJet_p4[0]; }
  std::vector<float> get_GoodJet_eta()  const { return out_GoodJet_p4[1]; }
  std::vector<float> get_GoodJet_phi()  const { return out_GoodJet_p4[2]; }
  std::vector<float> get_GoodJet_mass() const { return out_GoodJet_p4[3]; }
  std::vector<float> get_GoodJet_CSVv2() const { return out_GoodJet_CSVv2; }
  std::vector<unsigned short> get_GoodJet_index() const { return out_GoodJet_index; }
  unsigned get_nBjet()   const { return out_nBjet; }

private:
  const double minLeadMuonPt_ = 26, minSubMuonPt_ = 20, maxMuonEta_ = 2.4; //Signal & Loose muon reco. cuts are same
  const double minLeadElectronPt_ = 35, minSubElectronPt_ = 15, maxElectronEta_ = 2.5; //Signal & veto reco. cuts are same
  const double minJetPt_ = 30, maxJetEta_ = 4.7;
  const double maxBjetEta_ = 2.4;
  const double minBjetBDiscr_ = 0.8484; // FIXME: give updated number (here, use medium Working Point)
  const double maxMuonRelIso_ = 0.15;
  const double maxLooseMuonRelIso_ = 0.25;

  bool isGoodMuon(const unsigned i) const;
  bool isLooseMuon(const unsigned i) const;
  bool isGoodElectron(const unsigned i) const;
  bool isVetoElectron(const unsigned i) const;
  bool isGoodJet(const unsigned i) const;

private:
  TLorentzVector buildP4(const TRAF p4Arr[], unsigned i) const;
  double computeMT(const TLorentzVector& lepP4, const double met_pt, const double met_phi) const;

private:
  TTreeReaderValue<float> *in_MET_pt = nullptr, *in_MET_phi = nullptr;
  TRAF in_Muons_p4[4];
  TRAI in_Muons_charge = nullptr;
  TRAF in_Muons_relIso = nullptr; //nanoAOD object : Muon_pfRelIso03_all
  TRAB in_Muons_isTight = nullptr;
  TRAB in_Muons_isPFcand = nullptr;
  TRAB in_Muons_isGlobal = nullptr;
  TRAB in_Muons_isTracker = nullptr;//Loose muons(isGlobal or isTracker)

  TRAF in_Electrons_p4[4];
  TRAI in_Electrons_charge = nullptr;
  TRAF in_Electrons_relIso = nullptr; //nanoAOD object : Electron_pfRelIso03_all
  TRAI in_Electrons_id = nullptr;
  TRAF in_Electrons_dEtaSC = nullptr;
  TRAF in_Electrons_eCorr = nullptr;

  TRAF in_Jet_p4[4];
  TRAI in_Jet_id = nullptr;
  TRAF in_Jet_CSVv2 = nullptr;

private:
  bool _doCppOutput = false;

  float out_Lepton1_p4[4], out_Lepton2_p4[4];
  int out_Lepton1_pdgId, out_Lepton2_pdgId;
  float out_Z_p4[4];
  
  int out_Z_charge;

  float out_MET_pt, out_MET_phi;

  float out_W_mass;

  unsigned short out_nVetoLepton;
  unsigned short out_nGoodJet, out_nBjet;
  std::vector<float> out_GoodJet_p4[4];
  std::vector<float> out_GoodJet_CSVv2;
  std::vector<unsigned short> out_GoodJet_index;

};

#endif
