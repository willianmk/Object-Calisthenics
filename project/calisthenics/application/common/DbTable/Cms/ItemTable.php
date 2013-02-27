<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Cms_ItemTable extends DbTable_Abstract
{

    protected $_name = 'cms_item';

    protected $_rowClass = 'DbTable_Cms_ItemRow';

    protected $_rowsetClass = 'DbTable_Cms_ItemRowset';

    protected $_primary = 'id_cms_item';

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
        'fk_cms_folder' => array(
            'columns' => 'fk_cms_folder',
            'refTableClass' => 'DbTable_Cms_FolderTable',
            'refColumns' => 'id_cms_folder'
            ),
        'fk_cms_item_type' => array(
            'columns' => 'fk_cms_item_type',
            'refTableClass' => 'DbTable_Cms_Item_TypeTable',
            'refColumns' => 'id_cms_item_type'
            ),
        'fk_acl_user' => array(
            'columns' => 'fk_acl_user',
            'refTableClass' => 'DbTable_Acl_UserTable',
            'refColumns' => 'id_acl_user'
            )
        );

    protected static $_columns = array(
        'id_cms_item' => array(
            'type' => 'int',
            'extra' => 'auto_increment',
            'length' => 10
            ),
        'fk_cms_folder' => array(
            'type' => 'int',
            'length' => 10
            ),
        'fk_cms_item_type' => array(
            'type' => 'int',
            'length' => 10
            ),
        'fk_acl_user' => array(
            'type' => 'int',
            'length' => 10
            ),
        'content' => array('type' => 'text'),
        'created_at' => array(
            'type' => 'timestamp',
            'default' => 'CURRENT_TIMESTAMP'
            )
        );


}

