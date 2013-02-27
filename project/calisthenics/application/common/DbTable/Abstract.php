<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Abstract extends Zend_Db_Table implements Countable
{
    const SQL_DATE_PATTERN = 'yyyy-MM-dd HH:mm:ss';
    /**
     * Classname for row
     *
     * @var string
     */
    protected $_rowClass = 'Bob_Db_Table_Row';
    /**
     * Classname for rowset
     *
     * @var string
     */
    protected $_rowsetClass = 'Bob_Db_Table_Rowset';
    protected $_defaultSource = self::DEFAULT_DB;

    const COLUMN_NAMES = 0;
    const COLUMN_METADATA = 1;

    /**
     * Returns an instance of a Zend_Db_Table_Select object.
     *
     * @param array $criteria
     * @param Zend_Db_Select $select
     * @return Zend_Db_Table_Select
     */
    public function selectByCriteria(array $criteria, Zend_Db_Select $select = null)
    {
        $columns = $this->getColumns();
        if (null === $select) {
            $select = $this->select(self::SELECT_WITH_FROM_PART);
        }
        $adapter = $this->getAdapter();

        foreach ($criteria as $key => $value) {
            if (in_array($key, $columns)) {
                if (is_null($value)) {
                    $select->where($adapter->quoteIdentifier($key) . ' is null');
                } elseif (is_array($value)) {
                    if (count($value)) {
                        $select->where($adapter->quoteIdentifier($key) . ' in (?)', $value);
                    } else {
                        /* retrieve an empty resultset if no condition is given */
                        $select->where('0');
                    }
                } elseif ($value instanceof Zend_Db_Select) {
                    $select->where($adapter->quoteIdentifier($key) . ' IN (' . $value->assemble() . ')');
                    $bind = array_merge($select->getBind(), $value->getBind());
                    $select->bind($bind);
                } else {
                    $select->where($adapter->quoteIdentifier($key) . ' = ?');
                    $bind = $select->getBind();
                    $bind[] = $value;
                    $select->bind($bind);
                }
            }
        }

        return $select;
    }

    public function createOrGetRowFromData(array $rowData)
    {
        if (is_array($this->_primary) && count($this->_primary) > 1) {
            throw new InvalidArgumentException('compound indexes are not supported');
        } elseif (is_array($this->_primary)) {
            $primary = current($this->_primary);
        } else {
            $primary = $this->_primary;
        }

        if (!array_key_exists($primary, $rowData) || is_null($rowData[$primary])) {
            $row = $this->createRow($rowData);
        } else {
            $row = $this->findByPrimary($rowData[$primary]);
            if (!($row instanceof Zend_Db_Table_Row_Abstract)) {
                // debug commit
                throw new Exception('the ' . $primary . ' ' . $rowData[$primary] . ' was not found in ' . get_class($this));
            }
            $row->setFromArray($rowData);
        }

        return $row;
    }

    /**
     * @param array $criteria
     * @return Bob_Db_Table_Rowset
     */
    public function findAllByCriteria(array $criteria)
    {
        $select = $this->selectByCriteria($criteria);

        return $this->fetchAll($select);
    }

    /**
     * @param array $criteria
     * @return Bob_Db_Table_Row
     */
    public function findOneByCriteria(array $criteria)
    {
        $select = $this->selectByCriteria($criteria);

        return $this->fetchRow($select);
    }

    /**
     * @param array $criteria
     * @param bool $autosaveOnCreate
     * @return Bob_Db_Table_Row
     */
    public function findOrCreateOneByCriteria(array $criteria, $autosaveOnCreate = true)
    {
        $model = $this->findOneByCriteria($criteria);

        if (!($model instanceof Zend_Db_Table_Row_Abstract)) {
            $model = $this->createRow($criteria);
            if ($autosaveOnCreate) {
                $model->save();
            }
        }

        return $model;
    }

    public function getPrimaryKeyName()
    {
        $primaryKeys = $this->info(self::PRIMARY);

        return current($primaryKeys);
    }

    /**
     * @param array $ids
     * @return Bob_Db_Table_Rowset
     */
    public function findByPrimarys(array $ids)
    {
        $primaryKeyName = $this->getPrimaryKeyName();

        return $this->findAllByCriteria(array($primaryKeyName => $ids));
    }

    /**
     * @param int $id
     * @return Bob_Db_Table_Row
     */
    public function findByPrimary($id)
    {
        $primaryKeyName = $this->getPrimaryKeyName();

        return $this->findOneByCriteria(array($primaryKeyName => $id));
    }

    /**
     * @param array $criteria
     * @return bool
     */
    public function exists(array $criteria)
    {
        $result = $this->findOneByCriteria($criteria);

        return ($result instanceof Zend_Db_Table_Row_Abstract);
    }

    /**
     * Checks whether table has column
     *
     * @param string $column
     * @return bool
     */
    public function hasColumn($column)
    {
        return in_array($column, $this->getColumns());
    }

    /**
     * returns the next autoincrement value for the table.
     * if the value is required for inserts, the table should be locked for
     * writes and unlocked afterwards.
     */
    public function getNextAutoincrementId()
    {
        $database = self::getDefaultAdapter();
        $tableStatus = $database->fetchRow('SHOW TABLE STATUS LIKE ?', array($this->getName()));

        return $tableStatus['Auto_increment'];
    }

    public static function getTableInstance($tableName)
    {
        return new Bob_Db_Table(array(
            Zend_Db_Table_Abstract::NAME    => $tableName,
            Zend_Db_Table_Abstract::PRIMARY => 'id_' . $tableName
        ));
    }

    /** static version of hasColum() */
    public static function tableContainsColumn($tableName, $columnName)
    {
        $db = self::getDefaultAdapter();
        $columns = $db->describeTable($tableName);

        return array_key_exists($columnName, $columns);
    }

    /**
     * returns all columns
     * @return array
     */
    public function getColumns()
    {
        return $this->_getCols();
    }

    /**
     * returns filtered columns (e.g. all columns with datatypes "int" or "enum")
     * with available meta-data for given columns if $meta_data is true
     * @param array|string regexp $data_filter
     * @param array|string $column_filter
     * @param boolean $result_type
     * @return array
     */
    public function getColumnsByFilter($datatype_filter = null, $column_filter = null, $result_type = self::COLUMN_NAMES)
    {

        if (is_array($datatype_filter)) {
            $datatype_filter = implode("|", $datatype_filter);
        }

        /* GET COLUMN INFO */

        $cols = $this->info();

        /* APPLY FILTER */

        $matches = Array();

        foreach ($cols['metadata'] as $v) {
            if (!isset($datatype_filter)) {
                $match = true;
            } else {
                /* CHECK WHETHER COLUMN HAS THE RIGHT DATATYPE */
                preg_match('/' . $datatype_filter . '/is', $v['DATA_TYPE'], $m);
                $match = array_key_exists(0, $m);
            }

            if ($match && isset($column_filter)) {
                if (is_array($column_filter)) {
                    /* CHECK WHETHER COLUMN IS PART OF THE COLUMN LIST */
                    $match = in_array($v['COLUMN_NAME'], $column_filter);
                } else {
                    $oldErr = error_reporting(0);
                    /* CHECK WHETHER COLUMN_FILTER REGEXP MATCHES */
                    preg_match('/(' . $column_filter . ')/is', $v['COLUMN_NAME'], $m);
                    $match = array_key_exists(1, $m) ? ($m ? 1 : false) : false;
                    error_reporting($oldErr);
                }
            }

            if ($match) {
                /* ADD COLUMN TO RESULTS */
                if ($result_type == self::COLUMN_METADATA) {
                    $matches[$v['COLUMN_NAME']] = $v;
                } else {
                    $matches[] = $v['COLUMN_NAME'];
                }
            }

        }

        return $matches;
    }

    /**
     * returns enum/set - options for all columns
     * or filtered columns as defined by $column_filter
     * @param array|string $column_filter
     * @return array
     */
    public function getOptionValues($column_filter = null)
    {
        $cols = $this->getColumnsByFilter(Array("enum", "set"), isset($column_filter) ? $column_filter : null, true);
        $out = Array();

        if (!is_array($cols)) {
            return false;
        }

        foreach ($cols as $k => $column) {
            $pattern = "/(enum|set)\\('(.*)'\\)/is";
            preg_match($pattern, $column['DATA_TYPE'], $matches);
            if (array_key_exists(2, $matches)) {
                if ($matches[2]) /* return available option-names if enum/set-values have been found */ {
                    $out[$k] = explode("','", $matches[2]);
                } else
                    /* return an empty array if enum/set-field is empty */ {
                    $out[$k] = Array();
                }
            }
        }

        return $out;
    }

    /**
     * returns metainfo for specified column
     * @author timor kodal <timor.kodal@bigfoot-gmbh.com>
     * @param string $column_name
     * @return array|void
     */
    public function getColumnByName($column_name)
    {
        $info = $this->info();

        if (array_key_exists('metadata', $info)) {
            if (array_key_exists($column_name, $info['metadata'])
            ) {
                return $info['metadata'][$column_name];
            }
        }

        return null;
    }

    /**
     * @see Bob_Factory_Interface::getInstance()
     */
    public function getInstance($id)
    {
        return $this->findByPrimary($id);
    }

    /**
     * @see Countable::count()
     */
    public function count()
    {
        $select = $this->select()->from($this, array('count' => 'COUNT(*)'));
        $row = $this->fetchRow($select);

        return $row['count'];
    }

    /**
     * Returns the description of the given column
     * @param string $column
     * @return string
     */
    public function getDescription($column)
    {
        $row = $this->createRow();

        return $row->getDescription($column);
    }

    /**
     * @return array
     */
    public function getReferenceMap()
    {
        return $this->_referenceMap;
    }

    /**
     * Returns the max. fieldlentgh for the column
     * @param string $columnName
     * @return int|null
     */
    public function getMaxFieldLength($columnName)
    {
        $result = null;
        $metadata = $this->info(Zend_Db_Table::METADATA);

        if (array_key_exists($columnName, $metadata)) {
            $columnMetadata = $metadata[$columnName];

            if (array_key_exists('LENGTH', $columnMetadata)) {
                $result = $columnMetadata['LENGTH'];
            }
        }

        return $result;
    }

    /**
     * Is the column nullable
     * @param string $columnName
     * @return bool|null
     */
    public function isNullable($columnName)
    {
        $result = null;
        $metadata = $this->info(Zend_Db_Table::METADATA);

        if (array_key_exists($columnName, $metadata)) {
            $columnMetadata = $metadata[$columnName];
            if (array_key_exists('NULLABLE', $columnMetadata)) {
                $result = $columnMetadata['NULLABLE'];
            }
        }

        return $result;
    }

    /**
     * Get the enum-values
     * @param string $columnName
     * @return array
     */
    public function getEnumValues($columnName)
    {
        $options = array();
        $metadata = $this->info(Zend_Db_Table::METADATA);

        if (array_key_exists($columnName, $metadata)) {
            $columnMetadata = $metadata[$columnName];

            if (array_key_exists('DATA_TYPE', $columnMetadata)) {
                preg_match("/(enum|set)\\('(.*)'\\)/is", $columnMetadata['DATA_TYPE'], $matches);

                if (array_key_exists(2, $matches)) {
                    if ($matches[2]) {
                        /* return available option-names if enum/set-values have been found */
                        $options = explode("','", $matches[2]);
                    }
                }
            }
        }

        return $options;
    }

    /**
     * Get table name
     * @return string
     */
    public function getName()
    {
        return $this->_name;
    }

    /**
     * returns rowcount matching a given filter
     * @param array|string $where
     * @return int
     */
    public function countByFilter($where = false)
    {
        if (!$where) {
            return $this->count();
        }

        $select = $this->select()->from($this, array('count' => 'COUNT(*)'));

        if (is_array($where)) {
            foreach ($where as $clause=> $bindings) {
                $select->where($clause, $bindings);
            }
        } else {
            $select->where($where);
        }

        $row = $this->fetchRow($select);

        return $row['count'];
    }

    /**
     * @return Zend_Validate
     */
    public function getValidator($columnName)
    {
        $validator = new Zend_Validate();
        $maxLength = $this->getMaxFieldLength($columnName);

        if ($maxLength > 0) {
            $validator->addValidator(new Zend_Validate_StringLength(0, $maxLength), true);
        }

        $options = $this->getEnumValues($columnName);

        if ($options) {
            $validator->addValidator(new Zend_Validate_InArray($options), true);
        }

        return $validator;
    }

    public function getValidatorStack()
    {
        $className = 'Validator_' . str_replace(' ', '_', ucwords(str_replace('_', ' ', $this->getName())));

        if (class_exists($className, false)) {
            return new $className();
        } else {
            return new Bob_Validator_Stack_DbTable($this);
        }
    }

    /**
     * Fetches all rows into an array (thus without creating Zend_Db_Table_Row instances).
     *
     * @param Zend_Db_Table_Select $select The select statement
     * @param int $count The number of rows to return.
     * @param int $offset Start returning after this many rows.
     * @return array The query result as array
     */
    public function fetchAllToArray(Zend_Db_Table_Select $select = null, $count = null, $offset = null)
    {
        if (!$select) {
            $select = $this->select();
        }

        $select->limit($count, $offset);

        return $this->getAdapter()->fetchAll($select->assemble(), $select->getBind(), Zend_Db::FETCH_ASSOC);
    }

    /**
     * Fetches one rows as an array (thus without creating a Zend_Db_Table_Row instance).
     *
     * @param Zend_Db_Table_Select $select The select statement
     * @return array The result row as array
     */
    public function fetchRowToArray(Zend_Db_Table_Select $select)
    {
        return $this->getAdapter()->fetchRow($select->assemble(), $select->getBind(), Zend_Db::FETCH_ASSOC);
    }

    public static function getColumnInfo($columnName = null, $property = null)
    {
        return isset($columnName) ? (isset($property) ? (array_key_exists($property,static::$_columns[$columnName]) ? static::$_columns[$columnName][$property] : null ) : static::$_columns[$columnName]) : static::$_columns;
    }

    public static function getColumnNames()
    {
        return array_keys(static::$_columns);
    }

    public static function getColumnOptions($columnName = null)
    {
        if (isset($columnName)) {
            return static::$_columns[$columnName]["options"];
        } else {
              $out = Array();
               foreach(static::$_columns as $key=>$meta) {
                    if (array_key_exists("options",$meta)) {
                        $out[$key] = $meta["options"];
                    }
                }
                return $out;
        }
    }

}
