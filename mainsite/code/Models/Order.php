<?php

class Order extends SaltedOrder
{
    /**
     * Database fields
     * @var array
     */
    protected static $db = array(
        'PaidToClass'       =>  'Varchar',
        'PaidToClassID'     =>  'Int'
    );


    public function onSaltedPaymentUpdate($success)
    {
        if ($success) {
            if ($this->PaidToClass == 'PropertyPage') {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($this->PaidToClassID);
                $property->writeToStage('Live');
            }

            if ($this->PaidToClass == 'Member') {
                $member = Member::get()->byID($this->PaidToClassID);
                $member->addToGroupByCode('tradesmen', 'Tradesmen');
            }
        }
    }
}
