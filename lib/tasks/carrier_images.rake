# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Metrics/BlockNesting
namespace :db do
  namespace :image_seeds do
    desc 'Load carrier images from seeds'
    task carriers: :environment do
      organization = Organization.find_by(subdomain: 'midatlantic')
      photos_added = 0
      carriers_processed = 0
      carriers_not_found = []
      if organization
        path = File.join Rails.root, 'db/data/inventory.csv'
        if File.exist?(path)
          csv_text = File.read(path)
          csv = CSV.parse(csv_text, headers: true)
          csv.each do |row|
            csv_carrier = row.to_hash
            carrier = Carrier.find_by(item_id: csv_carrier['Item ID'], organization: organization)
            if carrier
              carriers_processed += 1
              unless carrier.photos.attached?
                url = csv_carrier['Image']
                if url.present?
                  filename = File.basename(URI.parse(url).path)
                  file = URI.open(url)
                  carrier.photos.attach(io: file, filename: filename)
                  photos_added += 1
                  puts "#{photos_added} photos added..." if (photos_added % 10).zero?
                end
              end
            else
              carriers_not_found << csv_carrier['Item ID']
            end
          end
        else
          puts 'File db/data/inventory.csv not found.'
        end
      else
        "Organization with subdomain 'midatlantic' not found."
      end
      puts "#{carriers_processed} carriers processed."
      puts 'Not found:'
      puts carriers_not_found.inspect
      puts "#{photos_added} photos added."
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/BlockNesting
