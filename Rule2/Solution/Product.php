<?php

class Rule2_Solution_Item
{
    public function isExchanded()
    {
        return ($this->getExchangedAt() !== null) ? true : false;
    }
}
