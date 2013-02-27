<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Cms_FolderRow extends Bob_Db_Table_Row
{

    /**
     * @internal int(10) unsigned
     */
    const ID_CMS_FOLDER = 'id_cms_folder';

    /**
     * @internal int(10) unsigned
     */
    const FK_CMS_FOLDER_TYPE = 'fk_cms_folder_type';

    /**
     * @internal int(10) unsigned
     */
    const FK_ACL_USER = 'fk_acl_user';

    /**
     * @internal varchar(255)
     */
    const KEY = 'key';

    /**
     * @internal varchar(255)
     */
    const DESCRIPTION = 'description';

    /**
     * @internal tinyint(1) unsigned
     */
    const IS_ACTIVE = 'is_active';

    /**
     * @internal int(10) unsigned
     */
    const REVISION = 'revision';

    /**
     * @internal timestamp
     */
    const CREATED_AT = 'created_at';

    /**
     * @internal tinyint(1) unsigned
     */
    const IS_CONFIRMED = 'is_confirmed';

    /**
     * @internal int(10) unsigned
     */
    const FK_CMS_SHOP = 'fk_cms_shop';

    /**
     * @internal int(11)
     */
    const FK_STORE_STORE = 'fk_store_store';

    protected $_columnDescription = array(
        'id_cms_folder' => '',
        'fk_cms_folder_type' => '',
        'fk_acl_user' => '',
        'key' => '',
        'description' => '',
        'is_active' => '',
        'revision' => '',
        'created_at' => '',
        'is_confirmed' => '',
        'fk_cms_shop' => '',
        'fk_store_store' => ''
        );

    protected $_tableClass = 'DbTable_Cms_FolderTable';


}

