<?php
/**
 * ... description ...
 *
 * @package Bob_Data
 * @version $id @copyright Copyright (c) 2011 Rocket Internet GmbH, Saarbrücker Straße 20/21, 10405 Berlin, http://www.rocket-internet.de/
 * @author Bob Team <bob@bigfoot-gmbh.com>
 */
interface Bob_Data_ContainerInterface extends ArrayAccess, Traversable
{
    /**
     * Returns the column/value data as an array.
     *
     * @return array
     */
    public function toArray ();
    /**
     * Sets all data in the row from an array.
     *
     * @param  array $data
     */
    public function setFromArray (array $data);
}