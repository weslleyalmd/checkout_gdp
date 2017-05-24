# GDP Coding Exercise

All default products and rules are already created.

I built a Command Line Interface, run the cli.rb file and remember to install the terminal-table gem. You can find the next options at the CLI:

1. **Inventory:** Get all the products from the store.
2. **Find product:** Find a product given a specific code.
3. **Create product:** Create a new product for the store.
4. **Scan product:** Add a new item to checkout process.
5. **Total:** Get the total value for checkout process after applying all the rules.
6. **Exit:** Finish the program.

After add all products you want, enter **5** to calculate the total price and then enter the client name.

Premium clients (that has special pricing rules) are listed below:
1. Unilever
2. Nike
3. Apple
4. Ford

To add new rules, just edit the **default_rules.json** file. There are two types of rule:

1. **TwoForOneRule:** this rules is used to apply the "Buy n and pay n-1" type of rule. E.g. Buy 4 and pay for 3. The strucure of this type of rule is shown below:

```
{
  "type"          : "twoforone", // type of rule
  "client"        : "UNILEVER",  // client that the rule must be applied
  "product"       : "classic",   // product that the rule affects
  "eligible_qtty" : "3"          // minimum quantity to apply the rule
},
```

2. **DiscountRule:** this rules is used to apply new price to the products. E.g. Buy 4 product A (that costs $200 and pay $150 on each one. The strucure of this type of rule is shown below:

```
{
  "type"          : "discount",  // type of rule
  "client"        : "UNILEVER",  // client that the rule must be applied
  "product"       : "classic",   // product that the rule affects
  "eligible_qtty" : "0",         // minimum quantity to apply the rule. Use 0 (zero) to apply new price to every product on list
  "new_price"     : "309.99"     // new price to be used
},
```

## Test

To run the test, just use the command ```ruby path_to_test_file.rb```.
The ```checkout_test.rb``` run all examples describe on the exercise.