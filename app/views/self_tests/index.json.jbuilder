json.array! @self_test_groups do |self_test_group|
  json.done_at self_test_group.done_at
  json.total self_test_group.total
  json.total_positive self_test_group.total_positive
  json.total_positive_perc self_test_group.total_positive / self_test_group.total.to_f
end
