class Endpoint < SimpleDelegator
  def opposite
    return ENDPOINT_A if self == ENDPOINT_B
    return ENDPOINT_B if self == ENDPOINT_A
  end
end

ENDPOINT_A = Endpoint.new(:endpoint_a)
ENDPOINT_B = Endpoint.new(:endpoint_b)
