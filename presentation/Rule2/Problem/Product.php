<?php

class Rule2_Problem_Item
{
    public function isExchanded()
    {
        if($this->getExchangedAt() !== null)
            return true;
        else
            return false;
    }
}
