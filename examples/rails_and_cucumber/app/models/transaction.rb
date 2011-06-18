class Transaction
  attr_accessor :type, :amount, :year
  
  def self.truncate
    @@all = []  
  end
  
  def self.create(attrs)
    txn = Transaction.new(attrs)
    @@all << txn
    txn
  end
  
  def self.find_all(attrs)
    @@all.select do |txn|
      attrs.all? { |k, v| txn.send(k) == v }
    end
  end
  
  def initialize(attrs)
    self.type = attrs[:type]
    self.amount = attrs[:amount]
    self.year = attrs[:year]
  end
end