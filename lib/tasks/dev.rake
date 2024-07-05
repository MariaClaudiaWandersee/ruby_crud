namespace :dev do
  # Os usuários podem especificar tarefas com pré-requisitos.
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") {%x(rails db:drop)}
      show_spinner("Criando BD...") {%x(rails db:create)}
      show_spinner("Migrando BD...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQU8-3VdTw78JqT9R98qtZbEnr0HTYghIzUIHf3kvxwOypkY7YCg--zxXbqEmoGAirhoo&usqp=CAU",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },
      
                {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://www.creativefabrica.com/wp-content/uploads/2021/06/14/Cryptocurrency-Ethereum-Logo-Graphics-13394054-1-580x435.jpg",
                  mining_type: MiningType.all.sample
                },
      
                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://p.kindpng.com/picc/s/356-3561679_dash-crypto-logo-hd-png-download.png",
                  mining_type: MiningType.all.sample
                }
              ]
      
      coins.each do |coin| #coin é cada elemento da lista
        sleep(1)
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {
          description: 'Proof of Work', acronym: 'PoW'
        },
        {
          description: 'Proof of Stake', acronym: 'PoS'
        },
        {
          description: 'Proof of Capacity', acronym: 'PoC'
        }
      ]
      mining_types.each do |mining_type| #coin é cada elemento da lista
        sleep(1)
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private # o que está abaixo, só esse namespace (:dev) consegue usar

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
  
end

