<?php

class CmsRepository {

    function __construct() {
        $this->setFolderTable(new DbTable_Cms_FolderTable());
        $this->setItemTable(new DbTable_Cms_ItemTable());
    }

    public function setFolderTable($folderTable) {
        $this->folderTable = $folderTable;
    }

    public function getFolderTable() {
        return $this->folderTable;
    }

    public function findFolderByKey(Cms_Model_Folder $folder) {
        $folderTable = $this->getFolderTable();
        $sql = $folderTable->select()
                ->where('cms_folder.key = ?', $folder->getId())
                ->order('revision DESC')
                ->limit(1, 0);
        $folder = $folderTable->fetchRow($sql);
    }

}