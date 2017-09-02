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
        // needs to go
        'TestA'                 =>  'Boolean',
        'TestB'                 =>  'Boolean'
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

        // this needs to go
        if ($this->TestA) {
            return '$1.00 test';
        }

        if ($this->TestB) {
            return '$1.50 test';
        }

        // this needs to go

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

                // this needs to go
                if ($this->TestA) {
                    $member->addToGroupByCode('testa', 'TestA');
                }

                if ($this->TestB) {
                    $member->addToGroupByCode('testb', 'TestB');
                }
                // this needs to go

                $member->beLandlords = false;
                $member->beTradesmen = false;
                $member->beRealtors = false;
                $member->write();

            }
        }
    }
}
