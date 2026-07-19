# First vertical slice: offline multi-cashier retail sale

## Preconditions

- One tenant, branch, warehouse and Store Edge.
- Two cashier devices connected to Store Edge over LAN.
- One product with opening quantity 10.
- Cash register opened.

## Scenario

1. Disconnect Store Edge from cloud while keeping the LAN active.
2. Cashier A sells 3 units for cash.
3. Cashier B sells 2 units for cash.
4. Store Edge commits both sales and shows local available quantity 5.
5. Restart Store Edge before cloud connectivity returns.
6. Restore cloud connectivity.
7. Upload pending events, including one intentional duplicate.
8. Cloud accepts every unique event exactly once.
9. Cloud inventory balance becomes 5.
10. Two orders, two payments and balanced accounting journals exist.
11. Store Edge records acknowledgements and pending sync becomes zero.
