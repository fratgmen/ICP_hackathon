import List "mo:base/List";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Text "mo:base/Text";




actor  {

    // Fatura veri yapısını tanımlıyoruz. Bu veri yapısının her özelliğini belirliyoruz.
    public type Fatura = {
        id: Nat;                     // Fatura ID'si
        musteriAdi: Text;            // Müşteri adı
        toplamTutar: Float;          // Fatura toplam tutarı
        tarih: Text;                 // Fatura tarihi
    };

    // Faturaları saklayacak bir liste (List) değişkeni.
    var faturaListesi: List.List<Fatura> = List.empty<Fatura>();

    // Stable değişken tanımlaması, kalıcı veri için (genellikle blockchain üzerinde)
    stable var blockchainFaturalar: List.List<Fatura> = List.empty<Fatura>();

    // Yeni bir fatura oluşturmak için fonksiyon.
    public func yeniFaturaOlustur(id: Nat, musteriAdi: Text, toplamTutar: Float, tarih: Text): Fatura() {
      
        return {
            id = id;
            musteriAdi = musteriAdi;
            toplamTutar = toplamTutar;
            tarih = tarih;
        };
    };

    // Faturayı listeye ekleyen fonksiyon.
    public func faturaEkle(fatura: Fatura): Text {
        faturaListesi := List.cons(fatura, faturaListesi); // Faturayı liste başına ekler.
        return "Fatura başarıyla eklendi!";
    };

    // Faturaları blockchain'e kaydeden fonksiyon.
    public func faturalariKaydet(): Text {
        blockchainFaturalar := faturaListesi; // Listede bulunan tüm faturaları blockchain'e kaydeder.
        return "Faturalar blockchain'e kaydedildi!";
    };

    // Blockchain üzerinde saklanan faturaları listeleyen fonksiyon.
    public func faturalariListele(): List<Fatura> {
        return blockchainFaturalar; // Blockchain'deki faturaları döndürür.
    };
};
