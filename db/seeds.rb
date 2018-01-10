# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

2.times do 
Video.create([
{
  title: "Futurama", 
  description: "Philip J. Frye's adventures in the year 3000.",
  category_id: 1,
  small_cover_url: "tmp/futurama.jpg",
  large_cover_url: "https://comedycentral.mtvnimages.com/images/tve/futurama/tve_series_page/Futurama_NextGen_Spotlight_NoLogo_1920x1080.jpg?width=640&height=360&crop=true"
},
{
  title: "Family Guy", 
  description: "Peter & Lois Griffin and family.",
  category_id: 2,
  small_cover_url: "tmp/family_guy.jpg",
  large_cover_url: "https://images-na.ssl-images-amazon.com/images/G/01/digital/video/hero/TVSeries/FamilyGuy_6647600-FAMILYGUY._V392937825_RI_SX940_.jpg"
},
{
  title: "South Park", 
  description: "School kids in South Park, Colorado.",
  category_id: 2,
  small_cover_url: "tmp/south_park.jpg",
  large_cover_url: "https://media.hufworldwide.com/media/wysiwyg/HUF/collaborations/south-park/huf-x-south-park-739x550.jpg"
},
{
  title: "Monk", 
  description: "Detective show",
  category_id: 3,
  small_cover_url: "tmp/monk.jpg",
  large_cover_url: "tmp/monk_large.jpg"
}
]);
end