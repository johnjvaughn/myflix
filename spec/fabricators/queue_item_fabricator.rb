Fabricator(:queue_item) do
  sort_order { (1..10).to_a.sample }
end