<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Cms_ItemRow extends Bob_Db_Table_Row
{

    /**
     * @internal int(10) unsigned
     */
    const ID_CMS_ITEM = 'id_cms_item';

    /**
     * @internal int(10) unsigned
     */
    const FK_CMS_FOLDER = 'fk_cms_folder';

    /**
     * @internal int(10) unsigned
     */
    const FK_CMS_ITEM_TYPE = 'fk_cms_item_type';

    /**
     * @internal int(10) unsigned
     */
    const FK_ACL_USER = 'fk_acl_user';

    /**
     * @internal text
     */
    const CONTENT = 'content';

    /**
     * @internal timestamp
     */
    const CREATED_AT = 'created_at';

    protected $_columnDescription = array(
        'id_cms_item' => '',
        'fk_cms_folder' => '',
        'fk_cms_item_type' => '',
        'fk_acl_user' => '',
        'content' => '',
        'created_at' => ''
        );

    protected $_tableClass = 'DbTable_Cms_ItemTable';


}

