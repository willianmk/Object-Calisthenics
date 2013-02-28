<?php

/**
 *
 * @package cms
 */
class Cms_Model_Cms
{

    /**
     * Returns the folder with the given db id (=id_cms_folder) and all its items.
     *
     * @param int $id The id of the folder.
     * @return array|Bob_Api_Result_Failed_WithError
     * Either an error object or an array which holds the folders properties and items.
     */
    public function getFolderById($id)
    {
        $table = new DbTable_Cms_FolderTable();
        $folder = $table->find($id)->current();

        if (!$folder) {
            return array();
        }

        $folderArr = $folder->toArray();
        $folderArr['items'] = $folder->findDependentRowset('DbTable_Cms_ItemTable')->toArray();

        return $folderArr;
    }

    /**
     * Returns all active folders
     *
     * @return array|Bob_Api_Result_Failed_WithError
     * Either an error object or an array which holds the folders properties and items.
     */
    public function getActiveFolders($storeId = null)
    {
        $table = new DbTable_Cms_FolderTable();

        $select = $table->select()->where('cms_folder.is_active = 1')->where('cms_folder.is_confirmed = 1')
            ->order('fk_store_store');

        if (null !== $storeId) {
            $select->where('cms_folder.fk_store_store = ?', $storeId);
        }

        return $table->fetchAll($select);
    }

    /**
     * Returns select statment for all active folders to use in zend pagination
     * @param boolean $drafts Show entries containing drafts?
     * @param integer $shopId Specify ID of shop
     * @return $select //Zend_Db_Select
     */
    public function getActiveFoldersSelect($store, $drafts = false, $shopId = 1)
    {
        $table = new DbTable_Cms_FolderTable();
        $select = $table->getAdapter()->select();
        $selectedTables = array(
            'cms_folder.id_cms_folder',
            'cms_folder.key',
            'cms_folder_type.label',
            'cms_folder.revision',
            'cms_folder.created_at'
        );
        $select->from($table->getName(), $selectedTables)
            ->join('cms_folder_type', 'cms_folder.fk_cms_folder_type = cms_folder_type.id_cms_folder_type', null)
            ->where('cms_folder.is_active = ?', 1)->where('cms_folder.fk_store_store = ?', $store)
            ->where('cms_folder.fk_cms_shop = ?', $shopId)
            ->joinLeft('cms_item', 'cms_item.fk_cms_folder = cms_folder.id_cms_folder', null)->group('cms_folder.key');
        $conditionConfirmed = 1;

        if ($drafts) {
            $conditionConfirmed = 0;
        }

        $select->where('cms_folder.is_confirmed = ?', $conditionConfirmed);
        $select->order(DbTable_Cms_FolderRow::CREATED_AT . ' DESC');

        return $select;
    }

    /**
     * Gets Folders by combination of key and folderType
     *
     * @param string $key
     * @param int $folderType
     * @return array an array which holds the folders properties and items.
     */
    public function getFoldersByKey($key,
            $folderType,
            $withItems = false,
            $withHistory = false,
            $useTypeNames = false,
            $shopId = null,
            $storeId = null)
    {
        $table = new DbTable_Cms_FolderTable();
        $select = $table->select();

        if (!$shopId) {
            $shopId = 1;
        }
        if (!$storeId) {
            $storeId = 1;
        }

        $select->where('cms_folder.key = ?', $key)->where('cms_folder.fk_store_store = ?', $storeId)
            ->where('cms_folder.' . DbTable_Cms_FolderRow::FK_CMS_SHOP . ' = ?', $shopId)->order('created_at DESC');

        if (!$withHistory) {
            $select->where('is_active = ?', 1);
        }

        $folders = $table->fetchAll($select);

        return (empty($folders)) ? array() : $folders->toArray();
    }

    /**
     * Gets Folders by combination of key and revision
     *
     * @param string $key
     * @param int $revision
     * @return array an array which holds the folders properties and items.
     */
    public function getFolderByKeyAndRevision($key, $revision, $storeId = 1)
    {
        $table = new DbTable_Cms_FolderTable();

        $sql = $table->select()
            ->where('cms_folder.key = ?', $key)
            ->where('cms_folder.revision = ?', $revision)
            ->where('cms_folder.fk_store_store = ?', $storeId);
        $folder = $table->fetchRow($sql);

        if (count($folder)) {
            $folderArr = $folder->toArray();
            $folderArr['items'] = $folder->findDependentRowset('DbTable_Cms_ItemTable')->toArray();
            return $folderArr;

        } else {
            return false;
        }
    }

    /**
     * Gets Folder by key
     *
     * @param string $key
     * @return array an array which holds the folders properties and items.
     */
    public function getFolderByKey($key)
    {
        $table = new DbTable_Cms_FolderTable();

        $sql = $table->select()->where('cms_folder.key = ?', $key)->order('revision DESC')->limit(1, 0);
        $folder = $table->fetchRow($sql);

        if (count($folder)) {
            $folderArr = $folder->toArray();
            return $folderArr;

        } else {
            return false;
        }
    }

    /**
     * Gets all Values for a specific Attribute by Attribute-ID (e.g. brand -> adidas,nike,...)
     *
     * @return array
     */
    public function getAttributes()
    {
        $resultArray = array();
        $table = new DbTable_Catalog_AttributeTable();
        $select = $table->select()->order('label ASC');
        $select->where(DbTable_Catalog_AttributeRow::SOLR_FILTER . ' IS NOT NULL');
        $select->where(DbTable_Catalog_AttributeRow::ATTRIBUTE_TYPE . ' in ("option","multi_option")');
        $select->group(DbTable_Catalog_AttributeRow::NAME);

        $rows = $table->fetchAllToArray($select);

        foreach ($rows as $row) {
            $resultArray[] = array(
                'id'    => $row[DbTable_Catalog_AttributeRow::ID_CATALOG_ATTRIBUTE],
                'name'  => $row[DbTable_Catalog_AttributeRow::NAME],
                'label' => $row[DbTable_Catalog_AttributeRow::LABEL]
            );
        }

        return $resultArray;
    }

    /**
     * Build CMS folder key based on folder settings
     *
     * @param array $data
     * @return string
     */
    public function buildFolderKey($data)
    {
        $folderType = $data[DbTable_Cms_FolderRow::FK_CMS_FOLDER_TYPE];

        $key = null;

        switch ($folderType) {
            case 1:
                // home page
                $key = 'homepage';
                break;

            case 3:
                // catalog listing page
                $key = $this->_buildFolderKeyForCatalog($data);
                break;

            default:
                $key = strtolower($data[DbTable_Cms_FolderRow::KEY]);
                break;
        }

        $key = strtr(Utils_Translit::t($key), " ", "_");

        return $key;
    }

    /**
     * Returns an Array with all available folder types
     *
     * @return array
     */
    public function getFolderTypes()
    {
        $folderTypeTable = new DbTable_Cms_Folder_TypeTable();
        $folderTypes = array();

        foreach ($folderTypeTable->fetchAll() as $folderType) {
            $folderTypes[$folderType[DbTable_Cms_Folder_TypeRow::ID_CMS_FOLDER_TYPE]] = $folderType->toArray();
        }

        return $folderTypes;
    }

    /**
     * Returns an Array with all available item types
     *
     * @return array
     */
    public function getItemTypes()
    {
        $itemTypeTable = new DbTable_Cms_Item_TypeTable();
        $itemTypes = array();

        foreach ($itemTypeTable->fetchAll() as $itemType) {
            $itemTypes[$itemType[DbTable_Cms_Item_TypeRow::ID_CMS_ITEM_TYPE]] = $itemType->toArray();
        }

        return $itemTypes;
    }

}
