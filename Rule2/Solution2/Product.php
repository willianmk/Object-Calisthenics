<?php

class Rule2_Solution2_Item
{
    public function isExchanded()
    {
        $returnValue = false;
        if($this->getExchangedAt() !== null)
            $returnValue = true;

        return $returnValue;
    }
}
