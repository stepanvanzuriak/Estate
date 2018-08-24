require "./spec_helper"

describe Estate do
  # TODO: Write tests

  it "get" do
    initState = {name: "John", age: 12}
    test = Estate.create(initState)
  
    test.get().should eq(initState)
    test.get({"name"}).should eq("John")

    test.get({"age"}).should eq(12)
    
    test.get({"name", "age"}).should eq({"John", 12})
    
    test.get({"age"}).should eq(12)

  end

  it "set" do
    initState = {name: "John", age: 12}
    test = Estate.create(initState)

    test.set.should eq(initState)

    test.set {|prev| {name: "Steve"} }
    test.get.should eq({name: "Steve", age: 12})

    test.set {|prev| {age: 2 + prev["age"]} }
    test.get.should eq({name: "Steve", age: 14})
  end

  it "select" do
    initState = {name: "John", age: 12}
    test = Estate.create(initState)

    test.select.should eq(initState)

    name = test.select({"name"})

    name.call.should eq("John")
    name.call.should eq("John")

    extraAge = test.select {|state| {age: state["age"] + 2} }

    extraAge.call.should eq({age: 14})
    extraAge.call.should eq({age: 14})

    ageOnly = test.select {|state| state["age"]}
    ageOnly.call.should eq(12)
    ageOnly.call.should eq(12)
  end

  it "example1" do
    state = Estate.create({name: "Steve", age: 19})

    state.get({"name"}).should eq("Steve")
    state.get({"name", "age"}).should eq({"Steve", 19})
  end

  it "example2" do
    state = Estate.create({bugs: 12, features: 13})
    state.set { |prev| {features: prev["features"] + 1, bugs: prev["bugs"] + 10} }

    state.get.should eq({bugs: 22, features: 14})
  end

  it "example3" do
    state = Estate.create({name: "Jhon", status: "king", age: 21})
    status = state.select({"status"})
    extra_age = state.select { | state | state["age"] + 2 }

    status.call.should eq("king")
    extra_age.call.should eq(23)

    state.set { |prev| {age: prev["age"] + 1} }

    extra_age.call.should eq(24)
  end

  it "list example" do
    state = Estate.create({name: "Jhon", status: "king", age: 21, list: [1, 2, 3]})
    list = state.select({"list"})

    list.call.should eq([1, 2, 3])
  end

  it "nested tuples" do
    state = Estate.create({data: {foo: {bar: 42}}})

    state.get.should eq({data: {foo: {bar: 42}}})

    foo = state.select {|state| state["data"]["foo"]}

    foo.call.should eq({bar: 42})
  end
end
