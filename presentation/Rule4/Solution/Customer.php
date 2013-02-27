<?php

class Rule4_Solution_Customer
{
    private $addresses = array();

    public function addAddress(Rule4_Solution_Address $address)
    {
        $this->addresses[] = $address;
    }
}

class Rule4_Solution_Address
{
    private $type;

    function __construct(string $type = 'billing')
    {
        $this->type = $type;
    }

}

$customer = new Rule4_Solution_Customer();
$customer->addAddress(new Rule4_Solution_Address('shipping'));