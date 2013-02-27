<?php
/**
 * @author Oliver Tischlinger
 *
 *
 * @package Bob_Db
 */
class Bob_Db_Table_Row extends Zend_Db_Table_Row implements Bob_Data_ContainerInterface
{
    /**
     * Description of the Column
     * @var array
     */
    protected $_columnDescription = array();

    /** TRUE when, the last update actually updated data */
    protected $_dataWasUpdated = false;

    /**
     * @return int
     */
    public function getId()
    {
        $primaryKeyName = $this->getTable()->getPrimaryKeyName();
        return (int)$this[$primaryKeyName];
    }

    /**
     * Set row field value
     *
     * @param  string $columnName The column key.
     * @param  mixed  $value      The value for the property.
     * @return void
     * @throws Zend_Db_Table_Row_Exception
     */
    public function __set($columnName, $value)
    {
        if (is_bool($value)) {
            $value = (int)$value;
        }
        if (($value === '' || $value === null) && ($this->isNullable($columnName))) {
            $value = null;
        }
        $oldValue = $this->__get($columnName);
        if ($oldValue !== $value) {
            // Neuen Wert nur Speichern, wenn er sich von dem aktuellen Wert unterscheidet.
            parent::__set($columnName, $value);
        }
    }

    public function setFromArray(array $data)
    {
        $data = $this->_preprocessDataArray($data);
        parent::setFromArray($data);
    }

    /**
     * fixes a bug in ZF - floats like 12.90 are compared with existing
     * data as 12.9 and thus considered to be a new value. comparable probs
     * goes for boolean
     *
     * @see Zend_Db_Table_Row_Abstract::setFromArray()
     */
    protected function _preprocessDataArray($data)
    {
        $columnInfo = $this->getTable()->info(Zend_Db_Table_Abstract::METADATA); // result will be cached
        foreach ($data as $columnName => $columnValue) {
            if (null !== $columnValue && '' !== $columnValue && array_key_exists($columnName, $columnInfo)) {
                $dataType = strtolower($columnInfo[$columnName]['DATA_TYPE']);
                if ($dataType === 'decimal') {
                    if ($columnName == 'special_price' && $columnValue == 'null') {
                        $data[$columnName] = null;
                    } else {
                        $data[$columnName] = number_format($columnValue, $columnInfo[$columnName]['SCALE'], '.', '');
                    }
                } elseif (is_bool($columnValue)) {
                    $data[$columnName] = in_array($columnValue, array('1', 1, true)) ? '1' : '0';
                }
            } elseif ($columnName == 'special_price' && $columnValue == 'null') {
                $data[$columnName] = null;

            }
        }
        return $data;
    }

    /**
     * added feature: zend db table does not support to tell IF data was modified
     * this function re-computes data differences and sets $_dataWasUpdated
     *
     * @see Zend_Db_Table_Row_Abstract::_postUpdate()
     */
    protected function _postUpdate()
    {
        $diffData = array_intersect_key($this->_data, $this->_modifiedFields);
        $this->_dataWasUpdated = (count($diffData) > 0);
    }

    protected function _update()
    {
        $this->_dataWasUpdated = false;
    }

    public function dataWasUpdated()
    {
        return $this->_dataWasUpdated;
    }

    /**
     * remove all empty fields if numeric and nullable
     * @return unknown_type
     */
    public function unsetEmptyValuesIfNullable()
    {
        foreach ($this->_data as $field => $value) {
            if (method_exists($this->getTable(), 'getColumnInfo')) {
                /* use common getColumnInfo() if available */
                $type = $this->getTable()->getColumnInfo($field, 'type');
            } else {
                /* fall back to mysql-metadata if necessary */
                $info = $this->getTable()->info();
                $type = $info['metadata'][$field]['DATA_TYPE'];
            }
            if ('' === $value && (strpos('int', $type) !== false || strpos('decimal', $type) !== false)) {
                if ($this->isNullable($field)) {
                    /* value is an empty string, nullable and of numeric datatype. set it to NULL */
                    $this->$field = null;
                } else {
                    /* value is an empty string, field is numeric but not nullable. therefore, set it to zero */
                    $this->$field = 0;
                }
            }
        }
        return $this;
    }

    /**
     * Saves the properties to the database.
     *
     * This performs an intelligent insert/update, and reloads the
     * properties with fresh data from the table on success.
     *
     * @return mixed The primary key value(s), as an associative array if the
     * key is compound, or a scalar if the key is single-column.
     */
    public function save()
    {
        if (count($this->_modifiedFields) || empty($this->_cleanData)) {
            return parent::save();
        } else {
            return $this->getId();
        }
    }

    /**
     * @param array $columns
     * @return array
     */
    public function toFilteredArray(array $columns)
    {
        return array_intersect_key($this->_data, array_flip($columns));
    }

    /**
     * Allows pre-insert logic to be applied to row.
     * Subclasses may override this method.
     *
     * @return void
     */
    protected function _insert()
    {
        parent::_insert();
        if (array_key_exists('created_at', $this->toArray()) and
            null == $this['created_at']
        ) {
            $date = new DateTime();
            $this['created_at'] = $date->format(
                Bob_DateHelper::MYSQL_DATETIME_FORMAT
            );
        }
    }

    /**
     * Returns the description of the given column
     * @param string $column
     * @return string
     */
    public function getDescription($column)
    {
        if (array_key_exists($column, $this->_columnDescription)) {
            return $this->_columnDescription[$column];
        } else {
            return '';
        }
    }

    /**
     * Returns the validator for the column
     * @param string $columnName
     * @return Zend_Validate_Abstract|null
     */
    public function getValidator($columnName)
    {
        return $this->getTable()->getValidator($columnName);
    }

    /**
     * Returns the max. fieldlentgh for the column
     * @param string $columnName
     * @return int|null
     */
    public function getMaxFieldLength($columnName)
    {
        return $this->getTable()->getMaxFieldLength($columnName);
    }

    /**
     * Is the column nullable
     * @param string $columnName
     * @return bool|null
     */
    public function isNullable($columnName)
    {
        return $this->getTable()->isNullable($columnName);
    }

    /**
     * Get the enum-values
     * @param string $columnName
     * @return array
     */
    public function getEnumValues($columnName)
    {
        return $this->getTable()->getEnumValues($columnName);
    }

    /**
     * return tablename
     * @return string
     */
    public function getTablename()
    {
        return $this->getTable()->getName();
    }
}
