<?php
/**
 * @author Oliver Tischlinger
 *
 *
 * @package Bob_Db
 */
class Bob_Db_Table_Rowset extends Zend_Db_Table_Rowset
{
    /**
     * @param array $columns
     * @return array
     */
    public function toFilteredArray (array $columns)
    {
         $result = array();
         /* @var $row Zend_Db_Table_Row */
         foreach ($this as $row) {
             $resultRow = array();
             foreach ($columns as $column) {
                 $resultRow[$column] = $row[$column];
             }
             $result[] = $resultRow;
         }
         return $result;
    }
 
    /**
     * filters an array and returns an object having array indexes as member variables
     * @param array $columns
     * @return stdClass
     */
    public function toFilteredObject(array $columns)
    {
         $filteredArray = $this->toFilteredArray($columns);
         $filteredObject = new stdClass();
         foreach ($filteredArray as $key => $val) {
             $filteredObject->$key = $val;
         }
         return $filteredObject;
    }
 
    /**
     * @param string $keyColumn
     * @param string $valueColumn
     * @return array
     */
    public function toAssociativeArray ($keyColumn, $valueColumn)
    {
         $result = array();
         /* @var $row Zend_Db_Table_Row */
         foreach ($this as $row) {
             $result[$row[$keyColumn]] = $row[$valueColumn];
         }
         return $result;
    }
    /**
     * @param string $column
     * @return array
     */
    public function toArrayOneColumn ($column)
    {
         $result = array();
         /* @var $row Zend_Db_Table_Row */
         foreach ($this as $row) {
             $result[] = $row[$column];
         }
         return $result;
    }
    /**
     * @return array
     */
    public function getIds ()
    {
         $result = array();
         /* @var $row Bob_Db_Table_Row */
         foreach ($this as $row) {
             $result[] = $row->getId();
         }
         return $result;
    }
    /**
     * @return $result
     */
    public function toOptionArray ($forceSort = true)
    {
         $result = array('' => '');
         /* @var $row Bob_Db_Table_Row */
         foreach ($this as $row) {
             if ($row instanceof Bob_LabelInterface) {
                 $result[$row->getId()] = $row->getLabel();
             } else {
                 throw new Exception('Rowclass ' . get_class($row) . ' must implement Bob_LabelInterface!');
             }
         }
         if(true === $forceSort) {
             natcasesort($result);
         }
         return $result;
    }
}