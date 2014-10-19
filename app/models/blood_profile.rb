require 'date'

class BloodProfile
  def initialize(attributes = {})
    @attributes = attributes
  end

  def donations
    @donations ||= deep_fetch('history', 'totals', 'donations') { 0 }
  end

  def lives_saved
    donations * 3
  end

  def last_donation
    @last_donation ||= make_date(deep_fetch('history', 'latest', 'timestamp'))
  end

  def eligibility
    @eligibility ||= make_date(deep_fetch('history', 'eligibility', 'blood'))
  end

  def to_yaml
    @attributes.to_yaml
  end

  private
  
  # Repeatedly fetch an element from a hash of hashes
  def deep_fetch(*fields, &default)
    value = @attributes
    fields.each_index do |i|
      unless i == fields.length - 1
        value = value.fetch(fields[i], {})
      else
        # Get the default value from a block or use nil if no block
        value = value.fetch(fields[i], block_given? ? yield : nil)
      end
    end
    value
  end

  def make_date(raw_date)
    if raw_date.nil?
      nil
    else
      Date.parse(raw_date)
    end
  end
end
