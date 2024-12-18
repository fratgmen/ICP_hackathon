import Map "mo:base/HashMap";
import Text "mo:base/Text";
import Option "mo:base/Option";
import List "mo:base/List";

actor {
    public type Fatura = {
        id: Nat;
        kullanici_adi: Text;
        toplamTutar: Nat;
        tarih: Text;
    };

    public type faturalar_listesi = List.List<Fatura>;
    let FaturaData = Map.HashMap<Text, List.List<Fatura>>(0, Text.equal, Text.hash);

    public func addFatura(user: Text, newFatura: Fatura): async Fatura {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let updatedEntries = List.push(newFatura, userEntries);
        FaturaData.put(user, updatedEntries);
        return newFatura;
    };

    public func getEntries(user: Text): async ?List.List<Fatura> {
        return FaturaData.get(user);
    };

    public func getFaturaId(user: Text, targetId: Nat): async ?Fatura {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let result = List.find(userEntries, func(fatura: Fatura): Bool {
            fatura.id == targetId
        });
        switch (result) {
            case (?fatura) return ?fatura;
            case (_) return null;
        }
    };

    public func updateFatura(user: Text, targetId: Nat, updatedFatura: Fatura): async Bool {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let updatedEntries = List.map(userEntries, func(fatura: Fatura): Fatura {
            if (fatura.id == targetId) {
                return updatedFatura;
            } else {
                return fatura;
            }
        });
        FaturaData.put(user, updatedEntries);
        return true;
    };

    public func deleteFatura(user: Text, targetId: Nat): async Bool {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let filteredEntries = List.filter(userEntries, func(fatura: Fatura): Bool {
            fatura.id != targetId
        });
        FaturaData.put(user, filteredEntries);
        return true;
    };
};
