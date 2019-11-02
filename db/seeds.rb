# frozen_string_literal: true

require 'csv'
require 'uri'

include ActionView::Helpers::SanitizeHelper # included for strip_tags method to remove html from carrier descriptions

# Agreement
puts "Creating agreements..."
Agreement.create(title: 'Membership Agreement',
                 content: 'MidAtlantic Babywearing is the local babywearing education group for Pennsylvania,
  New Jersey, and Delaware, and is a non-profit group.
  To become a member of our chapter you must:
  1) Fill out the membership application and agreement.
  2) Pay your dues of $30/single carrier or $50/two carriers for 12 months or $10/one month trial by PayPal
  Membership Donation becomes active when application AND payment have been received.')

Agreement.create(title: 'Lending Library Use Agreement',
                 content: 'MAB has a library of baby carriers and babywearing educational materials for members to borrow.
  The following policies apply:
  1. Your Responsibility. You assume the responsibility for safely using all carriers and for inspecting
  the stitching and fabric on all carriers to satisfy yourself that the carrier is sound and suitable for
  use with your child, and you assume the risk of using a carrier. Each time you borrow a carrier,
  you agree to indemnify and hold harmless MAB, its volunteers and members (the “Releasees”),
  for any harm that may result to you or your child from using the carrier, including any harm
  allegedly resulting from the Releasees’ instruction or alleged failure to instruct.')

role_names_array = ['admin', 'volunteer', 'member', 'user']
role_names_array.each do |role_name|
  Role.create(name: role_name)
end
puts "Done."

# Categories
puts "Creating categories..."
asian_inspired_carriers = Category.create(name: 'Asian Inspired Carriers')
asian_inspired_carriers.subcategories << Category.create([
                                                           { name: 'Chuneis' }, { name: 'Hmongs' },
                                                           { name: 'Meh Dais / Bei Dais' },
                                                           { name: 'Onbuhimos' },
                                                           { name: 'Other Asian Inspired Carriers' },
                                                           { name: 'Podaegis' }
                                                         ])

buckle_carriers = Category.create(name: 'Buckle Carriers')
buckle_carriers.subcategories << Category.create([
                                                   { name: 'Full Buckle Carriers' },
                                                   { name: 'Half Buckle Carriers' },
                                                   { name: 'Other Buckle Carriers' },
                                                   { name: 'Ring Waist Carriers' },
                                                   { name: 'Reverse Half Buckle Carriers' }
                                                 ])

Category.create([
                  { name: 'Carrier Accessories & Other' },
                  { name: 'Other Baby Carriers' },
                  { name: 'Pouch Carriers' },
                  { name: 'Water Baby Carriers' }
                ])

ring_slings = Category.create(name: 'Ring Slings')
ring_slings.subcategories << Category.create([
                                               { name: 'Gathered Ring Slings' },
                                               { name: 'Hot Dog Ring Slings' },
                                               { name: 'Hybrid Ring Slings' },
                                               { name: 'Other Ring Slings' },
                                               { name: 'Padded Ring Slings' },
                                               { name: 'Pleated Ring Slings' }
                                             ])

wrap_carriers = Category.create(name: 'Wrap Carriers')
wrap_carriers.subcategories << Category.create([
                                                 { name: 'Hybrid Wrap Carriers' },
                                                 { name: 'Stretchy Wrap Carriers' },
                                                 { name: 'Woven Wrap Carriers' }
                                               ])

Category.create(name: 'Stretch Loop Carriers', parent_id: Category.find_by_name('Stretchy Wrap Carriers').id)
Category.find_by_name('Woven Wrap Carriers').subcategories << Category.create([
                                                                                { name: 'Chitenges' },
                                                                                { name: 'Khangas' },
                                                                                { name: 'Lesos' },
                                                                                { name: 'Mantas' },
                                                                                { name: 'Rebozos' }
                                                                              ])
puts "Done."

# FeeType
FeeType.create(name: 'Cleaning Fee', amount: 1500)
FeeType.create(name: 'Late Fee', amount: 100)
FeeType.create(name: 'Membership Donation', amount: 3000)
FeeType.create(name: 'Second Carrier Addition', amount: 500)
FeeType.create(name: 'Trial Membership', amount: 1000)

# Importing carriers
puts "Importing carriers..."
path = File.join Rails.root, 'db/data/inventory.csv'
csv_text = File.read(path)
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  csv_carrier = row.to_hash
  home_location = Location.find_or_create_by(name: csv_carrier['Home Location'])
  current_location = Location.find_or_create_by(name: csv_carrier['Current Location'])
  carrier_params = {
    name: csv_carrier['Name'],
    manufacturer: csv_carrier['Manufacturer'],
    model: csv_carrier['Model'],
    color: csv_carrier['Color'],
    size: csv_carrier['Size'],
    home_location_id: home_location.id,
    current_location_id: (current_location || home_location).id,
    default_loan_length_days: csv_carrier['Default Loan Length'].to_i,
    category: Category.find_by(name: csv_carrier['Item Type'])
    # description: strip_tags(csv_carrier['Description'])
  }

  Carrier.find_or_create_by(item_id: csv_carrier['Item ID']) do |carrier|
    carrier.update_attributes(carrier_params)

    url = csv_carrier['Image']
    if url.present?
      filename = File.basename(URI.parse(url).path)
      file = URI.open(url)

      carrier.photos.attach(io: file, filename: filename)
    end
  end
end
puts "Done."
