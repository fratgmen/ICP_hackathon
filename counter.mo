actor {
  stable var counter : Nat = 0;
  public func decrease() : async Nat {
    if (counter != 0) {
      counter -= 1
    };
    return counter
  };

  public func increase() : async Nat {
    counter += 1;
    return counter
  };

  public func getCounter() : async Nat {
    return counter
  };
  public func setCounter() : async Nat {
    counter := 0;
    return counter
  };
  public func addValue(value : Nat) : async Nat {
    counter += value;
    return counter;

  };

}
