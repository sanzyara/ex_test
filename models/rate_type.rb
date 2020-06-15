

module RateType
    BEZLIM = 'Безлимитный'
    COMB = 'Комбинированный'
    HOURLY = 'Повременный'

    def self.all_types
        [
          BEZLIM, COMB,HOURLY
        ]
      end
end