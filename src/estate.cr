# TODO: Write documentation for `Estate`
module Estate
  extend self

  VERSION = "0.1.0"

  def create(initial)
    State.new(initial)
  end
  
  class State(T)
    def initialize(initial : T)
      @state = initial
    end

    def get
      @state
    end

    def get(selector : Tuple)
      if (selector.size == 1)
        @state[selector.first]
      else
        selector.map { |name| @state[name] }
      end
    end

    def set
      @state
    end

    def set(&block)
      @state = @state.merge(yield @state)
    end

    def select
      @state
    end

    def select(selector : Tuple)
      if (selector.size == 1)
       -> { @state[selector.first] }
      else
       -> { selector.map { |name| @state[name] } }
      end
    end

    def select(&block : T -> _)
      yield @state
      -> { invoce(@state, &block) }
    end

    private def invoce(state, &block : T -> _)
      block.call(state)
    end

  end
end
