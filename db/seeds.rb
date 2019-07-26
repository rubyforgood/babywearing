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

Agreement.create(title: 'Membership Agreement', content: 'MidAtlantic Babywearing is the local babywearing education group for Pennsylvania, New Jersey, and
  Delaware, and is a non-profit group.
  To become a member of our chapter you must:
  1) Fill out the membership application and agreement.
  2) Pay your dues of $30/single carrier or $50/two carriers for 12 months or $10/one month trial by PayPal
  Membership Donation becomes active when application AND payment have been received.')

  Agreement.create(title: 'Lending Library Use Agreement', content: 'MAB has a library of baby carriers and babywearing educational materials for members to borrow.
    The following policies apply:
    1. Your Responsibility. You assume the responsibility for safely using all carriers and for inspecting
    the stitching and fabric on all carriers to satisfy yourself that the carrier is sound and suitable for
    use with your child, and you assume the risk of using a carrier. Each time you borrow a carrier,
    you agree to indemnify and hold harmless MAB, its volunteers and members (the “Releasees”),
    for any harm that may result to you or your child from using the carrier, including any harm
    allegedly resulting from the Releasees’ instruction or alleged failure to instruct.')