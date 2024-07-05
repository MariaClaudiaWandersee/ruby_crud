class Coin < ApplicationRecord
  belongs_to :mining_type # pois tem uma chave estrangeira de outra tabela (campo mining_type)
end
