<?php

class Rule4_Problem_Customer
{
    private $addresses = array();

    public function addAddress(array $address, string $type = 'billing')
    {
        $this->addresses[] = $address;
    }
}
