class FakeSinatra
  def initialize
    @blocks = {}
  end

  def exec(url)
    block = @blocks[url]
    block.call if block
  end

  def get(url, &captured_block)
    @block[url] = captured_block
  end
end
