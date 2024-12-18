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

    let FaturaData = Map.HashMap<Text, List.List<Fatura>>(0, Text.equal, Text.hash);

    // Yeni Fatura Ekleme
    public func addFatura(user: Text, newFatura: Fatura): async Fatura {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let updatedEntries = List.push<Fatura>(newFatura, userEntries);
        FaturaData.put(user, updatedEntries);
        return newFatura;
    };

    // Kullanıcıya Ait Tüm Faturaları Getirme
    public func getEntries(user: Text): async ?List.List<Fatura> {
        return FaturaData.get(user);
    };

    // Belirli Bir Faturayı ID ile Getirme
    public func getFaturaId(user: Text, targetId: Nat): async ?Fatura {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let result = List.find<Fatura>(userEntries, func(fatura: Fatura): Bool {
            fatura.id == targetId;
        });
        return result;
    };

    // Belirli Bir Faturayı Güncelleme
    public func updateFatura(user: Text, targetId: Nat, updatedFatura: Fatura): async Bool {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let updatedEntries = List.map<Fatura, Fatura>(userEntries, func(fatura: Fatura): Fatura {
            if (fatura.id == targetId) {
                return updatedFatura;
            } else {
                return fatura;
            };
        });
        FaturaData.put(user, updatedEntries);
        return true;
    };

    // Belirli Bir Faturayı Silme
    public func deleteFatura(user: Text, targetId: Nat): async Bool {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        let filteredEntries = List.filter<Fatura>(userEntries, func(fatura: Fatura): Bool {
            fatura.id != targetId;
        });
        FaturaData.put(user, filteredEntries);
        return true;
    };

    // Kullanıcıya Göre Toplam Fatura Tutarını Hesaplama
    public func totalAmountForUser(user: Text): async Nat {
        let userEntries = Option.get(FaturaData.get(user), List.nil<Fatura>());
        return List.foldLeft<Fatura, Nat>(userEntries, 0, func(total: Nat, fatura: Fatura): Nat {
            total + fatura.toplamTutar;
        });
    };
};

