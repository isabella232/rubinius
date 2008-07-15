require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/fixtures/private'

describe "The private keyword" do
  it "marks following methods as being private" do
    a = Private::A.new
    a.methods.should_not include("bar")
    lambda { a.bar }.should raise_error(NoMethodError)

    b = Private::B.new
    b.methods.should_not include("bar")
    lambda { b.bar }.should raise_error(NoMethodError)
  end

  it "is overridden when a new class is opened" do
    c = Private::B::C.new
    c.methods.should include("baz")
    c.baz
    Private::B::public_class_method1.should == 1
    Private::B::public_class_method2.should == 2
    lambda { Private::B::private_class_method1 }.should raise_error(NoMethodError)
  end

  it "is no longer in effect when the class is closed" do
    b = Private::B.new
    b.methods.should include("foo")
    b.foo
  end
end