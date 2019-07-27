# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Location.create(name: 'Pittsburgh')
Location.create(name: 'Erie')
Location.create(name: 'Carnegie')
Location.create(name: 'Heidelberg')

role_names_array = ['admin', 'volunteer', 'member', 'user']
role_names_array.each do |role_name|
  Role.create(name: role_name)
end

# Categories
asian_inspired_carriers = Category.create(name: 'Asian Inspired Carriers')
asian_inspired_carriers.subcategories << Category.create([
  { name: 'Chuneis' }, { name: 'Hmongs' }, { name: 'Meh Dais / Bei Dais' },
  { name: 'Onbuhimos'}, { name: 'Other Asian Inspired Carriers' }, { name: 'Podaegis' }
])

buckle_carriers = Category.create(name: 'Buckle Carriers')
buckle_carriers.subcategories << Category.create([
  { name: 'Full Buckle Carriers' }, { name: 'Half Bucket Carriers' }, { name: 'Other Buckle Carriers' },
  { name: 'Ring Waist Carriers' }, { name: 'Reverse Half Buckle Carriers' }
])

Category.create([
  { name: 'Carrier Accessories & Other' }, { name: 'Other Baby Carriers' },
  { name: 'Pouch Carriers' }, { name: 'Water Baby Carriers' }
])

ring_slings = Category.create(name: 'Ring Slings')
ring_slings.subcategories << Category.create([
  { name: 'Gathered Ring Slings' }, { name: 'Hot Dog Ring Slings' }, { name: 'Hybrid Ring Slings' },
  { name: 'Other Ring Slings' }, { name: 'Padded Ring Slings' }, { name: 'Pleated Ring Slings' }
])

wrap_carriers = Category.create(name: 'Wrap Carriers')
wrap_carriers.subcategories << Category.create([
  { name: 'Hybrid Wrap Carriers' }, { name: 'Stretchy Wrap Carriers' }, { name: 'Woven Wrap Carriers' }
])

Category.create(name: 'Stretch Loop Carriers', parent_id: Category.find_by_name('Stretchy Wrap Carriers').id)
Category.find_by_name('Woven Wrap Carriers').subcategories << Category.create([
  { name: 'Chitenges' }, { name: 'Khangas' }, { name: 'Lesos' },
  { name: 'Mantas' }, { name: 'Rebozos' }
])
