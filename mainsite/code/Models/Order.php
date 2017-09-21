<?php

class Order extends SaltedOrder
{
    /**
     * Database fields
     * @var array
     */
    protected static $db = array(
        'PaidToClass'           =>  'Varchar',
        'PaidToClassID'         =>  'Int',
        'Landlords'             =>  'Boolean',
        'Realtors'              =>  'Boolean',
        'Tradesmen'             =>  'Boolean',
    );

    protected static $has_one = array(
        'Listing'               =>  'Listing'
    );

    public function PaidFor()
    {
        if ($this->Landlords) {
            return 'Landlord account subscription';
        }

        if ($this->Realtors) {
            return 'Realtor account subscription';
        }

        if ($this->Tradesmen) {
            return 'Tradesperson account subscription';
        }

        $clsname = $this->PaidToClass;
        if ($property = $clsname::get()->byID($this->PaidToClassID)) {
            return 'Listing ' + $property;
        }

        return 'Unknown';
    }

    public function onSaltedPaymentUpdate($success)
    {
        if ($success == 'Success') {
            if ($this->PaidToClass == 'PropertyPage') {
                $property = Versioned::get_by_stage('PropertyPage', 'Stage')->byID($this->PaidToClassID);
                if ($property->ListTilGone) {
                    $property->isPaid = true;
                    $property->writeToStage('Stage');
                }
                $property->writeToStage('Live');
            }

            if ($this->PaidToClass == 'Business') {
                $business = Business::get()->byID($this->PaidToClassID);
                $business->Listed = true;
                $business->write();
            }

            if ($this->PaidToClass == 'Member') {
                $member = Member::get()->byID($this->PaidToClassID);
                if ($this->Landlords) {
                    $member->addToGroupByCode('landlords', 'Landlords');
                }

                if ($this->Realtors) {
                    $member->addToGroupByCode('realtors', 'Realtors');
                }

                if ($this->Tradesmen) {
                    $member->addToGroupByCode('tradesmen', 'Tradesmen');
                }

                $member->beLandlords = false;
                $member->beTradesmen = false;
                $member->beRealtors = false;
                $member->write();

            }
        }
    }
}
