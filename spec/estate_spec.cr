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
end
