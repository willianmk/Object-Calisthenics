<?php

class Rule1_Solution_Customer
{
    public function hasDiscountForSpentOrders(float $totalAmount)
    {
        $orders = $this->getOrdersByCustomer($this->id);

        foreach ($orders as $order) {
            $items = $order->getItems();
            $accumulatedTotal = $this->getAccumulatedTotal($items);
        }

        return ($accumulatedTotal >= $totalAmount);
    }

    public function getAccumulatedTotal(ItemContainer $items)
    {
        $accumulatedTotal = 0;

        foreach ($items as $item) {
            $accumulatedTotal += $item->getPaidPrice();
        }
        return $accumulatedTotal;
    }
}
