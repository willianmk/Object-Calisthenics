<?php

class Rule2_Solution3_Item
{
    public function isExchanded()
    {
        if($this->getExchangedAt() !== null)
            return true;

        return false;
    }
}
