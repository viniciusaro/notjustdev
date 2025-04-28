import Testing
@testable import GeoRisques

struct GeoRisquesTests {
    @Test("on view load, moves map to current location and reload risks")
    func viewDidLoad() async throws {
        let store = GeoRisksStore(
            locationClient: FixedLocationClient(location: .france),
            risksClient: FixedRisksClient(risks: Risk.naturalDisasters),
        )
        store.onRisksDidLoad()
        
        await megaYield()
        #expect(store.risksState.location == .france)
        #expect(store.risksState.risks == Risk.naturalDisasters)
    }
    
    @Test("on location button tap, moves map to current location and reload risks")
    func locationButtonTap() async throws {
        let store = GeoRisksStore(
            locationClient: FixedLocationClient(location: .grenoble),
            risksClient: FixedRisksClient(risks: Risk.all),
        )
        store.onLocationButtonTapped()
        
        await megaYield()
        #expect(store.risksState.location == .grenoble)
        #expect(store.risksState.risks == Risk.all)
    }
    
    @Test("on risque button tap, shows risk detail")
    func risqueButtonTap() async throws {
        let store = GeoRisksStore(
            locationClient: FixedLocationClient(location: .grenoble),
            risksClient: FixedRisksClient(risks: Risk.all),
        )
        store.onRisksButtonTapped(.affaissementMinier)
        #expect(store.risksState.selectedRisque == GeoRisksStore.RisksDetailState(risque: .affaissementMinier))
    }
    
    private func megaYield() async {
        for _ in 0..<100 {
            await Task.yield()
        }
    }

    @Test("on fetch advice, show AI answer")
    func fetchAdivice() async throws {
        let language = "en_EN"
        let advice = try await OpenAIClientLive().askAI(prompt: "Écriz moi quelquer chose en \(language)?")
        print(advice)
        #expect(!advice.isEmpty)
    }
    
    @Test("on load risk, show the total of risk")
    func totalOfRisks() async {
        let mockTotalOfRisks = Risk.all.count
        
        #expect(mockTotalOfRisks == 18)
    }
}
