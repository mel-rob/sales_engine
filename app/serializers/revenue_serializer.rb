class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |revenue|
    revenue.date_revenue
  end
end
