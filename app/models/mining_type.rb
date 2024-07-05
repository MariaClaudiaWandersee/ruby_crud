class MiningType < ApplicationRecord
  has_many :coins # has_many fica do lado quem nao tem a FK, mas tem referencia na tabela coins
end
