<?php

class BoUsersList extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var double
     */
    public $user_id;
    /**
     *
     * @var string
     */
    public $nama;
    /**
     *
     * @var string
     */
    public $jab_id;
    /**
     *
     * @var string
     */
    public $jabatan;
    /**
     *
     * @var string
     */
    public $dept_id;
    /**
     *
     * @var string
     */
    public $department;
    /**
     *
     * @var string
     */
    public $parent;
    /**
     *
     * @var string
     */
    public $username;
    /**
     *
     * @var string
     */
    public $password;
    /**
     *
     * @var string
     */
    public $user_level;


    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("public");
        // $this->setSource("web_vusers_list");
        $this->setSource("bo_users_list");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        // return 'web_vusers_list';
        return 'bo_users_list';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return BoUsersList[]|BoUsersList|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return BoUsersList|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
