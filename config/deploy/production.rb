set :stage, :production

server "inventory.kreeti.com", roles: %w[app web db], user: 'inventory'
