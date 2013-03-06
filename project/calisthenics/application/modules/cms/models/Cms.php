<?php

/**
 *
 * @package cms
 */
class Cms_Model_Cms
{
    private $folderTable;

    function __construct()
    {
        $this->setFolderTable(new DbTable_Cms_FolderTable());
    }

    public function setFolderTable($folderTable)
    {
        $this->folderTable = $folderTable;
    }

    public function getFolderTable()
    {
        return $this->folderTable;
    }

    /**
     * Returns the folder with the given db id (=id_cms_folder) and all its items.
     *
     * @param int $id The id of the folder.
     * @return array|Bob_Api_Result_Failed_WithError
     * Either an error object or an array which holds the folders properties and items.
     */
    public function getFolderById($id)
    {
        $folder = $this->getFolderTable()->find($id)->current();

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
        $select = $this->getFolderTable()->select()->where('cms_folder.is_active = 1')->where('cms_folder.is_confirmed = 1')
            ->order('fk_store_store');

        if (null !== $storeId) {
            $select->where('cms_folder.fk_store_store = ?', $storeId);
        }

        return $this->getFolderTable()->fetchAll($select);
    }

    /**
     * Returns select statment for all active folders to use in zend pagination
     * @param boolean $drafts Show entries containing drafts?
     * @param integer $shopId Specify ID of shop
     * @return $select //Zend_Db_Select
     */
    public function getActiveFoldersSelect($store, $drafts = false, $shopId = 1)
    {
        $select = $this->getFolderTable()->getAdapter()->select();
        $selectedTables = array(
            'cms_folder.id_cms_folder',
            'cms_folder.key',
            'cms_folder_type.label',
            'cms_folder.revision',
            'cms_folder.created_at'
        );
        $select->from($this->getFolderTable()->getName(), $selectedTables)
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
        $select = $this->getFolderTable()->select();

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

        $folders = $this->getFolderTable()->fetchAll($select);

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

        $sql = $this->getFolderTable()->select()
            ->where('cms_folder.key = ?', $key)
            ->where('cms_folder.revision = ?', $revision)
            ->where('cms_folder.fk_store_store = ?', $storeId);
        $folder = $this->getFolderTable()->fetchRow($sql);

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
        $sql = $this->getFolderTable()->select()->where('cms_folder.key = ?', $key)->order('revision DESC')->limit(1, 0);
        $folder = $this->getFolderTable()->fetchRow($sql);

        if (count($folder)) {
            $folderArr = $folder->toArray();
            return $folderArr;

        } else {
            return false;
        }
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
                $key = 'homepage';
                break;

            case 3:
                $key = $data[DbTable_Cms_FolderRow::DESCRIPTION];
                break;

            default:
                $key = strtolower($data[DbTable_Cms_FolderRow::KEY]);
                break;
        }

        $key = strtr($key, " ", "_");

        return $key;
    }

}
