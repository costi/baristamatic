Feature: Inventory and available menu on application startup
  As a customer
  I want to see the inventory and available menu
  So I can make my choices

  Given a fully stocked barista-matic
  When I start the machine
  I get the following output:
  """
    Inventory:
    Cocoa,10
    Coffee,10
    Cream,10
    Decaf Coffee,10Espresso,10
    Foamed Milk,10
    Steamed Milk,10
    Sugar,10
    Whipped Cream,10
    Menu:
    1,Caffe Americano,$3.30,true
    2,Caffe Latte,$2.55,true
    3,Caffe Mocha,$3.35,true
    4,Cappuccino,$2.90,true
    5,Coffee,$2.75,true
    6,Decaf Coffee,$2.75,true
  """
