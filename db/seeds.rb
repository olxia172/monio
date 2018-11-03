require 'csv'

user1 = User.create(email: 'ola@example.com', password: 'password', password_confirmation: 'password')
account1 = Account.create(name: 'Hajsy', user: user1)
user2 = User.create(email: 'arek@example.com', password: 'password', password_confirmation: 'password')
account2 = Account.create(name: 'Hajsy2', user: user2)

categories = ['Food', 'Bills - home', 'Bills - work', 'Bills - other', 'Income',
 'Electronics', 'Cosmetics', 'Other', 'Home supplies', 'Private', 'Coffee', 'Transfer',
 'Clothes', 'Cat', 'Savings', 'Car', 'Income', 'Transport', 'Entertainment', 'Wedding']

categories.each do |cat|
  Category.create(name: cat)
end

MATCHING_CATEGORIES = {
  'Food' => ['BIEDRONKA',
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
  'Coffee' => ["FIVE O'CLOCK"],
  'Transfer' => ['TRANSFER', 'PRZELEW WEWNĘTRZNY'],
  'Income' => ['WYNAGRODZENIE', 'WYPŁATA', 'WPŁATA'],
  'Bills - home' => ['ZALICZKI', 'ZALICZKI', 'NETFLIX', 'AMAZON VIDEO'],
  'Bills - work' => [],
  'Bills - other' => ['CINEMA CITY', 'BLUEMEDIA', 'SPOTIFY', 'TPAY'],
  'Electronics' => ['MEDIA MARKT'],
  'Cosmetics' => ['PHARM', 'GOLDEN', 'ROSSMANN', 'PIGMENT'],
  'Other' => ['EMPIK', 'ZABKA', 'GOOGLE', 'POCZTA', 'ALLEGRO'],
  'Home supplies' => ['JYSK', 'IKEA', 'MAKRO'],
  'Clothes' => ['CCC', 'GATTA'],
  'Cat' => [],
  'Savings' => [],
  'Car' => ['ORLEN'],
  'Transport' => ['TRAFICAR', 'MPK', 'MYTAXI', 'BILETY SKYCASH', 'UBER', 'MYTAXI'],
  'Private' => ['CIRCLE', 'APTEKA', 'INMEDIO', 'AMAZON', 'AMZN', 'KINDLE'],
  'Entertainment' => ['BROWAR', 'PLAC NOWY', 'KAWA', 'TAWERNA', 'HELMUT', 'CAFE']
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

CSV.foreach("tmp/eKonto_76504441_180802_181102.csv", encoding: 'windows-1250', headers: true, col_sep: ';') do |row|
  operation = row[3].split('/').first.upcase
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
                   user: user1,
                   account: account1,
                   operation_type: operation_type,
                   value: sanitized_value,
                   comment: comment
                 )
end

CSV.foreach("tmp/eKonto_76445515_180802_181102.csv", encoding: 'windows-1250', headers: true, col_sep: ';') do |row|
  operation = row[3].split('/').first.upcase
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
                   user: user2,
                   account: account2,
                   operation_type: operation_type,
                   value: sanitized_value,
                   comment: comment
                 )
end
