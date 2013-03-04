Feature: Inventory and available menu on application startup
  As a customer
  I want to see the inventory and available menu
  So I can make my choices

  Scenario: Initial inventory
    Given a fully stocked baristamatic
    When I start the machine
    Then I get the following output:
      """
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,10
      Decaf Coffee,10
      Espresso,10
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
    When I input the following commands:
      """
      2

      q


      """
    Then I get the following output:
      """
      Dispensing: Caffe Latte
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,10
      Decaf Coffee,10
      Espresso,8
      Foamed Milk,10
      Steamed Milk,9
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
    # How about a restock now?
    When I input the following commands:
      """
      r
      """
    Then I get the following output:
      """
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,10
      Decaf Coffee,10
      Espresso,10
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


  Scenario: Bogus input
    Given a started, fully stocked baristamatic
    When I input the following commands:
    """
    7
    """
    Then I get the following output:
    """
    Invalid selection: 7
    Inventory:
    Cocoa,10
    Coffee,10
    Cream,10
    Decaf Coffee,10
    Espresso,10
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

  Scenario: 
    Given a started, fully stocked baristamatic
    When I input the following commands:
    """
    6
    6
    6
    6
    """
    Then I get the following output:
      """
      Dispensing: Decaf Coffee
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,9
      Decaf Coffee,7
      Espresso,10
      Foamed Milk,10
      Steamed Milk,10
      Sugar,9
      Whipped Cream,10
      Menu:
      1,Caffe Americano,$3.30,true
      2,Caffe Latte,$2.55,true
      3,Caffe Mocha,$3.35,true
      4,Cappuccino,$2.90,true
      5,Coffee,$2.75,true
      6,Decaf Coffee,$2.75,true
      Dispensing: Decaf Coffee
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,8
      Decaf Coffee,4
      Espresso,10
      Foamed Milk,10
      Steamed Milk,10
      Sugar,8
      Whipped Cream,10
      Menu:
      1,Caffe Americano,$3.30,true
      2,Caffe Latte,$2.55,true
      3,Caffe Mocha,$3.35,true
      4,Cappuccino,$2.90,true
      5,Coffee,$2.75,true
      6,Decaf Coffee,$2.75,true
      Dispensing: Decaf Coffee
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,7
      Decaf Coffee,1
      Espresso,10
      Foamed Milk,10
      Steamed Milk,10
      Sugar,7
      Whipped Cream,10
      Menu:
      1,Caffe Americano,$3.30,true
      2,Caffe Latte,$2.55,true
      3,Caffe Mocha,$3.35,true
      4,Cappuccino,$2.90,true
      5,Coffee,$2.75,true
      6,Decaf Coffee,$2.75,false
      Out of stock: Decaf Coffee
      Inventory:
      Cocoa,10
      Coffee,10
      Cream,7
      Decaf Coffee,1
      Espresso,10
      Foamed Milk,10
      Steamed Milk,10
      Sugar,7
      Whipped Cream,10
      Menu:
      1,Caffe Americano,$3.30,true
      2,Caffe Latte,$2.55,true
      3,Caffe Mocha,$3.35,true
      4,Cappuccino,$2.90,true
      5,Coffee,$2.75,true
      6,Decaf Coffee,$2.75,false
     
      """
