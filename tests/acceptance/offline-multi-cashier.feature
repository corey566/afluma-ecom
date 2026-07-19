Feature: Offline multi-cashier sale synchronizes exactly once

  Background:
    Given tenant "pilot-retail" has branch "COL-01" and warehouse "COL-MAIN"
    And Store Edge "EDGE-01" is connected to cashier devices "POS-01" and "POS-02"
    And product variant "SKU-TEST-001" has 10 units available
    And both cashiers have open cash registers

  Scenario: Two cashiers sell while cloud is unavailable
    Given cloud connectivity is unavailable but the store LAN is healthy
    When cashier "POS-01" sells 3 units for cash
    And cashier "POS-02" sells 2 units for cash
    Then Store Edge reports 5 units available
    And both receipts are durable locally
    When Store Edge restarts
    And cloud connectivity returns
    And the first sale event is intentionally delivered twice
    Then the cloud records exactly 2 orders
    And the cloud records exactly 2 cash payments
    And cloud inventory available quantity is 5
    And every posted journal is balanced
    And Store Edge pending synchronization count is 0
