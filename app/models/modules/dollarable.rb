module Dollarable
    def change_to_dollars
        self.unit_price = (self.unit_price.to_f / 100)
    end
end
