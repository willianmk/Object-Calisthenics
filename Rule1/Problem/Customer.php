<?php

class Rule1_Problem_Customer
{
    public function hasDiscountForSpentOrders($totalAmount)
    {
        $accumulatedTotal = 0;
        $orders = $this->getOrdersByCustomer($this->id);

        foreach ($orders as $order) {
            $items = $order->getItems();

            foreach ($items as $item) {
                $accumulatedTotal += $item->getPaidPrice();

                if($accumulatedTotal >= $totalAmount)
                    return true;
            }
        }

        return false;
    }
}
