require 'csv'

user1 = User.create(email: 'ola@example.com', password: 'password', password_confirmation: 'password')
account1 = Account.create(name: 'Hajsy', user: user1)
user2 = User.create(email: 'arek@example.com', password: 'password', password_confirmation: 'password')
account2 = Account.create(name: 'Hajsy2', user: user2)

categories = ['Jedzenie', 'Rachunki - dom', 'Rachunki - praca', 'Rachunki - inne', 'Dochód',
 'Elektronika', 'Kosmetyki', 'Inne', 'Domowe zasoby', 'Prywatne', 'Kawa', 'Transfer',
 'Ubrania', 'Kot', 'Oszczędności', 'Samochód', 'Transport', 'Rozrywka']

categories.each do |cat|
  Category.create(name: cat)
end

MATCHING_CATEGORIES = {
  'Jedzenie' => ['BIEDRONKA',
             'WYPIEKI',
             'TESCO',
             'MCDONALDS',
             'RESTAURANT',
             'AUCHAN',
             'CARREFOUR',
             'KFC',
             'AUTOMATY',
             'KARMELLO',
             'BURGER',
             'PIOTR',
             'SUSHI',
             'AUTOMATY'
           ],
  'Kawa' => ["FIVE O'CLOCK"],
  'Transfer' => ['TRANSFER', 'PRZELEW WEWNĘTRZNY'],
  'Dochód' => ['WYNAGRODZENIE', 'WYPŁATA', 'WPŁATA'],
  'Rachunki - dom' => ['ZALICZKI', 'ZALICZKI', 'NETFLIX', 'AMAZON VIDEO'],
  'Rachunki - praca' => [],
  'Rachunki - inne' => ['CINEMA CITY', 'BLUEMEDIA', 'SPOTIFY', 'TPAY'],
  'Elektronika' => ['MEDIA MARKT'],
  'Kosmetyki' => ['PHARM', 'GOLDEN', 'ROSSMANN', 'PIGMENT'],
  'Inne' => ['EMPIK', 'ZABKA', 'GOOGLE', 'POCZTA', 'ALLEGRO'],
  'Domowe zasoby' => ['JYSK', 'IKEA', 'MAKRO'],
  'Ubrania' => ['CCC', 'GATTA'],
  'Kot' => [],
  'Oszczędności' => [],
  'Samochód' => ['ORLEN'],
  'Transport' => ['TRAFICAR', 'MPK', 'MYTAXI', 'BILETY SKYCASH', 'UBER', 'MYTAXI'],
  'Prywatne' => ['CIRCLE', 'APTEKA', 'INMEDIO', 'AMAZON', 'AMZN', 'KINDLE'],
  'Rozrywka' => ['BROWAR', 'PLAC NOWY', 'KAWA', 'TAWERNA', 'HELMUT', 'CAFE']
}

def match_category(operation)
  matching_value = nil
  MATCHING_CATEGORIES.values.flatten.each do |value|
    if operation.include?(value)
      matching_value = value
    end
  end

  unless matching_value.nil?
    pair = MATCHING_CATEGORIES.select do |key, value|
      matching_value.in?(value)
    end
    category_name = pair.keys.first
    category = Category.find_by(name: category_name)
  else
    category = nil
  end
  category
end

CSV.foreach("tmp/eKonto_76504441_181001_181220.csv", encoding: 'windows-1250', headers: true, col_sep: ';') do |row|
  operation = row[3]&.split('/')&.first&.upcase

  next if operation.nil?
  category = match_category(operation)
  value = row[6].delete(' ')
  operation_type = if value.include?('-')
                     0
                   else
                     1
                   end
  comment = 'Data operacji: ' + row[0] + ' opis: ' + row[2] + ' tytuł: ' + row[3] + ' Nadawca/Odbiorca: ' + row[4]

  sanitized_value = value.delete('-').sub(',', '.').to_f

  if sanitized_value > 6000 || sanitized_value == 4000 || sanitized_value == 8000
    category = Category.find_by(name: 'Car')
  end

  Operation.create(category: category,
                   user: User.first,
                   account: Account.first,
                   operation_type: operation_type,
                   value: sanitized_value,
                   comment: comment,
                   paid_at: row[0].to_date
                 )
end

# CSV.foreach("tmp/eKonto_76445515_180802_181102.csv", encoding: 'windows-1250', headers: true, col_sep: ';') do |row|
#   operation = row[3].split('/').first.upcase
#   category = match_category(operation)
#   value = row[6].delete(' ')
#   operation_type = if value.include?('-')
#                      0
#                    else
#                      1
#                    end
#   comment = 'Data operacji: ' + row[0] + ' opis: ' + row[2] + ' tytuł: ' + row[3] + ' Nadawca/Odbiorca: ' + row[4]

#   sanitized_value = value.delete('-').sub(',', '.').to_f

#   if sanitized_value > 6000 || sanitized_value == 4000 || sanitized_value == 8000
#     category = Category.find_by(name: 'Car')
#   end

#   Operation.create(category: category,
#                    user: user2,
#                    account: account2,
#                    operation_type: operation_type,
#                    value: sanitized_value,
#                    comment: comment,
#                    paid_at: row[0].to_date
#                  )
# end

SETTINGS = {
  "Dom"=>["Rachunki - dom", "Domowe zasoby"],
  "Jedzenie"=>["Jedzenie", "Kawa"],
  "Opłaty praca"=>["Rachunki - praca"],
  "Rozrywka"=>["Rachunki - inne", "Rozrywka"],
  "Transport"=>["Samochód", "Transport"],
  "Kot"=>["Kot"],
  "Oszczędności"=>["Oszczędności", "Transfer"],
  "Inne"=>["Ubrania", "Elektronika", "Kosmetyki", "Inne", "Prywatne"],
  "Dochody"=>["Dochód"]
}

SETTINGS.each_pair do |key, value|
  cat_ids = Category.where(name: value).pluck(:id)

  Setting.create(name: key,
                 category_ids: cat_ids)
end
