<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Cms_FolderTable extends DbTable_Abstract
{

    protected $_name = 'cms_folder';

    protected $_rowClass = 'DbTable_Cms_FolderRow';

    protected $_rowsetClass = 'DbTable_Cms_FolderRowset';

    protected $_primary = 'id_cms_folder';

    protected $_dependentTables = array('DbTable_Cms_ItemTable');

    /**
     * Associative array map of declarative referential integrity rules. This array has
     * one entry per foreign key in the current table. Each key is a mnemonic name for
     * one reference rule.
     *
     * Each value is also an associative array, with the following keys:
     *      - columns       = array of names of column(s) in the child table.
     *      - refTableClass = class name of the parent table.
     *      - refColumns    = array of names of column(s) in the parent table, in the
     * same order as those in the 'columns' entry.
     *      - onDelete      = "cascade" means that a delete in the parent table also
     * causes a delete of referencing rows in the child table.
     *      - onUpdate      = "cascade" means that an update of primary key values in
     * the parent table also causes an update of referencing rows in the child table.
     *
     * @var array
     */
    protected $_referenceMap = array(
        'fk_cms_folder_type' => array(
            'columns' => 'fk_cms_folder_type',
            'refTableClass' => 'DbTable_Cms_Folder_TypeTable',
            'refColumns' => 'id_cms_folder_type'
            ),
        'fk_acl_user' => array(
            'columns' => 'fk_acl_user',
            'refTableClass' => 'DbTable_Acl_UserTable',
            'refColumns' => 'id_acl_user'
            ),
        'fk_store_store' => array(
            'columns' => 'fk_store_store',
            'refTableClass' => 'DbTable_Store_StoreTable',
            'refColumns' => 'id_store_store'
            )
        );

    protected static $_columns = array(
        'id_cms_folder' => array(
            'type' => 'int',
            'extra' => 'auto_increment',
            'length' => 10
            ),
        'fk_cms_folder_type' => array(
            'type' => 'int',
            'length' => 10
            ),
        'fk_acl_user' => array(
            'type' => 'int',
            'length' => 10
            ),
        'key' => array(
            'type' => 'varchar',
            'length' => 255
            ),
        'description' => array(
            'type' => 'varchar',
            'null' => true,
            'length' => 255
            ),
        'is_active' => array(
            'type' => 'tinyint',
            'length' => 1
            ),
        'revision' => array(
            'type' => 'int',
            'length' => 10
            ),
        'created_at' => array(
            'type' => 'timestamp',
            'default' => 'CURRENT_TIMESTAMP'
            ),
        'is_confirmed' => array(
            'type' => 'tinyint',
            'default' => '1',
            'length' => 1
            ),
        'fk_cms_shop' => array(
            'type' => 'int',
            'default' => '1',
            'length' => 10
            ),
        'fk_store_store' => array(
            'type' => 'int',
            'length' => 11
            )
        );


}

