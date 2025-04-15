import Testing
@testable import GeoRisques

struct GeoRisquesTests {
    @Test("on view load, moves map to current location and reload risks")
    func viewDidLoad() async throws {
        let store = GeoRisquesStore(
            locationClient: FixedLocationClient(location: .france),
            risquesClient: FixedRisquesClient(risques: Risque.diseases),
        )
        store.onRisquesDidLoad()
        
        await megaYield()
        #expect(store.risquesState.location == .france)
        #expect(store.risquesState.risques == Risque.diseases)
    }
    
    @Test("on location button tap, moves map to current location and reload risks")
    func locationButtonTap() async throws {
        let store = GeoRisquesStore(
            locationClient: FixedLocationClient(location: .grenoble),
            risquesClient: FixedRisquesClient(risques: Risque.all),
        )
        store.onLocationButtonTapped()
        
        await megaYield()
        #expect(store.risquesState.location == .grenoble)
        #expect(store.risquesState.risques == Risque.all)
    }
    
    @Test("on risque button tap, shows risk detail")
    func risqueButtonTap() async throws {
        let store = GeoRisquesStore(
            locationClient: FixedLocationClient(location: .grenoble),
            risquesClient: FixedRisquesClient(risques: Risque.all),
        )
        store.onRisqueButtonTapped(.dengue)
        #expect(store.risquesState.selectedRisque == GeoRisquesStore.RisqueDetailState(risque: .dengue))
    }
    
    private func megaYield() async {
        for _ in 0..<100 {
            await Task.yield()
        }
    }
}
